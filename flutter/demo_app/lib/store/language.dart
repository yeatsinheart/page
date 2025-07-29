import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter3/request/api.dart';
import 'package:flutter3/store/cache_as_json.dart';
import 'package:get/get.dart';

// 其实就是扩展String .tr 其实依赖的是 BuildContext 的 rebuild，而不是 Obx 或 GetX。
// /Users/apple/.pub-cache/hosted/pub.dev/get-4.7.2/lib/get_utils/src/extensions/internacionalization.dart
class LanguageStore extends GetxController {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  // GetxController 单页面使用，页面注销就不再用
  late final RxString chosen ;
  late final Rx<List> list;

  @override
  void onInit() {
    super.onInit();
    // 从缓存中读取
    chosen.value="";
    // 网络异步更新语言支持列表，或者 根据语言版本号来更新语言？

    list.value=[];
  }

  final Rx<Map<String, dynamic>> data = Rx<Map<String, dynamic>>({});

  @override
  @override
  toJson() {
    return data.value;
  }

}
