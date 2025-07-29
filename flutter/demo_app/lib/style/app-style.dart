import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/util/color-util.dart';

class AppStyle {
  static Map<String, dynamic> style = {};

  static byPercent(v) {
    // 按宽度的百分比
    double x = min(screenWidth, maxWidth?? screenWidth);
    return v * x / 100;
  }

  static byRem(v) {
    // 7.5rem=100%;
    double x = min(screenWidth, maxWidth?? screenWidth);
    return v * x / (750 / 100);
  }

  static double? get maxWidth {
    return style["maxWidth"];
  }

  static double get screenWidth {
    return MediaQuery.of(AppContext.context).size.width;
  }

  static double get screenHeight {
    return MediaQuery.of(AppContext.context).size.height;
  }

  static ColorContainer getContainerStyle(k) {
    return ColorContainer.fromJson(style["container"]?[k] ?? {});
  }

  static ColorFont getFontStyle() {
    return ColorFont.fromJson(style["font"] ?? {});
  }

  static List<dynamic> getColors() {
    return style["colors"] ?? ["#2196F3"];
  }

  static getMainColor() {
    return ColorUtil.getColor(getColors()[0]);
  }
}
/// 颜色搭配方案，不要想太多，纯颜色，不要想着这个容器那个容器要控制各种鬼东西。直接产出themeData最好
/// flutter上，就是一个 themedata -> 下面所有 容器需要对应的修改咯。？？？按钮什么的ofButton ofContainer ofXxxx
/// css上，就是一个css定义咯。.page{} .div1{}
class ColorContainer {
  // 颜色值支持多种格式：可以为：null transparent=#00000000 hex简写#000 hex标准#FFFFFF hex带alpha#FFFFFF1A rgb(255, 0, 0) rgba(255, 0, 0, 0.5) gradient对象
  final mask;
  final bg;
  final bgImg;
  final font;

  final border;
  final radius;
  final shadow;

  const ColorContainer({this.radius, this.mask, this.bg, this.bgImg, this.font, this.border, this.shadow});

  factory ColorContainer.fromJson(Map<String, dynamic> json) {
    return ColorContainer(radius: json['radius'], mask: json['mask'], bg: json['bg'], bgImg: json['bgImg'], font: json['font'], border: json['border'], shadow: json['shadow']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (radius != null) map['radius'] = radius;
    if (mask != null) map['mask'] = mask;
    if (bg != null) map['bg'] = bg;
    if (bgImg != null) map['bgImg'] = bgImg;
    if (font != null) map['font'] = font;
    if (border != null) map['border'] = border;
    if (shadow != null) map['shadow'] = shadow;
    return map;
  }
}

class ColorFont {
  final title;
  final name;
  final txt;
  final ghost;

  const ColorFont({this.title, this.name, this.txt, this.ghost});

  factory ColorFont.fromJson(Map<String, dynamic> json) {
    return ColorFont(title: json['title'], name: json['name'], txt: json['txt'], ghost: json['ghost']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (title != null) map['title'] = title;
    if (name != null) map['name'] = name;
    if (txt != null) map['txt'] = txt;
    if (ghost != null) map['ghost'] = ghost;
    return map;
  }
}
