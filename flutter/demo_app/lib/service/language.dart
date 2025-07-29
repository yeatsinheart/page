import 'dart:convert';
import 'dart:ui';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/service/cache.dart';
import 'package:get/get.dart';

class LanguageService {
  static const cache_table = 'language_words';
  // 记录已加载语言包，防止重复下载
  static final Set<String> _loadedLanguages = {};

  // {"chosen":"zh_CN","fallback":"en_US"}
  static updateByJson(json) async {
    String fallback = json["fallback"];
    String chosen = json["chosen"];
    await Future.wait<dynamic>([
      appendLanguage(fallback).then((_) => Get.fallbackLocale = parseLocale(fallback)),
      appendLanguage(chosen).then((_) => Get.updateLocale(parseLocale(chosen))),
    ]);
  }

  static choose(String language) async {
    await appendLanguage(language);
    Get.updateLocale(parseLocale(language));
  }

  static Locale parseLocale(String code) {
    final normalized = code.replaceAll('-', '_');
    final parts = normalized.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : '');
  }

  static appendLanguage(String? langCode) async {
    if (langCode == null || langCode.toString().isEmpty) return;
    if (_loadedLanguages.contains(langCode)) {
      // 已经加载过，跳过
      return;
    }
    // 1. 尝试从 Hive 缓存加载
    Map<String, String>? kv = await _loadFromCache(langCode);
    if (kv == null) {
      var response = await Api.translate({"language": langCode}) ?? {};
      if (response is! Map) return;
      // 3. 缓存到 Hive
      kv = response.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    if (kv == null) return;

    // 更新翻译
    //Get.clearTranslations();
    Get.appendTranslations({langCode: kv});
    _loadedLanguages.add(langCode);
    await CacheService.set(cache_table,langCode, jsonEncode(kv));
  }

  static Future<Map<String, String>?> _loadFromCache(String langCode) async {
    final str = await CacheService.get(cache_table,langCode);
    if (str == null) return null;
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(str);
      return jsonMap.map((k, v) => MapEntry(k.toString(), v.toString()));
    } catch (e) {
      Log.err('Failed to decode language cache from Hive',e);
      return {};
    }
  }

}
