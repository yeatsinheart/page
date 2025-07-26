import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';


// 其实就是扩展String .tr 其实依赖的是 BuildContext 的 rebuild，而不是 Obx 或 GetX。
// /Users/apple/.pub-cache/hosted/pub.dev/get-4.7.2/lib/get_utils/src/extensions/internacionalization.dart
class LanguageStore extends GetxService {
  // 当前语言
  final _locale = "".obs;

  String get locale => _locale.value;

  Future<LanguageStore> init() async {
    await loadLanguage('en_US'); // 默认语言
    return this;
  }

  @override
  void onInit() {
    super.onInit();
    loadLanguage('en_US');
  }

  Future<void> loadLanguage(String langCode) async {
    if (locale == langCode) return;
    // 🛰️ 假设这里是调用后端接口获取翻译
    Map<String, String> fetched = await fetchRemoteTranslations(langCode);
    // 更新翻译
    Get.addTranslations({langCode: fetched});
    Get.updateLocale(parseLocale(langCode));
    _locale.value = langCode;
  }

  Future<Map<String, String>> fetchRemoteTranslations(String langCode) async {
    await Future.delayed(Duration(milliseconds: 1000)); // 模拟网络延迟

    if (langCode == 'zh_CN') {
      return {'微信': '微信xxx', 'testImage': 'https://pic.616pic.com/photoone/00/02/58/618cf527354c35308.jpg!/fw/1120'};
    } else {
      return {'testImage': 'https://pic.616pic.com/photoone/00/06/02/618e27a728fd34751.jpg!/fw/1120', '首页': 'home', '发现': 'discover', '我': 'me', '微信': 'wechat', '热门': '🔥Hot', 'https://cdn-icons-png.flaticon.com/128/619/619153.png': 'https://cdn-icons-png.flaticon.com/128/428/428094.png'};
    }
  }
}

Locale parseLocale(String code) {
  final normalized = code.replaceAll('-', '_');
  final parts = normalized.split('_');
  return Locale(parts[0], parts.length > 1 ? parts[1] : '');
}
