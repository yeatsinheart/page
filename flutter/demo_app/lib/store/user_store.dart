import 'dart:convert';

import 'package:flutter3/request/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStore extends GetxService {
  final RxnString token = RxnString();
  final Rxn<Map<String, dynamic>?> data = Rxn<Map<String, dynamic>?>();


  void setFromJson(Map<String, dynamic> json) {
    data.value = json;
    data.refresh();
  }

  // 可以写异步初始化、网络请求等
  @override
  void onInit() {
    super.onInit();
    loadFromCache();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> saveToCache() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_token', token.value!);
    prefs.setString('user_data', jsonEncode(data.value));
  }

  Future<void> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('user_token') ?? null;
    if(null!=token.value){
      ApiRequest.refreshUser(null);
    }
    final user_data = prefs.getString('user_data');
    setFromJson(null==user_data?null:jsonDecode(user_data));
  }

  void clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user_token");
    await prefs.remove("user_data");
  }

}

