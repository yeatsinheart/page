import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/color-font.dart';
var _lineHeight = 1.4;
getTextTheme({Color? fontColor}) {
  TextStyle globalTextStyle = TextStyle(fontSize: AppStyle.byRem(.22), height: _lineHeight, color: fontColor??ColorFont.get().txt);

  TextStyle large = TextStyle(fontSize: AppStyle.byRem(.26), height: _lineHeight, color: fontColor??ColorFont.get().txt);
  TextStyle medium = TextStyle(fontSize: AppStyle.byRem(.22), height: _lineHeight, color: fontColor??ColorFont.get().txt);
  TextStyle small = TextStyle(fontSize: AppStyle.byRem(.18), height: _lineHeight, color: fontColor??ColorFont.get().txt);

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
    labelSmall: globalTextStyle,
    // Material 3 默认 Text()
    // 大标题类
    /*displayLarge: large,
    displayMedium: large,
    displaySmall: large,
    headlineLarge: large,
    headlineMedium: large,
    headlineSmall: medium,

    // 正文类
    titleLarge: medium,
    titleMedium: medium,
    titleSmall: small,

    // 正文正文
    bodyLarge: medium,
    bodyMedium: medium,
    bodySmall: small,

    // 标签、辅助文字
    labelLarge: small,
    labelMedium: small,
    labelSmall: small,*/
  );
}

TextStyle getTextStyle({Color? fontColor}) {
  return  TextStyle(fontSize: AppStyle.byRem(.22),height:_lineHeight, color: fontColor??ColorFont.get().txt);
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
