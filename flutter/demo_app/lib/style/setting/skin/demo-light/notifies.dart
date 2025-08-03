import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/container.dart';

var notifies = {
  // 高对比（用于主要提示）
  // ColorSetting(light: "#4CAF50", dark: "#4CAF50"),
  "warning": container(bg: ColorSetting(light: "#FFC107", dark: "#FFC107"), font: ColorSetting(light: "#fff", dark: "#fff"),),
  "error": container(bg: ColorSetting(light: "#F44336", dark: "#F44336"), font: ColorSetting(light: "#fff", dark: "#fff"),),
  "success": container(bg: ColorSetting(light: "#4CAF50", dark: "#4CAF50"), font: ColorSetting(light: "#fff", dark: "#fff"),),

  // 低对比（用于背景/说明）
  "warning-soft": container(bg: ColorSetting(light: "#FEF5DF", dark: "#FEF5DF"), font: ColorSetting(light: "#FFC107", dark: "#FFC107"),),
  "error-soft": container(bg: ColorSetting(light: "#FEECEC", dark: "#FEECEC"), font: ColorSetting(light: "#D66B6B", dark: "#D66B6B"),), // 柔和红色背景 + 深红字体
  "success-soft": container(bg: ColorSetting(light: "#E9F7EF", dark: "#E9F7EF"), font: ColorSetting(light: "#4CAF50", dark: "#4CAF50"),), // 柔和绿色背景 + 主绿字体
};
