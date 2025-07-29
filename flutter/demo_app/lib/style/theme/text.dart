import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/util/color-util.dart';

getTextTheme() {
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

getTextStyle() {
  return globalTextStyle;
}

// 默认rem计算
// 名称	典型用途	默认大小（Material 3）
// displayLarge	页标题（超大）	57
// displayMedium	页面主标题	45
// displaySmall	页面副标题	36

// headlineLarge	大号标题	32
// headlineMedium	标题	28
// headlineSmall	副标题	24

// titleLarge	内容区主标题	22
// titleMedium	内容区子标题	16
// titleSmall	小标题	14

// bodyLarge	正文大	16
// bodyMedium	正文	14
// bodySmall	辅助信息	12

// labelLarge	按钮文本	14
// labelMedium	辅助按钮文本	12
// labelSmall	小号按钮文字	11
