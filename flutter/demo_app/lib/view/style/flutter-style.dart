import 'package:flutter/material.dart';
import 'package:flutter3/color-container/app-style.dart';
import 'package:flutter3/color-container/color-util.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/view/style/button-elevated.dart';
import 'package:flutter3/view/style/button-icon.dart';
import 'package:flutter3/view/style/button.dart';
import 'package:flutter3/view/style/text.dart';

/// 如果有缓存，那么需要使用缓存数据。怎么判断有没有缓存，或者某key为空时。。
ThemeData flutterStyle() {
  // 默认rem计算
  // 名称	典型用途	默认大小（Material 3）
  // displayLarge	页标题（超大）	57
  // displayMedium	页面主标题	45
  // displaySmall	页面副标题	36

  // headlineLarge	大号标题	32
  // headlineMedium	标题	28
  // headlineSmall	副标题	24

  // titleLarge	内容区主标题	22
  // titleMedium	内容区子标题	16
  // titleSmall	小标题	14

  // bodyLarge	正文大	16
  // bodyMedium	正文	14
  // bodySmall	辅助信息	12

  // labelLarge	按钮文本	14
  // labelMedium	辅助按钮文本	12
  // labelSmall	小号按钮文字	11
  TextStyle globalTextStyle = TextStyle(fontSize: AppStyle.byRem(.22),height: 1.5,color: Colors.deepPurpleAccent);
  return ThemeData(
    scaffoldBackgroundColor: ColorUtil.getColor(AppStyle.getContainerStyle("page").bg)??Colors.transparent,
    // 全局页面背景色
    // 点击时的高亮效果设置为透明 长按时的扩散效果设置为透明 以上两者去除按钮点击水波纹
    splashFactory: NoSplash.splashFactory,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    //,background: Colors.grey
    //colorScheme: ColorScheme.fromSeed(seedColor: colorFromHex(AppService().get()!.color)),
    useMaterial3: true,
    /// style 文件夹中添加对应组件的theme获取方法
    textTheme: getTextTheme(),
    textButtonTheme: getTextButtonThemeData(),
    iconButtonTheme: getIconButtonThemeData(),
    elevatedButtonTheme: getElevatedButtonThemeData(),
  );
}
