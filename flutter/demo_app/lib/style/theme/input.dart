import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/theme/style-text.dart';

getInputTheme({fontColor}) {
  return InputDecorationTheme(
    // 设置 isCollapsed: true 时，输入框高度只由 contentPadding 决定，适合你想做非常紧凑的样式。
    isCollapsed: true,isDense: true,
    constraints: BoxConstraints(minWidth: 0, minHeight: 0,),

    contentPadding: EdgeInsets.symmetric(vertical: AppStore.byRem(.2), horizontal: AppStore.byRem(.2)),

    // 调整内边距大小
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppStore.byRem(.14)),
      borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!),
    ),
    // 圆角设置
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!),
      borderRadius: BorderRadius.circular(AppStore.byRem(.14)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!),
      borderRadius: BorderRadius.circular(AppStore.byRem(.14)),
    ),

    hoverColor: Colors.transparent,
    // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppStyleStore.getMainColor())),
    // labelStyle: TextStyle(color: AppStyleStore.getMainColor()),
    labelStyle: getTextStyle(),
    floatingLabelStyle: getTextStyle(),
    helperStyle: getTextStyle(),
    errorStyle: getTextStyle(),

    iconColor: fontColor ?? ColorFont.get().txt!,

    prefixStyle: getTextStyle(),
    prefixIconColor: fontColor ?? ColorFont.get().txt!,
    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0,),

    suffixStyle: getTextStyle(),
    suffixIconColor: fontColor ?? ColorFont.get().txt!,
    suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0,),



    filled: true,
    // 开启填充背景
    fillColor: AppStore.Brightness == "dark" ? Colors.black : Colors.white,
    // 背景色
    hintStyle: getTextStyle(), // placeholder字色
  );
}
