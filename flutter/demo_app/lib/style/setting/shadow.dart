class ShadowSetting {
  final String? color;
  final double blurRadius;
  final double spreadRadius;
  final List<double> offset;
  final String blurStyle; // normal, solid, outer, inner

  ShadowSetting({String? color, double blurRadius = 6, double spreadRadius = 2, List<double>? offset, String blurStyle = "normal"}) : color = _cleanColor(color), blurRadius = _clamp(blurRadius), spreadRadius = _clamp(spreadRadius), offset = (offset != null && offset.length == 2) ? offset : [0, 3], blurStyle = blurStyle;

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
