import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';

byRem(v,context){
  var width = MediaQuery.of(context).size.width;
  return v * width / (750 / 100);
}
/// 如果有缓存，那么需要使用缓存数据。怎么判断有没有缓存，或者某key为空时。。
getThemeData(context) {
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
  TextStyle globalTextStyle = TextStyle(fontSize: byRem(.22,context),height: 1.5,color: Colors.deepPurpleAccent);
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
    textTheme: TextTheme(
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(byRem(.14, context))),
        textStyle: globalTextStyle,
      ),
    ),
  );
}
