import 'package:flutter3/service/language.dart';
import 'package:get/get.dart';

// 其实就是扩展String .tr 其实依赖的是 BuildContext 的 rebuild，而不是 Obx 或 GetX。
// /Users/apple/.pub-cache/hosted/pub.dev/get-4.7.2/lib/get_utils/src/extensions/internacionalization.dart
class LanguageStore extends GetxService {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  LanguageStore._internal();

  static final LanguageStore _instance = LanguageStore._internal();

  factory LanguageStore() => _instance;

  listen(data) async {
    await LanguageService().updateByJson(data);
    list.assignAll(data["list"]);
    chosen.value=data["chosen"];
  }

  final chosen = "".obs;
  final list = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  choose(String code) async {
    await LanguageService().choose(code);
    chosen.value = code;
  }
}
