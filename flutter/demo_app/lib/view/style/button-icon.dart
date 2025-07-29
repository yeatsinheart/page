import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/color-container/color-util.dart';
import 'package:flutter3/color-container/app-style.dart';

getIconButtonThemeData(){
  return IconButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(globalTextStyle),
      //iconSize: WidgetStateProperty.all(28), // 图标大小
      //padding: WidgetStateProperty.all(EdgeInsets.all(8)), // 内边距
      foregroundColor: WidgetStateProperty.all(Colors.blue), // 图标颜色
      //shape: WidgetStateProperty.all(CircleBorder()), // 形状（例如圆形）
      backgroundColor: WidgetStateProperty.all(Colors.transparent), // 背景色（可选）
      // 去除splash水波纹、highlight hover等
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
  );
}
TextStyle globalTextStyle = TextStyle(fontSize: AppStyle.byRem(.22), height: 1.5, color: ColorUtil.getColor(AppStyle.getFontStyle().txt));
