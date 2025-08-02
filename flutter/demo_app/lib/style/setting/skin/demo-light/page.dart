import 'package:flutter3/style/setting/rem-setting.dart';
import 'package:flutter3/style/setting/container.dart';

var fonts = {"title": "#323233", "name": "#646566", "txt": "#737272", "ghost": "#BBB"};
var defaultFont = fonts["txt"];

var page = {
  "browser": container(
    bgGradient: GradientSetting.linear(colors: ["#81FFEF", "#F067B4"], stops: [0.1, 1], begin: top_right, end: bottom_left),
  ),
  "page": container(
    bgGradient: GradientSetting.linear(colors: ["#7ec1f7", "#FFF"], stops: [0, .8], begin: top_right, end: bottom_left),
  ),
  "section": container(bg: "#FFF"),

  // 通用容器
  "container": container(
    // img: "assets/images/game1.jpg",
    margin: PaddingSetting(horizon:  RemSetting.ofRem(.2), top:  RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon:  RemSetting.ofRem(.2), vertical:  RemSetting.ofRem(.05)),
    //border: BorderSetting(color: "#ccc"),
    border: BorderSetting(borderRadius: RemSetting.ofRem(.14)),
    bg: "#FFF",
    shadows: [ShadowSetting(color: "#00000033", blurRadius: RemSetting.byPx(12))],
  ),

  "img-loading": container(bg: "#e0e0e0", font: "#fff"),

  "txt-cover": container(
    bgGradient: GradientSetting.linear(colors: ["#0000004d", "transparent"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),

  "focus": container(
    bgGradient: GradientSetting.linear(colors: ["#0000004d", "transparent"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),
};
