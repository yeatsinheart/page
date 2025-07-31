import 'package:flutter/material.dart';
import 'package:flutter3/util/color-util.dart';

class ShadowSetting {
  String? color;
  double? blurRadius = 6;
  double? spreadRadius = 2;
  List<double>? offset = [0, 3];
  String? blurStyle = "normal"; // normal solid outer inner
  fromJson(Map<String, dynamic> json) {
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

  ShadowSetting({String? color, double blurRadius = 2, double spreadRadius = 6, List<double> offset = const [0, 3], String blurStyle = "normal"}) {
    if (offset.length != 2) return;
    this.color = color;
    this.blurRadius = blurRadius;
    this.spreadRadius = spreadRadius;
    this.offset = offset;
    this.blurStyle = blurStyle;
  }

  Map<String, dynamic> toJson() => {'color': color, 'blurRadius': blurRadius, 'spreadRadius': spreadRadius, 'offset': offset, 'blurStyle': blurStyle};
}
