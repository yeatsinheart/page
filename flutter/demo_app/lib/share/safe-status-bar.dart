import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/app-style.dart';
// statusBarBrightness：影响 iOS 的文字颜色（亮 = 黑字，暗 = 白字）
// statusBarIconBrightness：影响 Android 图标颜色（亮 = 白图标，暗 = 黑图标）
status_bar_color(child,{color}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: color??Colors.transparent, // 设置状态栏颜色
      statusBarIconBrightness: AppStyle.isDark() ? Brightness.dark : Brightness.light,
    ),
    child: child,
  );
}

set_status_bar_color(color){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color??Colors.transparent, // 设置状态栏颜色
    statusBarBrightness: AppStyle.isDark() ? Brightness.dark : Brightness.light,
    statusBarIconBrightness: AppStyle.isDark() ? Brightness.light : Brightness.dark,
  ));
}