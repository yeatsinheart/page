import 'package:flutter/material.dart';

class ColorUtil {
  static getColor(v) {
    return colorValue(v);
  }
}

colorValue(value) {
  // 先判空
  if (value == null) return null;
  // 如果不是字符串，直接返回 null 或抛异常也可以
  if (value is! String) return null;
  // 去除首尾空白后判空
  final trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  final str = trimmed.trim().toLowerCase();
  if (str == 'transparent') return const Color(0x00000000);
  // #RGB / #RRGGBB / #RRGGBBAA
  if (str.startsWith('#')) {
    return colorFromHex(str);
  }
  if (str.startsWith("rgba")) return colorFromRgbaStr(str);
  if (str.startsWith("rgb")) return colorFromRgbStr(str);
  return null; // fallback
}

colorFromHex(String str) {
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
  return Color(int.parse(hex, radix: 16));
}

colorFromRgbStr(String str) {
  // rgb()
  final rgbMatch = RegExp(r'^rgb\((\d+),\s*(\d+),\s*(\d+)\)$').firstMatch(str);
  if (rgbMatch != null) {
    final r = int.parse(rgbMatch.group(1)!);
    final g = int.parse(rgbMatch.group(2)!);
    final b = int.parse(rgbMatch.group(3)!);
    return Color.fromARGB(255, r, g, b);
  }
}

colorFromRgbaStr(String str) {
  // rgba()
  final rgbaMatch = RegExp(r'^rgba\((\d+),\s*(\d+),\s*(\d+),\s*([\d.]+)\)$').firstMatch(str);
  if (rgbaMatch != null) {
    final r = int.parse(rgbaMatch.group(1)!);
    final g = int.parse(rgbaMatch.group(2)!);
    final b = int.parse(rgbaMatch.group(3)!);
    final a = (double.parse(rgbaMatch.group(4)!) * 255).round();
    return Color.fromARGB(a, r, g, b);
  }
}
