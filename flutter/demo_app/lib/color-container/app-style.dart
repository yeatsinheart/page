import 'package:flutter/material.dart';
import 'package:flutter3/store/app_store.dart';
import 'package:get/get.dart';

ColorFont getFontStyle() {
  return ColorFont.fromJson(getAppStyle()["font"]);
}
List<dynamic> getColors(){
  return getAppStyle()["colors"]??["#2196F3"];
}
getAppStyle() {
  return Get.find<AppStore>().data.value?["style"] ?? {};
}

getContainerStyle(k) {
  return ColorContainer.fromJson(getAppStyle()["container"]?[k] ?? {});
}


class ColorContainer {
  // 颜色值支持多种格式：可以为：null transparent=#00000000 hex简写#000 hex标准#FFFFFF hex带alpha#FFFFFF1A rgb(255, 0, 0) rgba(255, 0, 0, 0.5) gradient对象
  final radius;
  final mask;
  final bg;
  final bgImg;
  final font;
  final border;
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
