class ColorSetting {
  final String? dark;
  final String? light;

  ColorSetting({String? light, String? dark})
    : assert(_cleanColor(light) != null, '白天色需正确配置'),
      assert(_cleanColor(dark) != null, '夜间色需正确配置'),
      light = _cleanColor(light),
      dark = _cleanColor(dark);

  Map<String, dynamic>? toJson() {
    return {'dark': dark, 'light': light};
  }
}

String? _cleanColor(String? c) {
  if (c == null) return null;
  final trimmed = c.trim();
  return trimmed.isEmpty ? null : trimmed;
}
