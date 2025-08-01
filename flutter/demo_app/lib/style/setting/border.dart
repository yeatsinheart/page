class BorderSetting {
  /// 默认边框颜色和宽度（单位为 rem，最大值 7.5）
  final String? color;
  final double width;

  BorderSetting({String? color, double width = 1}) : width = _clamp(width), color = _cleanColor(color);

  static String? _cleanColor(String? c) {
    if (c == null) return null;
    final trimmed = c.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static double _clamp(double w) {
    return (w >= 0 && w <= 7.5) ? w : 0;
  }

  Map<String, dynamic>? toJson() {
    if (color == null && width <= 0) return null;

    final result = <String, dynamic>{};
    if (color != null) result['color'] = color;
    if (width > 0) result['width'] = width;
    return result;
  }
}
