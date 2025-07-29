import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/color-container/color-util.dart';
import 'package:flutter3/color-container/app-style.dart';

getTextTheme(){
  return TextTheme(
    displayLarge: globalTextStyle,
    displayMedium: globalTextStyle,
    displaySmall: globalTextStyle,
    headlineLarge: globalTextStyle,
    headlineMedium: globalTextStyle,
    headlineSmall: globalTextStyle,
    titleLarge: globalTextStyle,
    titleMedium: globalTextStyle,
    titleSmall: globalTextStyle,
    bodyLarge: globalTextStyle,
    bodyMedium: globalTextStyle,
    bodySmall: globalTextStyle,
    labelLarge: globalTextStyle,
    labelMedium: globalTextStyle,
    labelSmall: globalTextStyle, // Material 3 默认 Text()
  );
}
TextStyle globalTextStyle = TextStyle(fontSize: AppStyle.byRem(.22), height: 1.5, color: ColorUtil.getColor(AppStyle.getFontStyle().txt));
getTextStyle(){
  return globalTextStyle;
}