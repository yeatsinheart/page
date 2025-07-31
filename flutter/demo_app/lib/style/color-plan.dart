// 颜色值支持多种格式：可以为：null transparent=#00000000 hex简写#000 hex标准#FFFFFF hex带alpha#FFFFFF1A rgb(255, 0, 0) rgba(255, 0, 0, 0.5)
// gradient对象
import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/util/color-util.dart';
import 'package:flutter3/util/gradient-util.dart';

/// 颜色搭配方案，不要想太多，纯颜色组合 不设及其它
/// color-plan ：以底色为主 of bg，
/// 不属于背景色关联的，应该是通过点缀色直接设置,
/// 所以什么browser page 头部导航，底部导航属于特别处理方案
class ColorPlan {
  final Color? bg; // 纯色背景色
  final Gradient? bgGradient; // 渐变背景色
  final Color? font; // 通用字色
  final Color? border; // 边框色
  final Color? shadow; // 阴影色

  const ColorPlan({this.bg, this.bgGradient, this.font, this.border, this.shadow});

  factory ColorPlan.fromJson(Map<String, dynamic> json) {
    return ColorPlan(bg: ColorUtil.getColor(json['bg']), bgGradient: GradientUtil.getGradient(json['bgGradient']), font: ColorUtil.getColor(json['font']), border: ColorUtil.getColor(json['border']), shadow: ColorUtil.getColor(json['shadow']));
  }

  static ColorPlan get(k) {
    return ColorPlan.fromJson(AppStyle.data["color-plan"]?[k] ?? {});
  }
}

/*
  var bgGradient = {
    "type": "linear", // 渐变类型，可选：linear, radial, sweep
    "colors": [
      "#2196F3", // 支持 hex、rgba、颜色名等，需你实现 colorValue 解析
      "#FFF"
    ],
    //"stops": [0.0,  0.6], // 可选，颜色渐变位置（0~1）
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
