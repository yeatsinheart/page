import 'package:flutter3/style/rem-setting.dart';

class ShadowSetting {
  final String? color;
  final RemSetting blurRadius;
  final RemSetting spreadRadius;
  final List<double> offset;
  final String blurStyle; // normal, solid, outer, inner

  ShadowSetting({String? color, RemSetting? blurRadius, RemSetting? spreadRadius, List<double>? offset, String blurStyle = "normal"})
    : color = _cleanColor(color),
      blurRadius = blurRadius ?? RemSetting.byPx(6),
      spreadRadius = spreadRadius ?? RemSetting.byPx(2),
      offset = (offset != null && offset.length == 2) ? offset : [0, 3],
      blurStyle = blurStyle;

  // 两个redius 的值在0-100
  static double _clamp(double value) => (value >= 0 && value <= 100) ? value : 0;

  static String? _cleanColor(String? c) {
    if (c == null) return null;
    final trimmed = c.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Map<String, dynamic>? toJson() {
    // 如果所有主要字段都没意义，则返回null
    if (color == null && blurRadius == 0 && spreadRadius == 0 && offset.every((e) => e == 0)) {
      return null;
    }
    final map = <String, dynamic>{};
    if (color != null) map['color'] = color;
    map['blurRadius'] = blurRadius;
    map['spreadRadius'] = spreadRadius;
    map['offset'] = offset;
    map['blurStyle'] = blurStyle;
    return map;
  }
}
