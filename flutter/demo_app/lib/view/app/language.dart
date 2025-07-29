import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter3/store/language.dart';

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
    LanguageStore();
    final currentLocale = LanguageStore().data.value["language"];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300), // 限制最大宽度
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: LanguageStore().data.value["list"]!.length,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        itemBuilder: (context, index) {

          final lang = LanguageStore().data.value["list"][index];

          final selected = currentLocale == lang["code"];

          return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: selected ? Colors.blue : null, padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
            onPressed: () => LanguageStore().choose(lang["code"]!),
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
