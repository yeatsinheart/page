library setting;

import 'package:flutter3/style/setting/border.dart';
import 'package:flutter3/style/setting/gradient.dart';
import 'package:flutter3/style/setting/padding.dart';
import 'package:flutter3/style/setting/shadow.dart';

export 'package:flutter3/style/setting/border.dart';
export 'package:flutter3/style/setting/gradient.dart';
export 'package:flutter3/style/setting/padding.dart';
export 'package:flutter3/style/setting/shadow.dart';

Map<String, dynamic> container({String? type,String? img, PaddingSetting? paddingRem, PaddingSetting? marginRem,String? bg, GradientSetting? bgGradient, String? font, BorderSetting? border, double? radiusRem, List<ShadowSetting>? shadows}) {
  radiusRem = _clampRadius(radiusRem);
  final result = <String, dynamic>{};

  if (type != null) result['type'] = type;
  if (img != null) result['img'] = img;
  if (paddingRem != null) result['padding'] = paddingRem.toJson();
  if (marginRem != null) result['margin'] = marginRem.toJson();
  if (bg != null) result['bg'] = bg;
  if (bgGradient != null) result['bgGradient'] = bgGradient.toJson();
  if (font != null) result['font'] = font;

  if (radiusRem != null) result['radius'] = radiusRem??0;

  if (border != null) result['border'] = border.toJson();
  if(result['radius']!=null && result['radius']>0 && null==result['border']){
    result['border'] = BorderSetting(color: "transparent");
  }
  if (shadows != null && shadows.isNotEmpty) {
    result['shadows'] = shadows
        .map((s) => s.toJson())
        .where((s) => s != null) // 过滤掉为 null 的项
        .toList();
  }

  return result;
}

double? _clampRadius(double? r) {
  if (r == null) return null;
  return (r > 0 && r <= 3) ? r : 0;
}
