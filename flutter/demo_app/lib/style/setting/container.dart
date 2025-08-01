library setting;

import 'package:flutter3/style/setting/border.dart';
import 'package:flutter3/style/setting/gradient.dart';
import 'package:flutter3/style/setting/padding.dart';
import 'package:flutter3/style/setting/shadow.dart';

export 'package:flutter3/style/setting/border.dart';
export 'package:flutter3/style/setting/gradient.dart';
export 'package:flutter3/style/setting/padding.dart';
export 'package:flutter3/style/setting/shadow.dart';

Map<String, dynamic> container({String? img, PaddingSetting? padding, String? bg, GradientSetting? bgGradient, String? font, BorderSetting? border, double? radius, ShadowSetting? shadow}) {
  radius = _clampRadius(radius);
  final result = <String, dynamic>{};

  if (img != null) result['img'] = img;
  if (padding != null) result['padding'] = padding.toJson();
  if (bg != null) result['bg'] = bg;
  if (bgGradient != null) result['bgGradient'] = bgGradient.toJson();
  if (font != null) result['font'] = font;
  if (border != null) result['border'] = border.toJson();
  if (radius != null) result['radius'] = radius??0;
  if (shadow != null) result['shadow'] = shadow.toJson();

  return result;
}

double? _clampRadius(double? r) {
  if (r == null) return null;
  return (r > 0 && r <= 3) ? r : 0;
}
