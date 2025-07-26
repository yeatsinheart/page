import 'package:flutter/material.dart';
import 'package:flutter3/store/loading_store.dart';
import 'package:get/get.dart';
import 'package:flutter3/store/language_store.dart';

class AppLanguage extends StatelessWidget {
  final dynamic params;

  const AppLanguage({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    //这三个语言（波斯语、乌尔都语、希伯来语）是 从右到左（RTL） 的语言。
    // 当你用 Text(lang["flag"]!) 显示国旗时，它被当作“文字的一部分”，在 RTL 排版模式下就会自动 跑到右边。
    // {"name": "فارسی", "flag": "🇮🇷", "code": "fa_IR"},
    // {"name": "اردو", "flag": "🇵🇰", "code": "ur_PK"},
    // {"name": "עברית", "flag": "🇮🇱", "code": "he_IL"},

    final currentLocale = Get.find<LanguageStore>().locale;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300), // 限制最大宽度
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: languages.length,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        itemBuilder: (context, index) {
          final lang = languages[index];
          final selected = currentLocale == lang["code"];

          return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: selected ? Colors.blue : null, padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
            onPressed: () => Get.find<LanguageStore>().loadLanguage(lang["code"]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lang["name"]!,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16, color: selected ? Colors.white : Colors.black),
                  ),
                ),
                Text(lang["flag"]!, style: const TextStyle(fontSize: 20)),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1, color: Colors.grey),
      ),
    );
  }
}

List<Map<String, String>> languages = [
  {"name": "简体中文", "flag": "🇨🇳", "code": "zh_CN"},
  {"name": "繁體中文", "flag": "🇹🇼", "code": "zh_TW"},
  {"name": "English", "flag": "🇺🇸", "code": "en_US"},
  {"name": "Filipino/Tagalog", "flag": "🇵🇭", "code": "fil_PH"},
  // {"name": "日本語", "flag": "🇯🇵", "code": "ja_JP"},
  // {"name": "한국어", "flag": "🇰🇷", "code": "ko_KR"},
  // {"name": "Español", "flag": "🇪🇸", "code": "es_ES"},
  // {"name": "Français", "flag": "🇫🇷", "code": "fr_FR"},
  // {"name": "Deutsch", "flag": "🇩🇪", "code": "de_DE"},
  // {"name": "Português", "flag": "🇵🇹", "code": "pt_PT"},
  // {"name": "Русский", "flag": "🇷🇺", "code": "ru_RU"},
  // {"name": "Italiano", "flag": "🇮🇹", "code": "it_IT"},
  // {"name": "Türkçe", "flag": "🇹🇷", "code": "tr_TR"},
  // {"name": "Tiếng Việt", "flag": "🇻🇳", "code": "vi_VN"},
  // {"name": "ภาษาไทย", "flag": "🇹🇭", "code": "th_TH"},
  // {"name": "हिन्दी", "flag": "🇮🇳", "code": "hi_IN"},
  // {"name": "বাংলা", "flag": "🇧🇩", "code": "bn_BD"},
  // {"name": "Bahasa Indonesia", "flag": "🇮🇩", "code": "id_ID"},
  // {"name": "ລາວ", "flag": "🇱🇦", "code": "lo_LA"},
  // {"name": "Українська", "flag": "🇺🇦", "code": "uk_UA"},
  //
  // {"name": "Polski", "flag": "🇵🇱", "code": "pl_PL"},
  // {"name": "Nederlands", "flag": "🇳🇱", "code": "nl_NL"},
  //
  // {"name": "Svenska", "flag": "🇸🇪", "code": "sv_SE"},
  // {"name": "Čeština", "flag": "🇨🇿", "code": "cs_CZ"},
  // {"name": "Magyar", "flag": "🇭🇺", "code": "hu_HU"},
  // {"name": "Ελληνικά", "flag": "🇬🇷", "code": "el_GR"},
  // {"name": "Română", "flag": "🇷🇴", "code": "ro_RO"},
  // {"name": "Dansk", "flag": "🇩🇰", "code": "da_DK"},
  // {"name": "Suomi", "flag": "🇫🇮", "code": "fi_FI"},
  // {"name": "Norsk", "flag": "🇳🇴", "code": "no_NO"},
  // {"name": "ქართული", "flag": "🇬🇪", "code": "ka_GE"},
  // {"name": "Slovenčina", "flag": "🇸🇰", "code": "sk_SK"},
  // {"name": "Srpski", "flag": "🇷🇸", "code": "sr_RS"},
  // {"name": "Hrvatski", "flag": "🇭🇷", "code": "hr_HR"},
  // {"name": "Malay", "flag": "🇲🇾", "code": "ms_MY"},
];
