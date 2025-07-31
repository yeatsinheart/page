import 'package:flutter/material.dart';
import 'package:flutter3/util/color-util.dart';

class GradientSetting{
  _parseAlignment(List<dynamic> position){return Alignment(position[0],position[1]);}
  Gradient? fromJson(Map<String, dynamic> json) {
    final type = (json['type'] as String?)?.toLowerCase() ?? 'linear';
    final colors = (json['colors'] as List?)?.map((c) => ColorUtil.getColor(c)).whereType<Color>().toList() ?? [];
    if (colors.isEmpty) {
      return null;
    }
    final List<double>? stops = (json['stops'] as List?)?.map((e) {
      if (e is double) return e;
      if (e is int) return e.toDouble();
      if (e is String) return double.tryParse(e) ?? 0.0;
      return 0.0;
    }).toList();

    switch (type) {
      case 'radial':
        final center = _parseAlignment(json['center']);
        final radius = (json['radius'] is num) ? (json['radius'] as num).toDouble() : 0.5;
        return RadialGradient(
          colors: colors,
          stops: stops,
          center: center,
          radius: radius,
          // 可选添加其他参数，如 focal，focalRadius
        );

      case 'sweep':
        final center = _parseAlignment(json['center']);
        final startAngle = (json['startAngle'] is num) ? (json['startAngle'] as num).toDouble() : 0.0;
        final endAngle = (json['endAngle'] is num) ? (json['endAngle'] as num).toDouble() : 3.14 * 2;
        return SweepGradient(colors: colors, stops: stops, center: center, startAngle: startAngle, endAngle: endAngle);

      case 'linear':
      default:
        final begin = _parseAlignment(json['begin']);
        final end = _parseAlignment(json['end']);
        return LinearGradient(colors: colors, stops: stops, begin: begin, end: end);
    }
  }
}
// begin end :屏幕中心为[0,0] 屏幕左上角为[-1,-1] 屏幕右下角为[1,1] 在-1到1之间确定一个值
List<double> top_left = [-1, -1];
List<double> top_center = [0, -1];
List<double> top_right = [1, -1];
List<double> center = [0, 0];
List<double> bottom_left = [-1, 1];
List<double> bottom_center = [0, 1];
List<double> bottom_right = [1, 1];

gradient_linear({List<String>? colors, List<double>? stops = const [0, 1], List<double> begin = const [-1, -1], List<double> end = const [1, 1]}) {
  if (null == colors || colors.length < 2) return null;
  if (begin.length != 2 || end.length != 2) return null;
  return {"type": "linear", "colors": colors, "stops": stops, "begin": begin, "end": end};
}

gradient_radial({List<String>? colors, List<double>? stops = const [0, 1], List<double> center = const [-1, -1], double radius = 0.5}) {
  if (null == colors || colors.length < 2) return null;
  if (center.length != 2) return null;
  return {"type": "radial", "colors": colors, "stops": stops, "center": center, "radius": radius};
}

gradient_sweep({List<String>? colors, List<double>? stops = const [0, 1], List<double> center = const [-1, -1], double begin = 0, double end = 0}) {
  if (null == colors || colors.length < 2) return null;
  if (center.length != 2) return null;
  return {"type": "sweep", "colors": colors, "stops": stops, "center": center, "startAngle": begin, "endAngle": end};
}
