import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/app-style.dart';

status_bar_color(child,{color}) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: color??Colors.transparent, // 设置状态栏颜色
      statusBarIconBrightness: AppStyle.isDark() ? Brightness.dark : Brightness.light, // 图标颜色，根据背景选择
    ),
    child: child,
  );
}