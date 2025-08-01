import 'package:flutter/material.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/util/color-util.dart';
class ShadowFormat {
  static BoxShadow? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    Color? c = ColorUtil.getColor(json["color"]);
    if (c == null) return null;
    return BoxShadow(
      color: c,
      spreadRadius: (json["spreadRadius"] ?? 0).toDouble(),
      blurRadius: (json["blurRadius"] ?? 0).toDouble(),
      offset: Offset(
        (json["offset"]?[0] ?? 0).toDouble(),
        (json["offset"]?[1] ?? 0).toDouble(),
      ),
      blurStyle: switch (json["blurStyle"]) {
        "solid" => BlurStyle.solid,
        "inner" => BlurStyle.inner,
        "outer" => BlurStyle.outer,
        _ => BlurStyle.normal,
      },
    );
  }

  // 新增：从 List<Map> 解析成 List<BoxShadow>
  static List<BoxShadow>? listFromJson(List<dynamic>? jsonList) {
    if (jsonList == null) return null;
    return jsonList
        .map((e) => fromJson(e as Map<String, dynamic>?))
        .whereType<BoxShadow>()
        .toList();
  }
}
