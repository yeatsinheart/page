import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/service/language.dart';
import 'package:flutter3/store/cache_as_json.dart';
import 'package:get/get.dart';

// 其实就是扩展String .tr 其实依赖的是 BuildContext 的 rebuild，而不是 Obx 或 GetX。
// /Users/apple/.pub-cache/hosted/pub.dev/get-4.7.2/lib/get_utils/src/extensions/internacionalization.dart
class LanguageStore extends GetxController {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  // GetxController 非单例 单页面使用，页面注销就不再用 类似 state full 的 state中的变量值。

  final  chosen ="".obs;
  final list = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    LanguageInfo.get().then((info){
      chosen.value=info["chosen"];
      list.assignAll(info["list"] as List);
      //refresh();
    });
  }

  choose(String code) async{
    await LanguageService().choose(code);
    chosen.value=code;
  }


}
