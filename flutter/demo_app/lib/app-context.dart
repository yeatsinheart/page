import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/log/logger.dart';

import 'package:get/get.dart';

class AppContext extends GetxService{
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  AppContext._internal();
  static final AppContext _instance = AppContext._internal();
  factory AppContext() => _instance;


  // PlatformDispatcher 是 Flutter 中用于访问和监听平台层事件与信息的一个高级接口。它属于 dart:ui 底层层级，跟视图（View）、窗口（Window）、输入、字体、生命周期等交互紧密相关。
  static final platformDispatcher = PlatformDispatcher.instance;
  // 获取主窗口
  static final screen = platformDispatcher.views.first;
  // 记录当前竖屏宽度，不受横竖屏影响
  static final screenWidth = screen.physicalSize.width / screen.devicePixelRatio;

  // platformDispatcher.onPlatformBrightnessChanged
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Rex');

  static BuildContext get context {
    final ctx = navigatorKey.currentState?.context;
    if (ctx == null) throw Exception('GlobalContext.context is null');
    return ctx;
  }

  Rx<Key> appKey = UniqueKey().obs;
  void rebuildApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏颜色
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark, // 图标颜色，根据背景选择
    ));
    appKey.value = UniqueKey(); // 改变 key，触发 rebuild
  }

  static Brightness brightness = Brightness.light;

  static bool get isDark {
    // Flutter 的亮/暗模式切换是响应式的——只要你的 build 方法里依赖了 MediaQuery.of(context).platformBrightness 或 Theme.of(context).brightness，
    // 系统切换主题时 Widget 会自动重建，你不需要额外订阅事件。

    // 这个值表示系统（操作系统）当前的亮暗模式，是系统层面告诉 Flutter 的。
    // 它不会根据 app 内部切换的主题实时改变，除非系统本身切换了。
    // bool isDarkMode1 = Theme.of(context).brightness == Brightness.dark;
    return brightness==Brightness.dark;
  }

  static setStyleDark() {
    // Log.i("${ Theme.of(context).brightness }");
    if(isDark)return;
    brightness =Brightness.dark;
    AppContext().rebuildApp();
  }

  static setStyleLight() {
    // Log.i("${ Theme.of(context).brightness }");
    if(!isDark)return;
    brightness =Brightness.light;
    AppContext().rebuildApp();
  }


}
