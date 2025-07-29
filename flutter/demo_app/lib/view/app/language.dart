import 'package:flutter/material.dart';
import 'package:flutter3/store/language.dart';
import 'package:get/get.dart';

class AppLanguage extends StatelessWidget {
  final dynamic params;

  AppLanguage({this.params, super.key});

  // 不能到处LanguageStore(),因为不是单例
  @override
  Widget build(BuildContext context) {
    LanguageStore languageStore = Get.find();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Obx(() {
        // 监听 list 和 chosen 变化
        if (languageStore.list.isEmpty) {
          // 数据没加载出来，显示加载指示器或空状态
          return Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: languageStore.list.length,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          itemBuilder: (context, index) {
            final lang = languageStore.list[index];
            final selected = (languageStore.chosen.value == lang["code"]);
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: selected ? Colors.blue : null, padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
              onPressed: () => languageStore.choose(lang["code"]!),
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
        );
      }),
    );
  }
}
