import 'dart:convert';
import 'dart:ui';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/service/cache.dart';
import 'package:get/get.dart';

class LanguageService {
  LanguageService._internal();

  factory LanguageService() => _instance;
  static final LanguageService _instance = LanguageService._internal();

  // 单例变量 永驻内存
  String chosen="";

  // {"chosen":"zh_CN","fallback":"en_US"}
  updateByJson(json) async {
    String fallback = json["fallback"] as String;
    String chosen = json["chosen"] as String;
    await Future.wait<dynamic>([
      chosen != fallback
          ? _I18nWords._append(fallback).then((_) {
              Get.fallbackLocale = parseLocale(fallback);
            })
          : ()async{Get.fallbackLocale = parseLocale(fallback);}(),
      choose(chosen),
    ]);
  }

  choose(String language) async {
    await _I18nWords._append(language);
    Get.updateLocale(parseLocale(language));
    this.chosen = language;
  }

  static Locale parseLocale(String code) {
    final normalized = code.replaceAll('-', '_');
    final parts = normalized.split('_');
    return Locale(parts[0], parts.length > 1 ? parts[1] : '');
  }
}

class LanguageInfo {
  static const table = 'language_info';
  static const key = 'info';

  static Future<Map<String, dynamic>> get() async {
    Map<String, dynamic>? info = await _fromCache();
    if (null == info) {
      info = await Api.language(null);
      if (info is! Map) return {};
      await CacheService.set(table, key, jsonEncode(info));
    }
    return info??{};
  }

  static Future<Map<String, dynamic>?> _fromCache() async {
    final str = await CacheService.get(table, key);
    if (str == null) return null;
    try {
      return jsonDecode(str);
    } catch (e) {
      Log.err('Failed to decode language cache from Hive', e);
      return null;
    }
  }
}

class _I18nWords {
  // 记录已加载语言包，防止重复下载
  static final Set<String> _loadedLanguages = {};
  static const table = 'i18n_words';

  static _append(String? langCode) async {
    if (langCode == null || langCode.toString().isEmpty) return;
    if (_loadedLanguages.contains(langCode)) {
      // 已经加载过，跳过
      return;
    }
    // 1. 尝试从 Hive 缓存加载
    Map<String, String>? kv = await _getFromCache(langCode);
    if (kv == null) {
      var response = await Api.translate({"language": langCode}) ?? {};
      if (response is! Map) return;
      // 3. 缓存到 Hive
      kv = response.map((k, v) => MapEntry(k.toString(), v.toString()));
      await CacheService.set(table, langCode, jsonEncode(kv));
    }
    if (kv == null) return;
    // 更新翻译
    //Get.clearTranslations();
    Get.appendTranslations({langCode: kv});
    _loadedLanguages.add(langCode);
  }

  static Future<Map<String, String>?> _getFromCache(String langCode) async {
    final str = await CacheService.get(table, langCode);
    if (str == null) return null;
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(str);
      return jsonMap.map((k, v) => MapEntry(k.toString(), v.toString()));
    } catch (e) {
      Log.err('Failed to decode language cache from Hive', e);
      return null;
    }
  }
}
