import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter3/store/language.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'service/app_service.dart';
import 'service/network_service.dart';
import 'util/context.dart';

import 'views.dart';

void main() async {
  // 默认输屏
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
  //Flutter 中存在三棵树，Widget[虚拟的结构]、Element 和 RenderObject。
  WidgetsFlutterBinding.ensureInitialized();
  //debugPaintSizeEnabled = true; // ✅ 开启边界调试 会把所有东西，边距什么的都画线
  // 多语言初始化
  await Get.putAsync(() => Language().init());
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

// 空界面，方便overlay等设置
  @override
  Widget build(BuildContext context) {
    final langService = Get.find<Language>();
    return GetMaterialApp(
      translations: langService.translations,
      locale: Locale('en', 'US'),             // 默认语言
      //fallbackLocale: Locale('en', 'US'),     // 回退语言
      // 多语言
      // 通过GETX 实现多语言 https://juejin.cn/post/7205417093973590071

      // https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
      //https://book.flutterchina.club/chapter13/multi_languages_support.html#_13-1-4-%E7%9B%91%E5%90%AC%E7%B3%BB%E7%BB%9F%E8%AF%AD%E8%A8%80%E5%88%87%E6%8D%A2
      //https://juejin.cn/post/7019679538778996749
      // localizationsDelegates: [
      //   // 本地化的代理类
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      //localizationsDelegates: AppLocalizations.localizationsDelegates,
      //supportedLocales: AppLocalizations.supportedLocales,
      // supportedLocales: [
      //   const Locale('en', 'US'), // 美国英语
      //   const Locale('zh', 'CN'), // 中文简体
      //   //其他Locales
      // ],
      //locale: const  Locale('zh', 'CN'),

      scrollBehavior: ScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      navigatorKey: GlobalContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: AppService().get()!.name.tr,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // 全局页面背景色
        // 点击时的高亮效果设置为透明 长按时的扩散效果设置为透明 以上两者去除按钮点击水波纹
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        //,background: Colors.grey
        //colorScheme: ColorScheme.fromSeed(seedColor: colorFromHex(AppService().get()!.color)),
        useMaterial3: true,
      ),
      onGenerateRoute: (setting) {
        return getRoute(setting);
      },
    );
  }
}
