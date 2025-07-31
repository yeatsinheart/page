import 'package:flutter/material.dart';
import 'package:flutter3/util/color-util.dart';

class ShadowFormat {
  static fromJson(Map<String, dynamic> json) {
    return BoxShadow(
      color: ColorUtil.getColor(json["color"]),
      spreadRadius: json["spreadRadius"],
      blurRadius: json["blurRadius"],
      offset: Offset(json["offset"][0], json["offset"][1]),
      // 阴影位置: x, y
      blurStyle: switch (json["blurStyle"]) {
        "solid" => BlurStyle.solid,
        "inner" => BlurStyle.inner,
        "outer" => BlurStyle.outer,
        _ => BlurStyle.normal,
      },
    );
  }
}
