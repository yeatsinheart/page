import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/util/color-util.dart';

class AppStyle {
  static Map<String, dynamic> data = {};

  static byPercent(v) {
    // 按宽度的百分比
    return v * viewWidth / 100;
  }

  static byPx(double pxValue) {
    // 750px设计稿中的px大小 等比例 还原
    return pxValue*(viewWidth/750);
  }
  static byRem(double rem) {
    // 7.5rem=100%;
    // 屏幕750px 1rem = 100px
    // 当前屏幕   1rem = 100px * viewWidth/750 (等比例屏幕)
    return rem * 100 * (viewWidth/750);
  }
  /// 实际宽度
  static double get viewWidth{
    return min(_screenWidth, maxWidth ?? _screenWidth);;
  }

  static double? get maxWidth {
    return data["maxWidth"];
  }

  static double get _screenWidth {
    return MediaQuery.of(AppContext.context).size.width;
  }

  static double get screenHeight {
    return MediaQuery.of(AppContext.context).size.height;
  }

  static List<dynamic> getColors() {
    return data["colors"] ?? ["#2196F3"];
  }

  static Color getMainColor() {
    return ColorUtil.getColor(getColors()[0])!;
  }
}
