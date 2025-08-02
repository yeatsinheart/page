import 'package:flutter3/style/setting/container.dart';

var buttons = {
  "btn": container(type: "button", bg: "#FF4D5A", font: "#FFF", radiusRem: .1, paddingRem: PaddingSetting(horizon: 0.175, vertical: .065)),
  "btn-disabled": container(
    type: "button",
    bg: "#f5f5f5",
    font: "#737272",
    border: BorderSetting(color: "#ccc"),
    radiusRem: .1,
    paddingRem: PaddingSetting(horizon: 0.175, vertical: .065),
  ),

  "btn-login": container(type: "button", bg: "#fff", font: "#333", radiusRem: .1, paddingRem: PaddingSetting(horizon: 0.175, vertical: .065)),

  "btn-register": container(
    type: "button",
    bg: "#FFFFFF17",
    font: "#fff",
    radiusRem: .1,
    border: BorderSetting(color: "#FFFFFF29"),
    paddingRem: PaddingSetting(horizon: 0.175, vertical: .065),
  ),
};
