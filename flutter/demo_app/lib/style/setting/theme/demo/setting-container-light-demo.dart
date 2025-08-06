import 'dart:convert';
import 'dart:io';

import 'bars.dart';
import 'notifies.dart';
import 'buttons.dart';
import 'inputs.dart';
import 'page.dart';

main() async {
  var config = {...page,...bars,...buttons,...inputs,...notifies,};
  print(jsonEncode(config));
  // 同步到配置文件中 方便调试
  String path = 'assets/config/bootstrap.json';
  final json = await readJsonFile(path);

  json["style"]["maxWidth"] = 570;
  json["style"]["gap"] = .22;
  // 412屏幕 。29显示16号字体 .26显示14号字体  .22显示12号字体
  json["style"]["fontSize"] = .29;
  json["style"]["lineHeight"] = 1.5;
  json["style"]["radius"] = .14;

  json["style"]["colors"] = colors;
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
