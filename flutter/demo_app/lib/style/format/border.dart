import 'package:flutter/material.dart';
import 'package:flutter3/util/color-util.dart';

class BorderFormat {
  // 以 rem为准 7.5rem=100%；
  static Border fromJson(Map<String, dynamic> json){
    return Border.all(color: ColorUtil.getColor(json["color"]), width: json["width"]);
  }
}
