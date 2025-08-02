import 'package:flutter3/style/rem.dart';
import 'package:flutter3/style/setting/container.dart';

var buttons = {
  "btn": container(
    type: "button",
    bg: "#FF4D5A",
    font: "#FFF",
    border: BorderSetting(borderRadius: Rem.ofRem(.1)),
    padding: PaddingSetting(horizon: Rem.byPx(14), vertical: Rem.byPx(6)),
  ),
  "btn-disabled": container(
    type: "button",
    bg: "#f5f5f5",
    font: "#737272",
    border: BorderSetting(color: "#ccc", borderRadius: Rem.ofRem(.1)),
    padding: PaddingSetting(horizon: Rem.byPx(14), vertical: Rem.byPx(6)),
  ),

  "btn-login": container(
    type: "button",
    bg: "#fff",
    font: "#333",
    border: BorderSetting(borderRadius: Rem.ofRem(.1)),
    padding: PaddingSetting(horizon: Rem.byPx(14), vertical: Rem.byPx(6)),
  ),

  "btn-register": container(
    type: "button",
    bg: "#FFFFFF17",
    font: "#fff",
    border: BorderSetting(color: "#FFFFFF29", borderRadius: Rem.ofRem(.1)),
    padding: PaddingSetting(horizon: Rem.byPx(14), vertical: Rem.byPx(6)),
  ),
};
