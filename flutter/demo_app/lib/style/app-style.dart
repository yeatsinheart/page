import 'dart:math';

import 'package:flutter3/app-context.dart';
import 'package:flutter3/util/color-util.dart';
class AppStyle{
  static Map<String,dynamic> style={};
  // 按宽度的百分比
  static byAppWidthPercent(v) {
    double maxWidth = getLimitedMaxWidth() ?? AppContext.width;
    double x = min(AppContext.width, maxWidth);
    return v * x /100;
  }
  //
  static byRem(v) {
    // 7.5rem=100%;
    // 还有屏幕最大宽度 大屏显示H5效果
    double maxWidth = getLimitedMaxWidth() ?? AppContext.width;
    double x = min(AppContext.width, maxWidth);
    return v * x / (750/100);
  }

  static getLimitedMaxWidth() {
    return get()["maxWidth"]??AppContext.width;
  }

  static get() {
    return style ?? {};
  }

  static getContainerStyle(k) {
    return ColorContainer.fromJson(get()["container"]?[k] ?? {});
  }

  static ColorFont getFontStyle() {
    return ColorFont.fromJson(get()["font"]);
  }
  static List<dynamic> getColors(){
    return get()["colors"]??["#2196F3"];
  }

  static getMainColor() {return ColorUtil.getColor(getColors()[0]);}

}

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
