import 'package:flutter3/style/setting/color-setting.dart';
import 'package:flutter3/style/setting/container.dart';
import 'package:flutter3/style/setting/rem-setting.dart';

var fonts = {
  "title": ColorSetting(light: "#323233", dark: "#FFFFFF"),
  "name": ColorSetting(light: "#646566", dark: "#adb6c4"),
  "txt": ColorSetting(light: "#737272", dark: "#55657e"),
  "ghost": ColorSetting(light: "#BBBBBB", dark: "#BBBBBB"),
};

var defaultFont = fonts["txt"];

var mask = ColorSetting(light: "#00000080", dark: "#00000080");
var border = ColorSetting(light: "#e3e3e31a", dark: "#e3e3e31a");
var shadow = ColorSetting(light: "#41454940", dark: "#41454940");

var lightLevel = ["#f7f8ff", "#ffffff", "#f6f6f6", "#E4E4E4"];
var darkLevel1 = ["#0e131b", "#141d29", "#0f0e0e", "#000000"];
var darkLevel2 = ["#333333", "#141d29", "#0f0e0e", "#000000"];
var darkLevel3 = ["#161823", "#141d29", "#0f0e0e", "#000000"];
// idea
var darkLevel4 = ["rgb(32,34,36)", "rgb(23,23,26)", "rgb(18,18,18)", "#000000"];
var darkLevel4font=["rgb(212,212,212)"];// 还是 #55657e 更不刺眼
var darkLevel5 = ["rgb(46,46,46)", "rgb(23,23,26)", "#0f0e0e", "#000000"];

// 🎨 常见主题色分类
// 颜色	色值示例	场景/说明
// 蓝色	#2196F3 / #007BFF	科技、企业、通用系统，冷静、可信赖（如微信、Facebook）
// 红色	#F44336 / #E53935	电商、促销、警示，强烈吸引注意（如京东、YouTube）
// 绿色	#4CAF50 / #28A745	健康、环保、成功状态（如支付宝、WhatsApp）
// 紫色	#9C27B0 / #7E57C2	创意、女性向、美妆类（如Yahoo、Twitch）
// 橙色	#FF9800 / #FFA500	活力、食物、儿童类（如淘宝、SoundCloud）
// 黑色/深灰	#212121 / #333333	极简、专业、高端（如 Apple 官网、奢侈品）
// 黄色	  #FFEB3B / #FFC107	活泼、注意力提示、游戏类（如新浪微博）
// 青色 / 蓝绿	#00BCD4 / #17A2B8	时尚、科技、医疗类（如滴滴）
// ColorSetting(light: "#7E57C2", dark: "#7E57C2"),
var colors = [
  ColorSetting(light: "#ff4b52", dark: "#e57373"),     // 柔和红
  ColorSetting(light: "#F44336", dark: "#ef5350"),     // 柔红
  ColorSetting(light: "#E53935", dark: "#f0625d"),     // 暖红
  ColorSetting(light: "#FFA500", dark: "#ffcc80"),     // 浅柔橙
  ColorSetting(light: "#FF9800", dark: "#ffb74d"),     // 柔橙
  ColorSetting(light: "#FFC107", dark: "#ffd54f"),     // 柔琥珀
  ColorSetting(light: "#FFEB3B", dark: "#fff176"),     // 柔黄（尽量避免强黄）
  ColorSetting(light: "#4CAF50", dark: "#66bb6a"),     // 柔和绿
  ColorSetting(light: "#28A745", dark: "#5cbf78"),     // 草绿柔和版
  ColorSetting(light: "#00BCD4", dark: "#4dd0e1"),     // 柔青
  ColorSetting(light: "#17A2B8", dark: "#4fc3f7"),     // 柔蓝绿
  ColorSetting(light: "#2196F3", dark: "#42a5f5"),     // 柔和蓝
  ColorSetting(light: "#007BFF", dark: "#338bff"),     // 柔和亮蓝
  ColorSetting(light: "#9C27B0", dark: "#ab47bc"),     // 柔紫
  ColorSetting(light: "#7E57C2", dark: "#9575cd"),     // 紫灰
  ColorSetting(light: "#212121", dark: "#eeeeee"),     // 黑变浅灰（适合文字）
  ColorSetting(light: "#333333", dark: "#e0e0e0"),     // 深灰变为中亮灰
];

var page = {
  "browser": container(
    bg: ColorSetting(light: "#f7f8ff", dark: "#293549"),
    bgGradient: GradientSetting.linear(
      colors: [
        ColorSetting(light: "#81FFEF", dark: "#293549"),
        ColorSetting(light: "#F067B4", dark: "#293549"),
      ],
      stops: [0.1, 1],
      begin: top_right,
      end: bottom_left,
    ),
  ),

  "page": container(
    bg: ColorSetting(light: "#f7f8ff", dark: "#0e131b"),
    bgGradient: GradientSetting.linear(
      colors: [
        ColorSetting(light: "#7ec1f7", dark: "#0e131b"),
        ColorSetting(light: "#FFF", dark: "#0e131b"),
      ],
      stops: [0, .8],
      begin: top_right,
      end: bottom_left,
    ),
  ),

  "section": container(
    bg: ColorSetting(light: "#ffffff", dark: "#141d29"),
    margin: PaddingSetting(vertical: RemSetting.ofRem(.1)),
    padding: PaddingSetting(all: RemSetting.ofRem(.2)),
  ),

  // 通用容器
  "container": container(
    // img: "assets/images/game1.jpg",
    margin: PaddingSetting(horizon: RemSetting.ofRem(.2), top: RemSetting.ofRem(.1)),
    padding: PaddingSetting(horizon: RemSetting.ofRem(.2), vertical: RemSetting.ofRem(.05)),
    border: BorderSetting(borderRadius: RemSetting.ofRem(.14)),
    bg: ColorSetting(light: "#ffffff", dark: "#141d29"),
    shadows: [
      ShadowSetting(
        color: ColorSetting(light: "#00000033", dark: "#00000033"),
        blurRadius: RemSetting.byPx(12),
      ),
    ],
  ),

  "img-loading": container(
    bg: ColorSetting(light: "#e0e0e0", dark: "#2a2f3a"),
    font: ColorSetting(light: "#FFF", dark: "#474747"),
  ),

  "txt-cover": container(
    bgGradient: GradientSetting.linear(
      colors: [
        ColorSetting(light: "#0000004d", dark: "#00000080"),
        ColorSetting(light: "transparent", dark: "transparent"),
      ],
      stops: [0, .9],
      begin: bottom_center,
      end: top_center,
    ),

    font: ColorSetting(light: "#FFF", dark: "#B0BEC5"),
  ),

};
