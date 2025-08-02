import 'package:flutter3/style/rem-setting.dart';
import 'package:flutter3/style/setting/container.dart';

var inputs={
  "input": container(
    bg: "#f5f5f5",
    font: "#737272",
    border: BorderSetting(color: "#ccc",borderRadius: RemSetting.ofRem(.2)),
    padding: PaddingSetting(all:  RemSetting.ofRem(.2)),
  ),
};