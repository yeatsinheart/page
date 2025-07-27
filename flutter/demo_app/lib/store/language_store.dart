import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/store/save_as_json.dart';
import 'package:get/get.dart';

// 其实就是扩展String .tr 其实依赖的是 BuildContext 的 rebuild，而不是 Obx 或 GetX。
// /Users/apple/.pub-cache/hosted/pub.dev/get-4.7.2/lib/get_utils/src/extensions/internacionalization.dart
class LanguageStore extends SaveAsJsonStore<LanguageStore> {
  final Rx<Map<String, dynamic>> data = Rx<Map<String, dynamic>>({});
  LanguageStore(): super('language_store');

  @override
  initFromJson(json) async{
    data.value = json;
    choose(json["language"]);
  }

  @override
  toJson() {
    return data.value;
  }

  choose(String language) async {
    await loadLanguage(language);
    Get.updateLocale(parseLocale(language));
    data.value["language"] = language;
    await save();// 保存到缓存中
    data.refresh();
  }
  set(List<dynamic> list,String fallback) async {
    // 初始默认语言 .update((_)=>data) 是用于 RxMap（即 Rx<Map>）的；
    data.value["list"] = list;
    String language= list[0]["code"];
    await loadLanguage(language);
    await loadLanguage(fallback);
    // 英文保底 最好能动态保底
    Get.fallbackLocale = parseLocale(fallback);
    choose(language);
  }

  Future<void> loadLanguage(String langCode) async {
    if (data.value["language"] == langCode) return;
    // 🛰️ 假设这里是调用后端接口获取翻译
    Map<String, String> fetched = await fetchRemoteTranslations(langCode);
    // 更新翻译
    //Get.clearTranslations();
    Get.appendTranslations({langCode: fetched});
  }

  Future<Map<String, String>> fetchRemoteTranslations(String langCode) async {
    return await ApiRequest.translate({"language":langCode})??{};
  }
}

Locale parseLocale(String code) {
  final normalized = code.replaceAll('-', '_');
  final parts = normalized.split('_');
  return Locale(parts[0], parts.length > 1 ? parts[1] : '');
}
