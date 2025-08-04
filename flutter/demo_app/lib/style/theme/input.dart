import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/color-font.dart';

getInputTheme({fontColor}){
  return InputDecorationTheme(
    // 设置 isCollapsed: true 时，输入框高度只由 contentPadding 决定，适合你想做非常紧凑的样式。
    isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(vertical: AppStore.byRem(.2), horizontal: AppStore.byRem(.2)),
    // 调整内边距大小
    border: OutlineInputBorder(
      borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!),
    ),
    // 圆角设置
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!), borderRadius: BorderRadius.circular(AppStore.byRem(.14)),),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!), borderRadius: BorderRadius.circular(AppStore.byRem(.14)),),
    hoverColor: Colors.transparent,
    // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppStyleStore.getMainColor())),
    // labelStyle: TextStyle(color: AppStyleStore.getMainColor()),
    labelStyle: TextStyle(color: fontColor ?? ColorFont.get().txt!),
  );
}