import 'dart:convert';
import 'dart:io';

import 'package:flutter3/style/setting/container.dart';

var setting = {
  "browser": container(
    bgGradient: gradient_linear(colors: ["#81FFEF", "#F067B4"], stops: [0.1, 1], begin: top_right, end: bottom_left),
  ),
  "page": container(
    padding: Padding(top: 0),
    bgGradient: gradient_linear(colors: ["#7ec1f7", "#FFF"], stops: [0, .8], begin: top_right, end: bottom_left),
  ),
  "color1": container(bg: "#2196F3", font: "#fff"),
  "color1-reverse": container(
    bg: "#2196F3",
    border: Border(color: "#2196F3"),
  ),
  "img-loading": container(bg: "#e0e0e0", font: "#fff"),
  "marquee": container(padding: Padding(left: 0.2, right: 0.2), bg: "transparent", font: "#000"),
  "game-category-tab": container(bg: "#fff", font: "#000"),
  "txt-cover": container(
    bgGradient: gradient_linear(colors: ["#0000004d", "transparent"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),

  "bar": container(bg: "#3f15d1", font: "#000"),
  "bar-brand": container(bg: "#FF403A", font: "#FFF"),
  "bar-bottom": container(
    bgGradient: gradient_linear(colors: ["#7ec1f7", "FFF"], stops: [0, .8], begin: bottom_center, end: top_center),
    font: "#fff",
  ),
};

main() async {
  print(jsonEncode(setting));
  // 同步到配置文件中 方便调试
  String path = 'assets/config/bootstrap.json';
  final json = await readJsonFile(path);
  json["style"]["container-setting"] = setting;
  print('');
  print('');
  print('');
  final file = File(path);
  //await file.writeAsString(JsonEncoder.withIndent('  ').convert(json));
  print('✅ $path updated successfully');
}

Future<Map<String, dynamic>> readJsonFile(String path) async {
  final file = File(path);
  final contents = await file.readAsString();
  return jsonDecode(contents);
}
