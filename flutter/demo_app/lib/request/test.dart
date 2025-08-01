import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiTest {
  static dynamic test(RequestOptions options) {
    // 只有本地运行开发模式才能模拟数据
    if (!kDebugMode) return null;

    if (options.path == "translate") {
      String language = options.data["language"] ?? "en_US";
      if (language == 'zh_CN') {
        return {};
      } else {
        return {'首页': 'home', '发现': 'discover', '我': 'me', '微信': 'wechat', '热门': '🔥Hot'};
      }
    }

    if (options.path == "language") {
      return {
        "list": [
          {"name": "简体中文", "flag": "🇨🇳", "code": "zh_CN"},
          {"name": "English", "flag": "🇺🇸", "code": "en_US"},
          {"name": "繁體中文", "flag": "🇹🇼", "code": "zh_TW"},
          {"name": "Filipino/Tagalog", "flag": "🇵🇭", "code": "fil_PH"},

          {"name": "日本語", "flag": "🇯🇵", "code": "ja_JP"},
          {"name": "한국어", "flag": "🇰🇷", "code": "ko_KR"},
          {"name": "Español", "flag": "🇪🇸", "code": "es_ES"},
          {"name": "Français", "flag": "🇫🇷", "code": "fr_FR"},
          {"name": "Deutsch", "flag": "🇩🇪", "code": "de_DE"},
          {"name": "Português", "flag": "🇵🇹", "code": "pt_PT"},
          {"name": "Русский", "flag": "🇷🇺", "code": "ru_RU"},
          {"name": "Italiano", "flag": "🇮🇹", "code": "it_IT"},
          {"name": "Türkçe", "flag": "🇹🇷", "code": "tr_TR"},
          {"name": "Tiếng Việt", "flag": "🇻🇳", "code": "vi_VN"},
          {"name": "ภาษาไทย", "flag": "🇹🇭", "code": "th_TH"},
          {"name": "हिन्दी", "flag": "🇮🇳", "code": "hi_IN"},
          {"name": "বাংলা", "flag": "🇧🇩", "code": "bn_BD"},
          {"name": "Bahasa Indonesia", "flag": "🇮🇩", "code": "id_ID"},
          {"name": "ລາວ", "flag": "🇱🇦", "code": "lo_LA"},
          {"name": "Українська", "flag": "🇺🇦", "code": "uk_UA"},

          {"name": "Polski", "flag": "🇵🇱", "code": "pl_PL"},
          {"name": "Nederlands", "flag": "🇳🇱", "code": "nl_NL"},

          {"name": "Svenska", "flag": "🇸🇪", "code": "sv_SE"},
          {"name": "Čeština", "flag": "🇨🇿", "code": "cs_CZ"},
          {"name": "Magyar", "flag": "🇭🇺", "code": "hu_HU"},
          {"name": "Ελληνικά", "flag": "🇬🇷", "code": "el_GR"},
          {"name": "Română", "flag": "🇷🇴", "code": "ro_RO"},
          {"name": "Dansk", "flag": "🇩🇰", "code": "da_DK"},
          {"name": "Suomi", "flag": "🇫🇮", "code": "fi_FI"},
          {"name": "Norsk", "flag": "🇳🇴", "code": "no_NO"},
          {"name": "ქართული", "flag": "🇬🇪", "code": "ka_GE"},
          {"name": "Slovenčina", "flag": "🇸🇰", "code": "sk_SK"},
          {"name": "Srpski", "flag": "🇷🇸", "code": "sr_RS"},
          {"name": "Hrvatski", "flag": "🇭🇷", "code": "hr_HR"},
          {"name": "Malay", "flag": "🇲🇾", "code": "ms_MY"},
        ],
        "chosen": "zh_CN",
        "fallback": "zh_CN",
      };
    }
    /*if (options.path == "init") {
      return {};
    }*/

    // 默认非模拟接口
    return null;
  }
}
