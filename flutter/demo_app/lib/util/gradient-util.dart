import 'package:flutter/material.dart';
import 'package:flutter3/util/color-util.dart';

class GradientUtil {
  static getGradient(v) {
    if (v is Map) {
      final gradientMap = Map<String, dynamic>.from(v);
      return _buildGradient(gradientMap);
    }
  }
}

Gradient? _buildGradient(Map<String, dynamic> json) {
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
      final center = _parseAlignment(json['center'] ?? 'center');
      final radius = (json['radius'] is num) ? (json['radius'] as num).toDouble() : 0.5;
      return RadialGradient(
        colors: colors,
        stops: stops,
        center: center,
        radius: radius,
        // 可选添加其他参数，如 focal，focalRadius
      );

    case 'sweep':
      final center = _parseAlignment(json['center'] ?? 'center');
      final startAngle = (json['startAngle'] is num) ? (json['startAngle'] as num).toDouble() : 0.0;
      final endAngle = (json['endAngle'] is num) ? (json['endAngle'] as num).toDouble() : 3.14 * 2;
      return SweepGradient(colors: colors, stops: stops, center: center, startAngle: startAngle, endAngle: endAngle);

    case 'linear':
    default:
      final begin = _parseAlignment(json['begin'] ?? 'topRight');
      final end = _parseAlignment(json['end'] ?? 'bottomLeft');
      return LinearGradient(colors: colors, stops: stops, begin: begin, end: end);
  }
}

Alignment _parseAlignment(name) {
  if (name is! String) return Alignment.center;
  switch (name) {
    case 'topLeft':
      return Alignment.topLeft;
    case 'topRight':
      return Alignment.topRight;
    case 'bottomLeft':
      return Alignment.bottomLeft;
    case 'bottomRight':
      return Alignment.bottomRight;
    case 'topCenter':
      return Alignment.topCenter;
    case 'bottomCenter':
      return Alignment.bottomCenter;
    case 'centerLeft':
      return Alignment.centerLeft;
    case 'centerRight':
      return Alignment.centerRight;
    case 'center':
    default:
      return Alignment.center;
  }
}

/*
  var json = {
    "type": "linear", // 渐变类型，可选：linear, radial, sweep
    "colors": [
      "#2196F3", // 支持 hex、rgba、颜色名等，需你实现 colorValue 解析
      "#FFF"
    ],
    //"stops": [0.0,  1.0], // 可选，颜色渐变位置（0~1）
    "begin": "topLeft", // linear专用，渐变起点，默认 topRight
    "end": "bottomRight", // linear专用，渐变终点，默认 bottomLeft
    // radial 专用参数
    "center": "center", // radial 和 sweep 都用的渐变中心
    "radius": 0.5, // radial半径，默认0.5
    // sweep 专用参数
    "startAngle": 0.0, // sweep 起始角度，弧度，默认0.0
    "endAngle": 6.283185307179586, // sweep 结束角度，弧度，默认2π
    // 可选 tileMode，暂未实现
    // "tileMode": "clamp"          // 可选值：clamp, repeat, mirror
  };
  */
//var t = {"type": "linear","colors": ["#2196F3","#FFF"],"begin": "topLeft","end": "bottomRight"};
