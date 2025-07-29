import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/theme/text.dart';

getElevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // 去除splash水波纹、highlight hover等
      splashFactory: NoSplash.splashFactory,
      overlayColor: Colors.transparent,
      elevation: 0,
      //数值越大，阴影越大、越明显，看起来就像“悬浮”得更高。
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white,
      // 背景颜色
      // foregroundColor: Colors.blue,// 字体颜色
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyle.byRem(.14))),
      textStyle: getTextStyle(),
    ),
  );
}
