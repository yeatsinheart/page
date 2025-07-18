import 'package:flutter/material.dart';
import 'dart:math';

Color color = Colors.white;

HSLColor hsl = HSLColor.fromColor(color);
HSVColor hsv = HSVColor.fromColor(color);
// 色的亮度 color.computeLuminance() *2 > 255 ? '#000000': '#ffffff';  明暗色字体对应颜色
colorFromHex(String hex) {
  hex = hex.toUpperCase().replaceAll("#", "");
  if (hex.length == 3) {
    hex = "" + hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
  }
  int a = 255;
  if (hex.length == 8) {
    a = int.parse(hex.substring(6), radix: 16) ~/ 1;
    hex = hex.substring(0, 6);
  }
  return Color(int.parse(hex, radix: 16)).withAlpha(a);
}

rgbFromHex(String hex) {
  Color color = colorFromHex(hex);
  return [color.red, color.green, color.blue];
  // hex = hex.toUpperCase().replaceAll("#", "");
  // if (hex.length == 3) {
  //   hex = "" + hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
  // }
  // int a = 0;
  // if (hex.length == 8) {
  //   a = int.parse(hex.substring(6), radix: 16) ~/ 255;
  //   hex = hex.substring(0, 6);
  // }
  // var bigint = int.parse(hex, radix: 16);
  // return [(bigint >> 16) & 255, (bigint >> 8) & 255, bigint & 255];
}

hexFromRgb(int r, int g, int b) {
  return "#" + toHex(r) + toHex(g) + toHex(b);
}

hue2rgb(p, q, t) {
  if (t < 0) t += 1;
  if (t > 1) t -= 1;
  if (t < 1 / 6) return p + (q - p) * 6 * t;
  if (t < 1 / 2) return q;
  if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
  return p;
}

toHex(int n) {
  return (n > 15 ? "" : "0") + (n.toRadixString(16));
}

rgbFromHsl(int h, s, l) {
  var r, g, b;
  if (s == 0) {
    r = g = b = l;
  } else {
    var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    var p = 2 * l - q;
    r = hue2rgb(p, q, h + 1 / 3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1 / 3);
  }
  return [(r * 255).round(), (g * 255).round(), (b * 255).round()];
}

hslFromRgb(int r, int g, int b) {
  r ~/= 255;
  g ~/= 255;
  b ~/= 255;
  var amax = max(r, max(g, b)), amin = min(r, min(g, b));
  var h, s, l = (amax + amin) / 2;
  if (amax == amin) {
    h = s = 0;
  } else {
    var d = amax - amin;
    s = l > 0.5 ? d / (2 - amax - amin) : d / (amax + amin);
    if (amax == g) h = (b - r) / d + 2;
    if (amax == b) h = (r - g) / d + 4;
    if (amax == r) h = (g - b) / d + (g < b ? 6 : 0);
    h /= 6;
  }
  return [h, s, l];
}

hsvFromRgb(int r, int g, int b) {
  r = r ~/ 255;
  g = g ~/ 255;
  b = b ~/ 255;
  var h, s, v;
  var amin = min(min(r, g), b);
  var amax = v = max(max(r, g), b);
  var l = (amin + amax) / 2;
  var difference = amax - amin;
  if (amax == amin) {
    h = 0;
  } else {
    if (amax == b) h = 4.0 + (r - g) / difference;
    if (amax == g) h = 2.0 + (b - r) / difference;
    if (amax == r) h = (g - b) / difference + (g < b ? 6 : 0);
    h = (h * 60).round();
  }
  if (amax == 0) {
    s = 0;
  } else {
    s = 1 - amin / amax;
  }
  s = (s * 100);
  v = (v * 100);
  return [h, s, v];
}

rgbFromHsv(int h, int s, int v) {
  s = s ~/ 100;
  v = v ~/ 100;
  var h1 = (h / 60).floor() % 6;
  var f = h / 60 - h1;
  var p = v * (1 - s);
  var q = v * (1 - f * s);
  var t = v * (1 - (1 - f) * s);
  var r, g, b;
  switch (h1) {
    case 0:
      r = v;
      g = t;
      b = p;
      break;
    case 1:
      r = q;
      g = v;
      b = p;
      break;
    case 2:
      r = p;
      g = v;
      b = t;
      break;
    case 3:
      r = p;
      g = q;
      b = v;
      break;
    case 4:
      r = t;
      g = p;
      b = v;
      break;
    case 5:
      r = v;
      g = p;
      b = q;
      break;
  }
  return [(r * 255).round(), (g * 255).round(), (b * 255).round()];
}

// 底色 浅灰 #ececec -> 背色 #fff ->主色
// 无色相 主色为 纯白 纯黑
// 底色 白 -> 背色 白 ->主色 白  不能更亮 只能降低亮度
// 底色 黑 -> 背色 黑 ->主色 黑  不能更暗 只能提高亮度
light(r, g, b) {
  //return color? '#000000': '#ffffff'
  return (0.213 * r + 0.715 * g + 0.072 * b) > 255 / 2;
}
