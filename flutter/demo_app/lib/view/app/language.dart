import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/store/language.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:get/get.dart';

class AppLanguage extends StatelessWidget {
  final dynamic params;

  AppLanguage({this.params, super.key});

  // 不能到处LanguageStore(),因为不是单例
  @override
  Widget build(BuildContext context) {
    LanguageStore languageStore = Get.find();

    return Obx(() {
      // 监听 list 和 chosen 变化
      if (languageStore.list.isEmpty) {
        // 数据没加载出来，显示加载指示器或空状态
        return ContainerFormat("container", Center(child: CircularProgressIndicator()));
      }

      return ContainerFormat("container", padding: EdgeInsetsGeometry.symmetric(vertical:  AppStyle.gap,),ListView.separated(
        shrinkWrap: true,
        itemCount: languageStore.list.length,
        padding:  EdgeInsets.symmetric( horizontal: AppStyle.gap),
        itemBuilder: (context, index) {
          final lang = languageStore.list[index];
          final selected = (languageStore.chosen.value == lang["code"]);
          return TextButton(
            // style: ElevatedButton.styleFrom(backgroundColor: selected ? Colors.blue : null, padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
            onPressed: () => languageStore.choose(lang["code"]!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lang["name"]!,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: selected ?AppStyle.getMainColor() : null),
                  ),
                ),
                Text(lang["flag"]!, style: TextStyle()),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
      ));
    });
  }
}
