import 'package:flutter/material.dart';
import 'package:flutter3/util/context.dart';
import 'package:flutter3/util/overlay.dart';
import 'package:get/get.dart';

import '../../store/language_store.dart';

class AppLanguage extends StatelessWidget {
  const AppLanguage({super.key});

  void switchLanguage(String code) {
    /*Locale current = Get.locale ?? Locale('en', 'US');
    if (current.languageCode == 'en') {
      Get.updateLocale(Locale('zh', 'CN'));
    } else {
      Get.updateLocale(Locale('en', 'US'));
    }*/
    Get.find<LanguageStore>().loadLanguage(code);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 全屏遮罩
        Positioned.fill(
          child: IgnorePointer(child: Container(color: Colors.black.withOpacity(0.5))),
        ),
        Center(
          child: SizedBox(
            width: GlobalContext.getWidth() * 0.8,
            height: GlobalContext.getHeight() * 0.8,
            child: Column(
              children: [
                Expanded(
                  child: Container(
            width:double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(GlobalContext.getRem(.2)), // 设置圆角半径
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(onPressed: () => switchLanguage("zh_CN"), child: Text('简体中文')),
                        const SizedBox(height: 20),
                        ElevatedButton(onPressed: () => switchLanguage("en_US"), child: Text('English')),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    icon: Icon(Icons.close, size: 32, color: Colors.white),
                    onPressed: () {
                      // 执行关闭逻辑，例如：OverlayEntry?.remove()
                      GlobalOverlayContext.removeByWidgetSelf(key.toString());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
