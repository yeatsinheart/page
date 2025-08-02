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
    // 鼠标在按钮点击（按下、悬停、聚焦等）时的覆盖颜色
    // WidgetState.pressed	按下时
    // WidgetState.hovered	鼠标悬停时（Web/Desktop）
    // WidgetState.focused	获得焦点时（键盘导航）
    // WidgetState.disabled	不可点击状态
    // overlayColor: WidgetStateProperty.all(Colors.transparent),
    //   overlayColor: WidgetStateProperty.resolveWith<Color?>(
    //         (Set<WidgetState> states) {
    //       if (states.contains(WidgetState.pressed)) {
    //         return Colors.blue.withOpacity(0.3);
    //       }
    //       if (states.contains(WidgetState.hovered)) {
    //         return Colors.green.withOpacity(0.1);
    //       }
    //       return null; // 默认颜色
    //     },

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
    minimumSize:WidgetStateProperty.all(Size(0, 0)),// 按钮最小限制
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.byRem(.1)),
        side: BorderSide(color: Colors.transparent),
      ),
    ),
  );
}