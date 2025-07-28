import 'package:flutter/material.dart';
import 'package:flutter3/share/context.dart';

class ParsedColor {
  final Color? color;
  final Gradient? gradient;
  ParsedColor({this.color, this.gradient});
  bool get isGradient => gradient != null;
  bool get isColor => color != null;
}
Alignment _parseAlignment(String name) {
  switch (name) {
    case 'topLeft': return Alignment.topLeft;
    case 'topRight': return Alignment.topRight;
    case 'bottomLeft': return Alignment.bottomLeft;
    case 'bottomRight': return Alignment.bottomRight;
    case 'topCenter': return Alignment.topCenter;
    case 'bottomCenter': return Alignment.bottomCenter;
    case 'centerLeft': return Alignment.centerLeft;
    case 'centerRight': return Alignment.centerRight;
    case 'center': default: return Alignment.center;
  }
}
Gradient _buildGradient(Map<String, dynamic> json) {
  final colors = (json['colors'] as List).map((c) => colorValue(c).color!).toList();
  final List<double>? stops = (json['stops'] as List?)?.map((e) {
    if (e is double) return e;
    if (e is int) return e.toDouble();
    if (e is String) return double.tryParse(e) ?? 0.0;
    return 0.0;
  }).toList();
  final begin = _parseAlignment(json['begin'] ?? 'topLeft');
  final end = _parseAlignment(json['end'] ?? 'bottomRight');

  return LinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
  );
}
ParsedColor colorValue(dynamic value) {
  if (value == null) return ParsedColor(color: null);

  if (value is Map<String, dynamic> && value['colors'] != null) {
    // Gradient 对象解析
    //final gradientMap = Map<String, dynamic>.from(value);
    return ParsedColor(gradient: _buildGradient(value));
  }

  if (value is String) {
    final str = value.trim().toLowerCase();
    if (str == 'transparent') {
      return ParsedColor(color: const Color(0x00000000));
    }
    // #RGB / #RRGGBB / #RRGGBBAA
    if (str.startsWith('#')) {
      String hex = str.substring(1);
      if (hex.length == 3) {
        hex = hex.split('').map((c) => '$c$c').join(); // #abc -> #aabbcc
      }
      if (hex.length == 6) {
        // CSS标准：RRGGBB -> AARRGGBB
        hex = 'FF$hex';
      } else if (hex.length == 8) {
        // CSS: RRGGBBAA -> Flutter: AARRGGBB
        hex = hex.substring(6, 8) + hex.substring(0, 6);
      }
      return ParsedColor(color: Color(int.parse(hex, radix: 16)));
    }
    // rgb()
    final rgbMatch = RegExp(r'^rgb\((\d+),\s*(\d+),\s*(\d+)\)$').firstMatch(str);
    if (rgbMatch != null) {
      final r = int.parse(rgbMatch.group(1)!);
      final g = int.parse(rgbMatch.group(2)!);
      final b = int.parse(rgbMatch.group(3)!);
      return ParsedColor(color: Color.fromARGB(255, r, g, b));
    }

    // rgba()
    final rgbaMatch = RegExp(r'^rgba\((\d+),\s*(\d+),\s*(\d+),\s*([\d.]+)\)$').firstMatch(str);
    if (rgbaMatch != null) {
      final r = int.parse(rgbaMatch.group(1)!);
      final g = int.parse(rgbaMatch.group(2)!);
      final b = int.parse(rgbaMatch.group(3)!);
      final a = (double.parse(rgbaMatch.group(4)!) * 255).round();
      return ParsedColor(color: Color.fromARGB(a, r, g, b));
    }
  }

  return ParsedColor(color: null); // fallback
}

getThemeData() {
  var style= {
    "font": {"size": 0.22,"line-height":1.2,
      "color":{"title": "#fff","name": "","txt": "","ghost": ""}
    },
    // 颜色值支持多种格式：可以为：null transparent=#00000000 hex简写#000 hex标准#FFFFFF hex带alpha#FFFFFF1A rgb(255, 0, 0) rgba(255, 0, 0, 0.5) gradient对象
    "browser-bg": "","bg": "","mask": "", "border": "","shadow": "",
    "gradient": {"colors": [],"stops": [],"center": "","begin": "","end": ""},

    "colors": [],
    "container": {
      "browser": {"bg": "","font":{}, "border": "","shadow": null,"mask": null},
      "page": {"bg": "","font":{}, "border": "","shadow": null,"mask": null},
      "div1": {"bg": "","font":{}, "border": "","shadow": null,"mask": null},
      "div2":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null},
      "div3":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null},

      "bar":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null},
      "bar-brand":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null},
      "bar-bottom":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null},

      "icon-close":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null},

      "btn-color1":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null},
      "btn-color1-reverse":  {"bg": "","font":{}, "border": "","shadow": null,"mask": null}
    }
  };

   //TextStyle fontSize = TextStyle(fontSize: AppStyle.getRem(.22));
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
