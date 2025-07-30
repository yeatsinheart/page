import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/util/color-util.dart';

class AppStyle {
  static Map<String, dynamic> data = {};

  static byPercent(v) {
    // 按宽度的百分比
    double x = min(screenWidth, maxWidth ?? screenWidth);
    return v * x / 100;
  }

  static byRem(v) {
    // 7.5rem=100%;
    double x = min(screenWidth, maxWidth ?? screenWidth);
    return v * x / (750 / 100);
  }

  static double? get maxWidth {
    return data["maxWidth"];
  }

  static double get screenWidth {
    return MediaQuery.of(AppContext.context).size.width;
  }

  static double get screenHeight {
    return MediaQuery.of(AppContext.context).size.height;
  }

  static List<dynamic> getColors() {
    return data["colors"] ?? ["#2196F3"];
  }

  static getMainColor() {
    return ColorUtil.getColor(getColors()[0]);
  }
}
