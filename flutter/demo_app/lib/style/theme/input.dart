import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/theme/style-text.dart';

/// 光标大概会超过 3.2dp 预估高度：AppStore.byRem(.66)
var _borderWidth = AppStyle.byRem(0);
var _padding = AppStyle.byRem(.2);

getInputTheme({fontColor}) {

  InputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!,width: 0),
    borderRadius: BorderRadius.circular(AppStyle.radius),
  );

// border=InputBorder.none;

// 这个差异的原因是 TextField 内部的 InputDecorator 会根据 isDense、hintText、labelText 等字段动态调整 contentPadding。
// TextField 默认行为导致的：
// 没有 hintText → TextField 的 InputDecoration 会在 contentPadding 上使用一个相对较小的默认值，所以光标高度跟输入框的高度刚好匹配，看起来光标垂直居中在边框内。
// 有 hintText → Flutter 会把 contentPadding 调整得更大（尤其是 bottom padding），以便给 hint 文本留空间，结果光标整体被抬高或下移，导致看起来“超过了下边框”。
  final double fontSize = 14;
  final double verticalPadding = (48 - fontSize) / 2; // 48 是总高度
  var txt = getTextStyle();
  return InputDecorationTheme(
    // 设置 isCollapsed: true 时，输入框高度只由 contentPadding 决定，适合你想做非常紧凑的样式。
    isCollapsed: true,isDense: true,
    constraints: BoxConstraints(minWidth: 0, minHeight: 0,),
    /// 有hintText时 bottom = 2 top
    // contentPadding: EdgeInsets.only(left: 14,right:14,bottom: 6,top:3),
    /// 没有有hintText时 bottom = top
    // contentPadding: EdgeInsets.only(left: 14,right:14,bottom: 6,top:3),

    // 调整内边距大小
    // 圆角设置
    border: border,
    enabledBorder: border,
    focusedBorder: border,
    disabledBorder: border,

    hoverColor: Colors.transparent,
    // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppStyleStore.getMainColor())),
    // labelStyle: TextStyle(color: AppStyleStore.getMainColor()),

    helperStyle: txt,
    errorStyle: txt,
    labelStyle: txt,
    floatingLabelStyle: txt,
    iconColor: fontColor ?? ColorFont.get().txt!,

    prefixStyle: txt,
    prefixIconColor: fontColor ?? ColorFont.get().txt!,
    prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0,),

    suffixStyle: txt,
    suffixIconColor: fontColor ?? ColorFont.get().txt!,
    suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0,),


    filled: true,
    // 开启填充背景
    //fillColor: AppContext.isDark ? Colors.black.withValues(alpha: .3) : Colors.white.withValues(alpha: .3),
    // placeholder字色
    hintStyle: getTextStyle(), //
  );
}
