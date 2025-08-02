import 'package:flutter3/style/setting/container.dart';

var fonts = {"title": "#ffffff", "name": "#dddddd", "txt": "#aaaaaa", "ghost": "#666666"};
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
    marginRem: PaddingSetting(horizon: .2, top: .1),
    paddingRem: PaddingSetting(horizon: .2, vertical: .05),
    //border: BorderSetting(color: "#ccc"),
    radiusRem: .14,
    bg: "#FFF",
    shadows: [ShadowSetting(color: "#00000033", blurRadius: 12)],
  ),

  "img-loading": container(bg: "#e0e0e0", font: "#fff"),

  "txt-cover": container(
    bgGradient: GradientSetting.linear(colors: ["#0000004d", "transparent"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),
};
