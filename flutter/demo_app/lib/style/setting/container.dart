library setting;

import 'package:flutter3/style/setting/border.dart';
import 'package:flutter3/style/setting/padding.dart';
import 'package:flutter3/style/setting/shadow.dart';

export 'package:flutter3/style/setting/border.dart';
export 'package:flutter3/style/setting/gradient.dart';
export 'package:flutter3/style/setting/padding.dart';
export 'package:flutter3/style/setting/shadow.dart';

container({String? img, Padding? padding, String? bg, bgGradient, String? font, Border? border, double? radius, Shadow? shadow}) {
  if (radius != null && radius > 7.5) radius = 0;
  final result = <String, dynamic>{};
  if (img != null) result["img"] = img;
  if (padding != null) result["padding"] = padding.toJson();
  if (bg != null) result["bg"] = bg;
  if (bgGradient != null) result["bgGradient"] = bgGradient;
  if (font != null) result["font"] = font;
  if (border != null) result["border"] = border.toJson();
  if (radius != null) result["radius"] = radius;
  if (shadow != null) result["shadow"] = shadow.toJson();
  return result;
}
