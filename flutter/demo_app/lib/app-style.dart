import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/util/color-util.dart';
import 'package:get/get.dart';

class AppStyle extends GetxService {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  AppStyle._internal();
  static final AppStyle _instance = AppStyle._internal();
  factory AppStyle() => _instance;

  // PlatformDispatcher 是 Flutter 中用于访问和监听平台层事件与信息的一个高级接口。它属于 dart:ui 底层层级，跟视图（View）、窗口（Window）、输入、字体、生命周期等交互紧密相关。
  static final platformDispatcher = PlatformDispatcher.instance;
  // 获取主窗口
  static final screen = platformDispatcher.views.first;
  // 记录当前竖屏宽度，不受横竖屏影响
  static final screenWidth = screen.physicalSize.width / screen.devicePixelRatio;

  static String BrightMode = "light"; //"light";// dark
  static isDark(){
    return BrightMode == "dark";
  }
  static setStyleDark() {
    if(isDark())return;
    BrightMode = "dark";
    AppStyle().rebuildApp();
  }

  static setStyleLight() {
    if(!isDark())return;
    BrightMode = "light";
    AppStyle().rebuildApp();
  }

  Rx<Key> appKey = UniqueKey().obs;
  void rebuildApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏颜色
      statusBarBrightness: AppStyle.isDark() ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: AppStyle.isDark() ? Brightness.light : Brightness.dark, // 图标颜色，根据背景选择
    ));
    appKey.value = UniqueKey(); // 改变 key，触发 rebuild
  }


  static Map<String, dynamic> data = {};

  static byPercent(v) {
    // 按宽度的百分比
    return v * viewWidth / 100;
  }

  static byPx(double pxValue) {
    // 750px设计稿中的px大小 等比例 还原
    return pxValue * (viewWidth / 750);
  }

  static byRem(double rem) {
    // 7.5rem=100%;
    // 设计稿 750px
    // 1rem = 100px Html 根元素fontsize
    return rem * 100 * (viewWidth / 750);
  }

  /// 实际宽度
  static double get viewWidth {
    return min(screenWidth, maxWidth ?? screenWidth);
  }

  static double? get maxWidth {
    var value= data["maxWidth"];
    return value is num ? value.toDouble() : null;
  }


  static double get screenHeight {
    // 获取屏幕高度（逻辑像素）
    final screenHeight = screen.physicalSize.height / screen.devicePixelRatio;
    return screenHeight;
    // return MediaQuery.of(AppContext.context).size.height;
  }

  static List<dynamic> getColors() {
    var list = (data["colors"] as List?)?.map((c) => ColorUtil.getColor(c?[AppStyle.BrightMode])).whereType<Color>().toList();
    return list ?? [ColorUtil.getColor("#2196F3")];
  }

  static Color getMainColor() {
    return getColors()[0];
  }

  static double get fontSize{
    return byPx(data["fontSize"]);
  }
  static double get gap{
    return byPx(data["gap"]);
  }
  static double get radius{
    return byPx(data["radius"]);
  }
  static double get lineHeight{
    return data["lineHeight"];
  }
}
