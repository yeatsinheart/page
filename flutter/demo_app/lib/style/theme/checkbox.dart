import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/color-font.dart';

getCheckBoxTheme({Color? fontColor}){
  return CheckboxThemeData(
    /** [WidgetState.selected].
        ///  * [WidgetState.hovered].
        ///  * [WidgetState.focused].
        ///  * [WidgetState.disabled].*/
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyle.byRem(.14))),
      side: BorderSide(color: fontColor ?? ColorFont.get().txt!),
      //overlayColor: WidgetStateProperty.all(AppStyle.getMainColor().withOpacity(0.2)),
      // 选中后颜色 √ 勾的颜色（前景色）
      checkColor: WidgetStateProperty.all( AppStyle.getMainColor()),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppStyle.getMainColor().withValues(alpha: .2); // 背景色
        }
        return Colors.transparent;
      }));
}