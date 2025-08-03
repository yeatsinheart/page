import 'dart:convert';
import 'dart:io';

import 'package:flutter3/style/setting/rem-setting.dart';
import 'package:flutter3/style/setting/container.dart';

import 'bars.dart';
import 'notifies.dart';
import 'buttons.dart';
import 'inputs.dart';
import 'page.dart';

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
var colors = [
  "#ff4b52",
  "#2196F3",
  "#007BFF",
  "#F44336",
  "#E53935",
  "#4CAF50",
  "#28A745",
  "#9C27B0",
  "#7E57C2",
  "#FF9800",
  "#FFA500",
  "#FFEB3B",
  "#FFC107",
  "#00BCD4",
  "#17A2B8",
  "#212121",
  "#333333",
];

var setting = {

  "tooltip": container(margin: PaddingSetting(all: RemSetting.ofRem(.2)), bg: "#333",
      border: BorderSetting(borderRadius: RemSetting.byPx(6)),
      font: "#fff", padding: PaddingSetting(all: RemSetting.ofRem(.3))),

  "modal": container(
    margin: PaddingSetting(all: RemSetting.ofRem(.2)),
    bg: "#fff",
    border: BorderSetting(borderRadius: RemSetting.ofRem(.14)),
    shadows: [ShadowSetting(color: "#00000033", blurRadius: RemSetting.byPx(12))],
  ),

  "card": container(
    margin: PaddingSetting(all:  RemSetting.ofRem(.2)),
    bgGradient: GradientSetting.linear(colors: ["#2196F3", "#21CBF3"]),
    border: BorderSetting(color: "#ccc",borderRadius: RemSetting.ofRem(.14)),
    shadows: [ShadowSetting(color: "#0000001a")],
  ),

  "list-item": container(
    margin: PaddingSetting(all: RemSetting.ofRem(.2)),
    bg: "#fff",
    border: BorderSetting(color: "#ddd",borderRadius: RemSetting.ofRem(.14)),
    padding: PaddingSetting(all: RemSetting.ofRem(.5)),
  ),

};

main() async {
  var config = {...page,...bars,...buttons,...inputs,...notifies,...setting,};
  print(jsonEncode(config));
  // 同步到配置文件中 方便调试
  String path = 'assets/config/bootstrap.json';
  final json = await readJsonFile(path);

  json["style"]["colors"] = colors;
  json["style"]["maxWidth"] = 570;
  json["style"]["gap"] = .22;
  json["style"]["fontSize"] = .22;
  json["style"]["lineHeight"] = 1.5;
  json["style"]["radius"] = .14;

  json["style"]["font"] = fonts;
  json["style"]["mask"] = mask;
  json["style"]["border"] = border;
  json["style"]["shadow"] = shadow;

  json["style"]["color-plan"] = config;


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
