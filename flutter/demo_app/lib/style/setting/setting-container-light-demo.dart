import 'dart:convert';
import 'dart:io';

import 'package:flutter3/style/setting/container.dart';

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

var fontsDark = {"title": "#ffffff", "name": "#dddddd", "txt": "#aaaaaa", "ghost": "#666666"};
var fonts = {"title": "#323233", "name": "#646566", "txt": "#737272", "ghost": "#BBB"};
var defaultFont=fonts["txt"];

var colors = ["#2196F3", "#007BFF", "#F44336", "#E53935", "#4CAF50", "#28A745", "#9C27B0", "#7E57C2", "#FF9800", "#FFA500", "#FFEB3B", "#FFC107", "#00BCD4", "#17A2B8", "#212121", "#333333"];
var setting = {
  "browser": container(
    bgGradient: GradientSetting.linear(colors: ["#81FFEF", "#F067B4"], stops: [0.1, 1], begin: top_right, end: bottom_left),
  ),
  "page": container(
    bgGradient: GradientSetting.linear(colors: ["#7ec1f7", "#FFF"], stops: [0, .8], begin: top_right, end: bottom_left),
  ),
  // 通用容器
  "container": container(
    paddingRem: PaddingSetting(all: .1),
    border: BorderSetting(color: "#ccc"),
    radiusRem: .1,
    bg: "#FFF",
    shadows: [ShadowSetting(color: "#00000033", blurRadius: 12)],
  ),

  "input": container(
    bg: "#f5f5f5",border: BorderSetting(color: "#ccc"),
    font: "#737272",
    radiusRem: .2,
    paddingRem: PaddingSetting(all: 0.3),
  ),

  "tooltip": container(bg: "#333", radiusRem: 6, font: "#fff", paddingRem: PaddingSetting(all: 0.3)),
  "modal": container(
    bg: "#fff",
    radiusRem: .14,
    shadows: [ShadowSetting(color: "#00000033", blurRadius: 12)],
  ),
  "card": container(
    bg: "#fafafa",
    border: BorderSetting(color: "#ccc"),
    radiusRem: .14,
    shadows: [ShadowSetting(color: "#0000001a")],
  ),

  "list-item": container(
    bg: "#fff",
    border: BorderSetting(color: "#ddd"),
    radiusRem: .14,
    paddingRem: PaddingSetting(all: 0.5),
  ),

  "color1": container(bg: colors[0], font: "#fff"),
  "color1-reverse": container(
    bg: colors[0],
    border: BorderSetting(color: colors[0]),
  ),

  "img-loading": container(bg: "#e0e0e0", font: "#fff"),
  "marquee": container(paddingRem: PaddingSetting(left: 0.2, right: 0.2), bg: "transparent", font: "#000"),

  "tab": container(bg: "#fff", font: "#000"),

  "txt-cover": container(
    bgGradient: GradientSetting.linear(colors: ["#0000004d", "transparent"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),

  // 高对比（用于主要提示）
  "warning": container(bg: "#FFC107", font: "#fff"),
  "error": container(bg: "#F44336", font: "#fff"),
  "success": container(bg: "#4CAF50", font: "#fff"),

  // 低对比（用于背景/说明）
  "warning-soft": container(bg: "#FEF5DF", font: "#D2B77E"),
  "error-soft": container(bg: "#FEECEC", font: "#D66B6B"), // 柔和红色背景 + 深红字体
  "success-soft": container(bg: "#E9F7EF", font: "#4CAF50"), // 柔和绿色背景 + 主绿字体

  "bar": container(bg: "#3f15d1", font: "#000"),
  "bar-brand": container(bg: "#FF403A", font: "#FFF"),
  "bar-bottom": container(
    bgGradient: GradientSetting.linear(colors: ["#7ec1f7", "#FFF"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#000",
  ),
};

main() async {
  print(jsonEncode(setting));
  // 同步到配置文件中 方便调试
  String path = 'assets/config/bootstrap.json';
  final json = await readJsonFile(path);
  json["style"]["color-plan"] = setting;
  print('');
  print('');
  print('');
  final file = File(path);
  await file.writeAsString(JsonEncoder.withIndent(' ').convert(json));
  //await file.writeAsString(jsonEncode(json));
  print('✅ $path updated successfully');
}

Future<Map<String, dynamic>> readJsonFile(String path) async {
  final file = File(path);
  final contents = await file.readAsString();
  return jsonDecode(contents);
}
