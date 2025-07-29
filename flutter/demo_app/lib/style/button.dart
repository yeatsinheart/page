import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/color-container/color-util.dart';
import 'package:flutter3/color-container/app-style.dart';
import 'package:flutter3/style/text.dart';

getTextButtonThemeData(){
  return TextButtonThemeData(
      style:ButtonStyle(
    textStyle: WidgetStateProperty.all(getTextStyle()),
    // 去除splash水波纹、highlight hover等
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    // 完全禁用点击水波纹动画
    shadowColor: WidgetStateProperty.all(Colors.transparent),
    // 去除阴影
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    // 背景颜色
    //foregroundColor: WidgetStateProperty.all(Colors.blue),
    // 文字颜色
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        //side: BorderSide(color: Colors.blue),
      ),
    ),
  ));
}