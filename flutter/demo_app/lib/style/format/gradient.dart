import 'package:flutter/material.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/util/color-util.dart';

class GradientFormat{
  static _parseAlignment(List<dynamic> position){return Alignment(position[0],position[1]);}
  static Gradient? fromJson(Map<String, dynamic>? json) {
    if(null==json)return null;
    final type = (json['type'] as String?)?.toLowerCase() ?? 'linear';
    final colors = (json['colors'] as List?)?.map((c) => ColorUtil.getColor(c[AppStore().Brightness.value])).whereType<Color>().toList() ?? [];
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