import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/theme/style-text.dart';

/// 光标大概会超过 3.2dp 预估高度：AppStore.byRem(.66)
var _borderWidth = AppStyle.byRem(.02);
var _padding = AppStyle.byRem(.2);
getInputTheme({fontColor}) {
  return InputDecorationTheme(
    // 设置 isCollapsed: true 时，输入框高度只由 contentPadding 决定，适合你想做非常紧凑的样式。
    isCollapsed: true,isDense: true,
    constraints: BoxConstraints(minWidth: 0, minHeight: 0,),
    contentPadding: EdgeInsets.symmetric(vertical: _padding, horizontal: _padding),//

    // 调整内边距大小
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppStyle.byRem(.14)),
      borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!,width: _borderWidth),
    ),
    // 圆角设置
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!,width: _borderWidth),
      borderRadius: BorderRadius.circular(AppStyle.byRem(.14)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!,width: _borderWidth),
      borderRadius: BorderRadius.circular(AppStyle.byRem(.14)),
    ),

    hoverColor: Colors.transparent,
    // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppStyleStore.getMainColor())),
    // labelStyle: TextStyle(color: AppStyleStore.getMainColor()),

    helperStyle: getTextStyle(),
    errorStyle: getTextStyle(),

    labelStyle: getTextStyle(),
    floatingLabelStyle: getTextStyle(),

    iconColor: fontColor ?? ColorFont.get().txt!,

    prefixStyle: getTextStyle(),
    prefixIconColor: fontColor ?? ColorFont.get().txt!,
    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0,),

    suffixStyle: getTextStyle(),
    suffixIconColor: fontColor ?? ColorFont.get().txt!,
    suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0,),


    filled: true,
    // 开启填充背景
    fillColor: AppStyle.isDark() ? Colors.black : Colors.white,
    // placeholder字色
    hintStyle: getTextStyle(), //
  );
}
