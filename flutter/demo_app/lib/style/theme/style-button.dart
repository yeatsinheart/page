import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/theme/style-text.dart';

globalButtonStyle({Color? fontColor}){
  return ButtonStyle(

    // 去除splash水波纹、highlight hover等
    // 完全禁用点击水波纹动画
    // splashFactory: NoSplash.splashFactory,
    // surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
    // 鼠标在上面时的周围阴影
    // overlayColor: WidgetStateProperty.all(Colors.transparent),

    //数值越大，阴影越大、越明显，看起来就像“悬浮”得更高。
    elevation: WidgetStateProperty.all(0),
    // 去除阴影
    shadowColor: WidgetStateProperty.all(Colors.transparent),
    // 背景颜色
    backgroundColor: WidgetStateProperty.all(Colors.transparent),
    // 文字颜色
    foregroundColor: WidgetStateProperty.all(fontColor??ColorFont.get().txt),
    textStyle: WidgetStateProperty.all(getTextStyle(fontColor: fontColor)),

    padding: WidgetStateProperty.all(EdgeInsets.all(0)),

    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.byRem(.1)),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
  );
}