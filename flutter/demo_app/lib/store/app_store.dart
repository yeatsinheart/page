import 'dart:convert';

import 'package:flutter3/store/save_as_json.dart';
import 'package:get/get.dart';

class AppStore extends SaveAsJsonStore<Map<String, dynamic>>  {
  final Rxn<Map<String, dynamic>?> data = Rxn<Map<String, dynamic>?>();
  AppStore(): super('app_store');

  @override
  initFromJson(json) async{
    data.value = json;
    data.refresh();
    await save();// 保存到缓存中
  }

  @override
  toJson() {
    return jsonEncode(data.value);
  }


}

