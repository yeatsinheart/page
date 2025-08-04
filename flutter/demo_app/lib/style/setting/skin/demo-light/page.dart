import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/container.dart';
import 'package:flutter3/style/setting/rem-setting.dart';

var defaultFont = fonts["txt"];

var fonts = {
  "title": ColorSetting(light: "#323233", dark: "#ffffff"),
  "name": ColorSetting(light: "#646566", dark: "#dddddd"),
  "txt": ColorSetting(light: "#737272", dark: "#aaaaaa"),
  "ghost": ColorSetting(light: "#BBB", dark: "#666666"),
};

var mask = ColorSetting(light: "#0000001f", dark: "#ffffff1f");
var border = ColorSetting(light: "#e3e3e31a", dark: "#e3e3e31a");
var shadow = ColorSetting(light: "#41454940", dark: "#41454940");

var page = {
  "browser": container(
    bgGradient: GradientSetting.linear(
      colors: [
        ColorSetting(light: "#81FFEF", dark: "#81FFEF"),
        ColorSetting(light: "#F067B4", dark: "#F067B4"),
      ],
      stops: [0.1, 1],
      begin: top_right,
      end: bottom_left,
    ),
  ),

  "page": container(
    bg: ColorSetting(light: "#fff",dark: "#121212"),
    // bgGradient: GradientSetting.linear(
    //   colors: [
    //     ColorSetting(light: "#7ec1f7", dark: "#0F2027"),
    //     ColorSetting(light: "#FFF", dark: "#203A43"),
    //   ],
    //   stops: [0, .8],
    //   begin: top_right,
    //   end: bottom_left,
    // ),
  ),
  "section": container(
    bg: ColorSetting(light: "#F5F5F5", dark: "#1E1E1E"),
    margin: PaddingSetting(vertical: RemSetting.ofRem(.1)),
    padding: PaddingSetting(all: RemSetting.ofRem(.2)),
  ),

  // 通用容器
  "container": container(
    // img: "assets/images/game1.jpg",
    margin: PaddingSetting(horizon: RemSetting.ofRem(.2), top: RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon: RemSetting.ofRem(.2), vertical: RemSetting.ofRem(.05)),
    //border: BorderSetting(color: "#ccc"),
    border: BorderSetting(borderRadius: RemSetting.ofRem(.14)),
    bg: ColorSetting(light: "#F5F5F5", dark: "#1E1E1E"),
    shadows: [
      ShadowSetting(
        color: ColorSetting(light: "#00000033", dark: "#00000033"),
        blurRadius: RemSetting.byPx(12),
      ),
    ],
  ),

  "img-loading": container(
    bg: ColorSetting(light: "#e0e0e0", dark: "#2A2A2A"),
    font: ColorSetting(light: "#FFF", dark: "#1E1E1E"),
  ),

  "txt-cover": container(
    bgGradient: GradientSetting.linear(
      colors: [
        ColorSetting(light: "#0000004d", dark: "#0000004d"),
        ColorSetting(light: "transparent", dark: "transparent"),
      ],
      stops: [0, .9],
      begin: bottom_center,
      end: top_center,
    ),

    font: ColorSetting(light: "#FFF", dark: "#000"),
  ),

  "focus": container(
    bgGradient: GradientSetting.linear(
      colors: [
        ColorSetting(light: "#0000004d", dark: "#0000004d"),
        ColorSetting(light: "transparent", dark: "transparent"),
      ],
      stops: [0, .8],
      begin: bottom_center,
      end: top_center,
    ),
    font: ColorSetting(light: "#FFF", dark: "#000"),
  ),
};
