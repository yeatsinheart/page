import 'package:flutter3/style/setting/container.dart';

var notifies = {
  // 高对比（用于主要提示）
  "warning": container(bg: "#FFC107", font: "#fff"),
  "error": container(bg: "#F44336", font: "#fff"),
  "success": container(bg: "#4CAF50", font: "#fff"),

  // 低对比（用于背景/说明）
  "warning-soft": container(bg: "#FEF5DF", font: "#D2B77E"),
  "error-soft": container(bg: "#FEECEC", font: "#D66B6B"), // 柔和红色背景 + 深红字体
  "success-soft": container(bg: "#E9F7EF", font: "#4CAF50"), // 柔和绿色背景 + 主绿字体
};
