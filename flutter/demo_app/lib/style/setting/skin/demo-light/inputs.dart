import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/rem-setting.dart';
import 'package:flutter3/style/setting/container.dart';

var inputs={
  "input": container(
    bg: ColorSetting(light: "#f5f5f5", dark: "#f5f5f5"),
    font:  ColorSetting(light: "#737272", dark: "#737272"),
    border: BorderSetting(color: ColorSetting(light: "#ccc", dark: "#ccc"),borderRadius: RemSetting.ofRem(.2)),
    padding: PaddingSetting(all:  RemSetting.ofRem(.2)),
  ),
};