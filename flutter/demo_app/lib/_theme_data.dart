import 'package:flutter/material.dart';
import 'package:flutter3/share/context.dart';

getThemeData() {
   //TextStyle fontSize = TextStyle(fontSize: GlobalContext.getRem(.22));
   TextStyle fontSize = TextStyle(fontSize: 16);
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // 全局页面背景色
    // 点击时的高亮效果设置为透明 长按时的扩散效果设置为透明 以上两者去除按钮点击水波纹
    splashFactory: NoSplash.splashFactory,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    //,background: Colors.grey
    //colorScheme: ColorScheme.fromSeed(seedColor: colorFromHex(AppService().get()!.color)),
    useMaterial3: true,
    textTheme:  TextTheme(
      displayLarge: fontSize,
      displayMedium: fontSize,
      displaySmall:fontSize,
      headlineLarge: fontSize,
      headlineMedium: fontSize,
      headlineSmall: fontSize,
      titleLarge: fontSize,
      titleMedium: fontSize,
      titleSmall: fontSize,
      bodyLarge: fontSize,
      bodyMedium: fontSize,
      bodySmall: fontSize,
      labelLarge: fontSize,
      labelMedium: fontSize,
      labelSmall: fontSize,// Material 3 默认 Text()
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // 去除splash水波纹、highlight hover等
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        // 完全禁用点击水波纹动画
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        // 去除阴影
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        // 背景颜色
        //foregroundColor: WidgetStateProperty.all(Colors.blue),
        // 文字颜色
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            //side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        //iconSize: WidgetStateProperty.all(28), // 图标大小
        //padding: WidgetStateProperty.all(EdgeInsets.all(8)), // 内边距
        foregroundColor: WidgetStateProperty.all(Colors.blue), // 图标颜色
        //shape: WidgetStateProperty.all(CircleBorder()), // 形状（例如圆形）
        backgroundColor: WidgetStateProperty.all(Colors.transparent), // 背景色（可选）
        // 去除splash水波纹、highlight hover等
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        // 去除splash水波纹、highlight hover等
        splashFactory: NoSplash.splashFactory,
        overlayColor: Colors.transparent,
        elevation: 0,
        //数值越大，阴影越大、越明显，看起来就像“悬浮”得更高。
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        // 背景颜色
        // foregroundColor: Colors.blue,// 字体颜色
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(fontSize: 14),
      ),
    ),
  );
}
