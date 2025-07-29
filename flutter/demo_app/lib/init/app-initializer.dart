import 'dart:convert';

import 'package:flutter3/store/host-status.dart';
import 'package:flutter3/store/language.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/service/cache.dart';

import 'package:flutter3/request/api.dart';

import '../style/app-style.dart';
/// 聚合请求封装 启动协调
class AppInitializer {
  AppInitializer._internal();
  static final AppInitializer _instance = AppInitializer._internal();
  factory AppInitializer() => _instance;

  static const table = 'default_config';
  static const key = 'all';
  static Map<String,dynamic> data = {};

  // 将配置分发到各个store
  static _dispatch(Map<String,dynamic> config) async {
    data = config;
    // 手动初始化 初始化成功后 才注册到Getx中
    // 调用多次 Get.putAsync<GlobalConfigStore>，实际上最新的实例会覆盖旧的，GetX 只会保存一个。
    // await Future.wait([
    //  // Get.putAsync(() => GlobalConfigStore().init()),
    //   Get.putAsync(() => HostStatusStore().init()),
    //       ()async{Get.put(LanguageStore());}(),// 依赖线路接口。。。哎，前提是要有线路
    // ]);
    //Get.find<HostStatusStore>();
    Get.put(HostStatusStore());
    Get.put(LanguageStore());
    HostStatusStore().listen(config["host"]);// 通用 线路 CDN Websocket
    LanguageStore().listen(config["language"]);

    //LanguageService().updateByJson(config["language"]);

    await Future.wait<dynamic>([
    ]);
    AppStyle.style=config["style"];
  }
  static init() async{
    await _dispatch(await _get());
  }
  /// 加载配置
  static Future<Map<String, dynamic>> _get() async {
    // 1. 尝试拉取网络配置 异步更新
    _updateAsync();

    // 2. 尝试读取本地缓存
    final cache = await CacheService.get(table, key);
    if (cache != null) return jsonDecode(cache);

    // 3. 加载打包内置配置
    final asset = await _loadBuildIn();

    return asset;
  }

  /// 获取远程配置
  static _updateAsync() async {
    try {
      // 最好是Api调用
      Map<String, dynamic>? remote = await Api.init(null);
      if (remote != null) {
        CacheService.set(table, key, jsonEncode(remote));
      }
    } catch (e) {
      // 忽略错误或打印日志
      Log.e("获取远程配置出错，所以取消");
    }
  }

  /// 读取内置配置 统一读取流程（安卓/iOS 通用）
  static Future<Map<String, dynamic>> _loadBuildIn() async {
    final str = await _readBuildInConfig();
    return json.decode(str!);
  }

  static Future<String?> _readBuildInConfig() async {
    if (kIsWeb) {
      //String path = 'assets/config/default_config.json'; 感觉会自动加 assets/ 导致加载时是assets/assets/config/default_config.json
      String path = 'config/default_config.json'; //   Web 运行时 会自动加前缀 assets/
      try {
        final result = await rootBundle.loadString(path);
        return result;
      } catch (e) {
        print('[Web] 读取 $path 失败: $e');
        return null;
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      String path = 'assets/config/default_config.json';
      try {
        final result = await rootBundle.loadString(path); //
        return result;
      } catch (e) {
        print('[Android}] 读取 $path 失败: $e');
        return null;
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // 考虑ios复用2进制时打包写入方式
      const channel = MethodChannel('default_config');
      try {
        final result = await channel.invokeMethod<String>('loadConfigJson');
        return result;
      } catch (e) {
        print('[iOS] 读取 config.json 失败: $e');
        return null;
      }
    } else {
      print('Unsupported platform');
      return null;
    }
  }
}
