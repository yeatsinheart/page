import 'package:flutter3/style/setting/container.dart';

var bars = {
  "tab": container(bg: "#fff", font: "#000"),
  "bar": container(bg: "#3f15d1", font: "#000"),
  "bar-bottom": container(
    bgGradient: GradientSetting.linear(colors: ["#7ec1f7", "#FFF"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#000",
  ),
  "bar-brand": container(bg: "#FF4D5A", font: "#FFF", paddingRem: PaddingSetting(horizon: 0.2)),
};
