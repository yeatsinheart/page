import 'dart:ui';

import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/util/color-util.dart';

class ColorFont {
  final Color? title;
  final Color? name;
  final Color? txt;
  final Color? ghost;

  const ColorFont({this.title, this.name, this.txt, this.ghost});

  factory ColorFont.fromJson(Map<String, dynamic> json) {
    return ColorFont(title: ColorUtil.getColor(json['title'][AppStyle.Brightness]), name: ColorUtil.getColor(json['name'][AppStyle.Brightness]), txt: ColorUtil.getColor(json['txt'][AppStyle.Brightness]), ghost: ColorUtil.getColor(json['ghost'][AppStyle.Brightness]));
  }

  static ColorFont get() {
    return ColorFont.fromJson(AppStyle.data["font"][AppStyle.Brightness] ?? {});
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
