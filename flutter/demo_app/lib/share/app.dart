import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/store/language_store.dart';
import 'package:flutter3/_theme_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/app_service.dart';
import '../util/context.dart';

/// 配置获取：运营中最新的配置=>没网或者失败=>本地缓存配置=>没有=>打包时候的配置
class App extends StatelessWidget {
  final Widget child;
  const App({super.key, required this.child});
  // 空界面，方便overlay等设置
  @override
  Widget build(BuildContext context) {
    final languageStore = Get.find<LanguageStore>();
    return GetMaterialApp(
      translations: languageStore.translations,
      locale: parseLocale(languageStore.locale),

      // 默认语言
      //fallbackLocale: Locale('en', 'US'),     // 回退语言
      scrollBehavior: ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch, //移动设备的手指滑动
          PointerDeviceKind.mouse, //鼠标滚轮/拖动
          PointerDeviceKind.trackpad, //触控板
        },
      ),

      navigatorKey: GlobalContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: getThemeData(),
      builder: (context, child) {
        // 延迟设置 title（不会影响 AppBar 的 title）
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(label: AppService().get()!.name.tr, primaryColor: Theme.of(context).primaryColor.value));
        });
        return child!;
      },

      home: child,
      /// 按照路由展示界面
      // onGenerateRoute: (setting) {
      //         return getRoute(setting);
      //       },
    );
  }


  static const _cacheKey = 'cached_config';
  /// 一次编译 → 多次替换 assets/config/default_config.json
  /// ✅ 方法一：配置不打进 asset，用目录或缓存加载
  // Flutter 不打包默认配置
  // 不再用 assets/config/default_config.json，而是加载：
  // /Documents/config/default_config.json（优先）
  // 或内置 defaultConfig（作为 fallback）
  // 打包后的 .ipa 解压后，在 Payload/AppName.app 中加入 config 文件，然后重新签名
  // 这样每次换一个配置，只需重新签名即可，无需重新编译
  // ❗️这依赖非标准流程，只适合内部测试包，不适合 App Store 分发。

  /// 3. 打包后注入配置（区分平台）
  // ✅ Android
  // 解压 .apk 或 .aab
  // 把你想替换的 config.json 放到 /assets 或 /res/raw 或 /sdcard/...
  // 或 直接写入 data/data/<pkg>/files/config.json 目录（如通过脚本 push）
  //
  // ✅ iOS（更特殊）
  // 解压 .ipa 得到 Payload/
  // 在 Payload/YourApp.app/ 内写入 config.json
  // 注意重新签名（可用 fastlane, ios-deploy, codesign 等工具）

  static const _assetPath = 'assets/config/default_config.json';

  /// 加载配置
  static Future<Map<String, dynamic>> loadConfig() async {
    // 1. 尝试拉取网络配置
    final remote = await _loadRemote().catchError((e) => null);
    if (remote != null) {
      await _saveCache(remote);
      return remote;
    }

    // 2. 尝试读取本地缓存
    final cache = await _loadCache();
    if (cache != null) return cache;

    // 3. 加载打包内置配置
    final asset = await _loadAsset();
    return asset;
  }

  /// 获取远程配置
  static Future<Map<String, dynamic>> _loadRemote() async {
    final dio = Dio();
    final response = await dio.get('https://your-config-url.com/config.json');
    return response.data;
  }

  /// 保存缓存
  static Future<void> _saveCache(Map<String, dynamic> config) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_cacheKey, json.encode(config));
  }

  /// 读取本地缓存
  static Future<Map<String, dynamic>?> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_cacheKey);
    if (jsonStr == null) return null;
    return json.decode(jsonStr);
  }

  /// 读取内置配置 统一读取流程（安卓/iOS 通用）
  static Future<Map<String, dynamic>> _loadAsset() async {
    final str = await rootBundle.loadString(_assetPath);
    return json.decode(str);

    /*
    // 在 Android 上，它对应的实际路径是：/data/data/包名/app_support/
    try {
  final dir = await getApplicationSupportDirectory();
  final file = File('${dir.path}/custom_config.json');
  if (await file.exists()) return jsonDecode(await file.readAsString());
} catch (_) {}
    final dir = await getApplicationSupportDirectory();
  final configFile = File('${dir.path}/custom_config.json');

  if (await configFile.exists()) {
    return jsonDecode(await configFile.readAsString());
  }

  // fallback: assets/default_config.json  安卓和web
  final assetStr = await rootBundle.loadString('assets/config/default_config.json');
  return jsonDecode(assetStr);
    * */
  }
}
