import 'package:flutter3/style/rem-setting.dart';
import 'package:flutter3/style/setting/container.dart';

var bars = {
  "tab": container(bg: "#fff", font: "#000"),
  "bar": container(bg: "#3f15d1", font: "#000"),
  "bar-bottom": container(
    bgGradient: GradientSetting.linear(colors: ["#7ec1f7", "#FFF"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#000",
  ),
  "bar-brand": container(
    bg: "#FF4D5A",
    font: "#FFF",
    padding: PaddingSetting(horizon: RemSetting.ofRem(.2)),
  ),

  /*linear-gradient(to bottom, #ebebeb 0%, #e3e3e3 100%)*/
  // bgGradient: GradientSetting.linear(colors: ["#ebebeb","#e3e3e3"],begin:top_center,end:bottom_center)
  "bar-marquee": container(
    padding: PaddingSetting(horizon: RemSetting.ofRem(.2)),
    bg: "transparent",
    font: "#000",
  ),
  "marquee": container(bg: "transparent", font: "#000"),
};
