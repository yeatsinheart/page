import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/color-font.dart';

getCheckBoxTheme({Color? fontColor}){
  return CheckboxThemeData(
    /** [WidgetState.selected].
        ///  * [WidgetState.hovered].
        ///  * [WidgetState.focused].
        ///  * [WidgetState.disabled].*/
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStore.byRem(.14))),
      side: BorderSide(color: fontColor ?? ColorFont.get().txt!),
      //overlayColor: WidgetStateProperty.all(AppStyleStore.getMainColor().withOpacity(0.2)),
      // 选中后颜色 √ 勾的颜色（前景色）
      checkColor: WidgetStateProperty.all( AppStore.getMainColor()),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppStore.getMainColor().withValues(alpha: .2); // 背景色
        }
        return Colors.transparent;
      }));
}