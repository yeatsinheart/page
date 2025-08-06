import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/util/color-util.dart';
import 'package:get/get.dart';

class AppStyle extends GetxService {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  AppStyle._internal();
  static final AppStyle _instance = AppStyle._internal();
  factory AppStyle() => _instance;

  static String Brightness = "light"; //"light";// dark
  static isDark(){
    return Brightness == "dark";
  }
  static setStyleDark() {
    if(isDark())return;
    Brightness = "dark";
    AppStyle().rebuildApp();
  }

  static setStyleLight() {
    if(!isDark())return;
    Brightness = "light";
    AppStyle().rebuildApp();
  }

  Rx<Key> appKey = UniqueKey().obs;

  void rebuildApp() {
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
    return min(_screenWidth, maxWidth ?? _screenWidth);
  }

  static double? get maxWidth {
    var value= data["maxWidth"];
    return value is num ? value.toDouble() : null;
  }

  static double get _screenWidth {
    // 获取屏幕逻辑宽度
    final platformDispatcher = PlatformDispatcher.instance;
    // 获取主视图 FlutterView
    final flutterView = platformDispatcher.views.first;
    // 获取屏幕宽度（逻辑像素）
    final screenWidth = flutterView.physicalSize.width / flutterView.devicePixelRatio;
    // return MediaQuery.of(AppContext.context).size.width;
    return screenWidth;
  }

  static double get screenHeight {
    // 获取屏幕逻辑高度
    final platformDispatcher = PlatformDispatcher.instance;
    // 获取主视图 FlutterView
    final flutterView = platformDispatcher.views.first;
    // 获取屏幕高度（逻辑像素）
    final screenHeight = flutterView.physicalSize.height / flutterView.devicePixelRatio;
    return screenHeight;
    // return MediaQuery.of(AppContext.context).size.height;
  }

  static List<dynamic> getColors() {
    var list = (data["colors"] as List?)?.map((c) => ColorUtil.getColor(c?[AppStyle.Brightness])).whereType<Color>().toList();
    return list ?? [ColorUtil.getColor("#2196F3")];
  }

  static Color getMainColor() {
    return getColors()[0];
  }
}
