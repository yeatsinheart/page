import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/container.dart';
// 优化 light 模式中的配色以更温和协调，同时调整 dark 模式的颜色对比度，让视觉在黑暗背景中更舒适、不刺眼。
var notifies = {
  // 高对比提示（主提示背景）
  "warning": container(
    bg: ColorSetting(light: "#FFD54F", dark: "#5A4500"),   // 柔黄（light）+ 深棕黄（dark）
    font: ColorSetting(light: "#000000", dark: "#FFE082"), // 黑底用柔黄字体
  ),
  "error": container(
    bg: ColorSetting(light: "#EF5350", dark: "#6A1B1A"),   // 柔红（light）+ 深红棕（dark）
    font: ColorSetting(light: "#ffffff", dark: "#FFCDD2"), // 黑底上柔粉字体
  ),
  "success": container(
    bg: ColorSetting(light: "#66BB6A", dark: "#1B5E20"),   // 柔绿（light）+ 深绿（dark）
    font: ColorSetting(light: "#ffffff", dark: "#A5D6A7"), // 黑底上浅绿字体
  ),

  // 低对比提示（背景说明类）
  "warning-soft": container(
    bg: ColorSetting(light: "#FFF8E1", dark: "#2F2600"),   // 柔黄白（light）+ 深黄灰（dark）
    font: ColorSetting(light: "#FFB300", dark: "#FFCA28"), // 柔暖黄字体
  ),
  "error-soft": container(
    bg: ColorSetting(light: "#FFEBEE", dark: "#2B1818"),   // 柔红白（light）+ 深红灰（dark）
    font: ColorSetting(light: "#E57373", dark: "#FF8A80"), // 粉红字体
  ),
  "success-soft": container(
    bg: ColorSetting(light: "#E8F5E9", dark: "#133321"),   // 淡绿背景 + 深绿灰（dark）
    font: ColorSetting(light: "#4CAF50", dark: "#81C784"), // 主绿字体
  ),
};

