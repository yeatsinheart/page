import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/store/language.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:get/get.dart';

class AppLanguage extends StatelessWidget {
  final dynamic params;
  LanguageStore languageStore = Get.find();

  AppLanguage({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 监听 list 和 chosen 变化
      if (languageStore.list.isEmpty) {
        // 数据没加载出来，显示加载指示器或空状态
        return ContainerFormat("container", Center(child: CircularProgressIndicator()));
      }

      return ContainerFormat(
        "container",
        padding: EdgeInsetsGeometry.symmetric(vertical: AppStyle.gap),
        ListView.separated(
          shrinkWrap: true,
          itemCount: languageStore.list.length,
          padding: EdgeInsets.symmetric(horizontal: AppStyle.gap),
          itemBuilder: (context, index) {
            return _item(languageStore.list[index]);
          },
          separatorBuilder: (_, __) => const Divider(),
        ),
      );
    });
  }

  _item(lang) {
    final selected = (languageStore.chosen.value == lang["code"]);
    return TextButton(
      onPressed: () => languageStore.choose(lang["code"]!),
      child: Container(
        padding: EdgeInsetsGeometry.all(AppStyle.gap),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                lang["name"]!,
                textAlign: TextAlign.left,
                style: TextStyle(color: selected ? AppStyle.getMainColor() : null),
              ),
            ),
            Text(lang["flag"]!, style: TextStyle()),
          ],
        ),
      ),
    );
  }
}
