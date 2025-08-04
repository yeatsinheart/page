import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/container.dart';
import 'package:flutter3/style/setting/rem-setting.dart';

var bars = {
  // ColorSetting(light: "transparent", dark: "transparent"),
  "tab": container(
    bg: ColorSetting(light: "#fff", dark: "#000"),
    font: ColorSetting(light: "#000", dark: "#55657e"),
  ),
  "bar": container(
    bg: ColorSetting(light: "#3f15d1", dark: "#3f15d1"),
    font: ColorSetting(light: "#000", dark: "#55657e"),
  ),
  "bar-bottom": container(
    bg: ColorSetting(light: "#fff", dark: "#141d29"),
    bgGradient: GradientSetting.linear(
      colors: [
        ColorSetting(light: "#7ec1f7", dark: "transparent"),
        ColorSetting(light: "#fff", dark: "transparent"),
      ],
      stops: [0, .8],
      begin: bottom_center,
      end: top_center,
    ),
    font: ColorSetting(light: "#000", dark: "#55657e"),
  ),
  "bar-brand": container(
    bg: ColorSetting(light: "#FF4D5A", dark: "#7A3A3A"),
    font: ColorSetting(light: "#fff", dark: "#55657e"),
    padding: PaddingSetting(horizon: RemSetting.ofRem(.2)),
  ),

  /*linear-gradient(to bottom, #ebebeb 0%, #e3e3e3 100%)*/
  // bgGradient: GradientSetting.linear(colors: ["#ebebeb","#e3e3e3"],begin:top_center,end:bottom_center)
  "bar-marquee": container(
    padding: PaddingSetting(horizon: RemSetting.ofRem(.2)),
    bg: ColorSetting(light: "transparent", dark: "transparent"),
    font: ColorSetting(light: "#000", dark: "#55657e"),
  ),

  "marquee": container(
    bg: ColorSetting(light: "transparent", dark: "transparent"),
    font: ColorSetting(light: "#000", dark: "#55657e"),
  ),
};
