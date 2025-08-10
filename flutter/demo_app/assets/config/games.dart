
import 'dart:convert';
import 'dart:io';
/// 所有资源域名->后端时替换成 http://cdn.com/xxxx
///
/// 产商->状态[启用，维护，停用，倒闭]：全盘唯一 游戏请求方式[get,post-json,post-form,local-html]  调用配置 捞取配置
/// 产商账号【share,tenant……】 扣钱方式[预存，调用] 接入配置
///
/// 游戏分类：品牌[] 游戏[]
/// 品牌表：游戏分类[]
/// 游戏表[维护，启用，隐藏]  品牌 产商 品牌排序权重
/// 玩法分类： 游戏排序权重 归属品牌1分类对1品牌
///
/// 游戏分类->品牌->玩法分类->游戏
/// 游戏需要分页获取。
///
/// 分类->品牌排序
/// 品牌->分类排序
/// 品牌->游戏排序
var categories=[
  {"categoryId":"","nameI18n":"1","img1x1":"","home":""}
];
var brands=[
  {"brandId":"","nameI18n":"1","img1x1":"","img3x4":""}
];
var games=[
  {"gameId":"","nameI18n":"1","img1x1":"","img3x4":"",
    "categoryId":"","brandId":""
  }
];

main() async {
  var config = {};
  print(jsonEncode(config));
  // 同步到配置文件中 方便调试
  String path = 'assets/config/game.json';
  final json = await readJsonFile(path);

  json["style"]["maxWidth"] = 435.0;
  // 412屏幕 .3显示16号字体 .26显示14号字体  .22显示12号字体  每个字体差4
  // 750 设计稿中的正文字体大小 通用字号
  json["style"]["fontSize"] = 27.0;
  json["style"]["gap"] = 20.0;
  json["style"]["radius"] = 14.0;
  json["style"]["lineHeight"] = 1.2;

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
