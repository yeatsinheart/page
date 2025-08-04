import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/rem-setting.dart';
import 'package:flutter3/style/setting/container.dart';

var buttons = {
  //
  "btn": container(
    type: "button",
    bg: ColorSetting(light: "#f5f5f5", dark: "#2a2a2a"),
    font: ColorSetting(light: "#737272", dark: "#bbbbbb"),
    border: BorderSetting(color: ColorSetting(light: "#ccc", dark: "#444"),borderRadius: RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon: RemSetting.byPx(14), vertical: RemSetting.byPx(6)),
  ),

  "btn-disabled": container(
    type: "button",
    bg:  ColorSetting(light: "#f5f5f5", dark: "#2a2a2a"),
    font: ColorSetting(light: "#737272", dark: "#bbbbbb"),
    border: BorderSetting(color: ColorSetting(light: "#ccc", dark: "#444"), borderRadius: RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon: RemSetting.byPx(14), vertical: RemSetting.byPx(6)),
  ),

  "btn-main": container(
    type: "button",
    bg: ColorSetting(light: "#FF4D5A", dark: "#FF4D5A"),
    font: ColorSetting(light: "#FFF", dark: "#FFF"),
    border: BorderSetting(borderRadius: RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon: RemSetting.byPx(14), vertical: RemSetting.byPx(6)),
  ),

  "btn-login": container(
    type: "button",
    bg: ColorSetting(light: "#FFF", dark: "#FFF"),
    font: ColorSetting(light: "#333", dark: "#333"),
    border: BorderSetting(borderRadius: RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon: RemSetting.byPx(14), vertical: RemSetting.byPx(6)),
  ),

  "btn-register": container(
    type: "button",
    bg: ColorSetting(light: "#FFFFFF17", dark: "#FFFFFF17"),
    font: ColorSetting(light: "#FFF", dark: "#FFF"),
    border: BorderSetting(color: ColorSetting(light: "#FFFFFF29", dark: "#FFFFFF29"), borderRadius: RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon: RemSetting.byPx(14), vertical: RemSetting.byPx(6)),
  ),
};
