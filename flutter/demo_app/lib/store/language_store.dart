import 'dart:async';
import 'dart:convert';
import 'dart:ui';

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
    dynamic fallback = json["fallback"];
    await loadLanguage(fallback);//加载备用语言
    Get.fallbackLocale = parseLocale(fallback);
    choose(json["language"]);
    data.value = json;
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


  Future<void> loadLanguage(String langCode) async {
    if (data.value["language"] == langCode) return;
    // 🛰️ 假设这里是调用后端接口获取翻译
    var response = await Api.translate({"language":langCode})??{};

    Map<String, String> fetched = {};
    if (response is Map) {
      fetched = response.map(
            (k, v) => MapEntry(k.toString(), v.toString()),
      );
    }
    // 更新翻译
    //Get.clearTranslations();
    Get.appendTranslations({langCode: fetched});
  }
}

Locale parseLocale(String code) {
  final normalized = code.replaceAll('-', '_');
  final parts = normalized.split('_');
  return Locale(parts[0], parts.length > 1 ? parts[1] : '');
}
