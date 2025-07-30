/*
library themme;

export 'text.dart';
export 'button-elevated.dart';
export 'button-icon.dart';
export 'button-text.dart';
*/

import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/color-style.dart';
import 'package:flutter3/style/theme/button-elevated.dart';
import 'package:flutter3/style/theme/button-icon.dart';
import 'package:flutter3/style/theme/button-text.dart';
import 'package:flutter3/style/theme/text.dart';

/// 如果有缓存，那么需要使用缓存数据。怎么判断有没有缓存，或者某key为空时。。
ThemeData getFlutterTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorStyle.get("page").bg,
    primaryColor: AppStyle.getMainColor(),
    // 全局页面背景色
    // 点击时的高亮效果设置为透明 长按时的扩散效果设置为透明 以上两者去除按钮点击水波纹
    splashFactory: NoSplash.splashFactory,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    //,background: Colors.grey
    //colorScheme: ColorScheme.fromSeed(seedColor: colorFromHex(AppService().get()!.color)),
    useMaterial3: true,

    /// 文件夹中添加对应组件的theme获取方法
    textTheme: getTextTheme(),
    textButtonTheme: getTextButtonThemeData(),
    iconButtonTheme: getIconButtonThemeData(),
    elevatedButtonTheme: getElevatedButtonThemeData(),
  );
}
