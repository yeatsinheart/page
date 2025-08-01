import 'package:flutter/material.dart';

class ColorUtil {
  static Color? getColor(dynamic v) {
    return colorValue(v);
  }
}

Color? colorValue(dynamic value) {
  if (value == null) return null;
  if (value is! String) return null;
  final trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  final str = trimmed.toLowerCase();
  if (str == 'transparent') return const Color(0x00000000);
  if (str.startsWith('#')) return colorFromHex(str);
  if (str.startsWith('rgba')) return colorFromRgbaStr(str);
  if (str.startsWith('rgb')) return colorFromRgbStr(str);
  return null;
}

Color? colorFromHex(String str) {
  String hex = str.substring(1);
  if (hex.length == 3) {
    // #abc -> #aabbcc
    hex = hex.split('').map((c) => '$c$c').join();
  }
  if (hex.length == 6) {
    // CSS RRGGBB -> Flutter AARRGGBB (opaque)
    hex = 'FF$hex';
  } else if (hex.length == 8) {
    // CSS RRGGBBAA -> Flutter AARRGGBB
    hex = hex.substring(6, 8) + hex.substring(0, 6);
  } else {
    // 不支持长度，返回null或抛异常也行
    return null;
  }
  try {
    return Color(int.parse(hex, radix: 16));
  } catch (_) {
    return null;
  }
}

Color? colorFromRgbStr(String str) {
  final rgbMatch = RegExp(r'^rgb\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*\)$').firstMatch(str);
  if (rgbMatch != null) {
    final r = int.parse(rgbMatch.group(1)!);
    final g = int.parse(rgbMatch.group(2)!);
    final b = int.parse(rgbMatch.group(3)!);
    if ([r, g, b].every((v) => v >= 0 && v <= 255)) {
      return Color.fromARGB(255, r, g, b);
    }
  }
  return null;
}

Color? colorFromRgbaStr(String str) {
  final rgbaMatch = RegExp(r'^rgba\(\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*(\d{1,3})\s*,\s*([\d.]+)\s*\)$').firstMatch(str);
  if (rgbaMatch != null) {
    final r = int.parse(rgbaMatch.group(1)!);
    final g = int.parse(rgbaMatch.group(2)!);
    final b = int.parse(rgbaMatch.group(3)!);
    final alphaDouble = double.tryParse(rgbaMatch.group(4)!);
    if (alphaDouble != null && alphaDouble >= 0 && alphaDouble <= 1) {
      final a = (alphaDouble * 255).round();
      if ([r, g, b].every((v) => v >= 0 && v <= 255)) {
        return Color.fromARGB(a, r, g, b);
      }
    }
  }
  return null;
}
