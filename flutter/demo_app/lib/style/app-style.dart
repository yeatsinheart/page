import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/style/rem-setting.dart';
import 'package:flutter3/util/color-util.dart';

class AppStyle {
  static Map<String, dynamic> data = {};

  static byPercent(v) {
    // 按宽度的百分比
    return v * viewWidth / 100;
  }

  // 直接按照 px 设定 固定布局px
  static byPx(double pxValue) {
    return byRem(RemSetting.byPx(pxValue).size);
  }

  static byRem(double remValue) {
    // 7.5rem=100%;
    return RemSetting.getPx(remValue,viewWidth);
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

  static getMainColor() {
    return ColorUtil.getColor(getColors()[0]);
  }
}
