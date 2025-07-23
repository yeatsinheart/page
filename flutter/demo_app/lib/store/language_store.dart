import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';

Locale parseLocale(String code) {
  final normalized = code.replaceAll('-', '_');
  final parts = normalized.split('_');
  return Locale(parts[0], parts.length > 1 ? parts[1] : '');
}
enum LanguageEnum{
  en_US,zh_CN

}
class LanguageStore extends GetxService {


  /*late Timer _timer;
  void change() async {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
      //_locale.value=Locale(locale.countryCode=="zh"?"en":"zh") ;
      String code = Random().nextBool()?"en_US":"zh_CN";
      Get.put(LanguageStore()).loadLanguage(code);
    });
  }*/
  // 当前语言
  final _locale = "en_US".obs;
  final _translations = _DynamicTranslations();
  String get locale => _locale.value;

  Future<LanguageStore> init() async {
    await loadLanguage('en_US'); // 默认语言
    //change();
    return this;
  }

  Future<void> loadLanguage(String langCode) async {
    // 🛰️ 假设这里是调用后端接口获取翻译
    Map<String, String> fetched = await fetchRemoteTranslations(langCode);

    // 包装成 GetX 格式
    final wrapped = {langCode: fetched};

    // 更新翻译
    _translations.setTranslations(wrapped);
    Get.updateLocale(parseLocale(langCode));
    _locale.value=langCode;
  }

  Future<Map<String, String>> fetchRemoteTranslations(String langCode) async {
//    await Future.delayed(Duration(milliseconds: 300)); // 模拟网络延迟

    if (langCode == 'zh_CN') {
      return {
        '微信': '微信',
      };
    } else {
      return {
        '首页': 'home',
        '发现': 'discover',
        '我': 'me',
        '微信': 'wechat',
        '热门': '🔥Hot',
        'https://cdn-icons-png.flaticon.com/128/619/619153.png': 'https://cdn-icons-png.flaticon.com/128/428/428094.png',
      };
    }
  }

  Translations get translations => _translations;
}

class _DynamicTranslations extends Translations {
  Map<String, Map<String, String>> _translations = {};
  /// 用于动态设置翻译表
  void setTranslations(Map<String, Map<String, String>> newTranslations) {
    _translations = newTranslations;
  }
  @override
  Map<String, Map<String, String>> get keys => _translations;
}