import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/store/language_store.dart';
import 'package:flutter3/_theme_data.dart';
import 'package:get/get.dart';

import '../service/app_service.dart';
import '../util/context.dart';


class App extends StatelessWidget {
  final Widget child;
  const App({super.key, required this.child});
  // 空界面，方便overlay等设置
  @override
  Widget build(BuildContext context) {
    final languageStore = Get.find<LanguageStore>();
    return GetMaterialApp(
      translations: languageStore.translations,
      locale: parseLocale(languageStore.locale),

      // 默认语言
      //fallbackLocale: Locale('en', 'US'),     // 回退语言
      scrollBehavior: ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch, //移动设备的手指滑动
          PointerDeviceKind.mouse, //鼠标滚轮/拖动
          PointerDeviceKind.trackpad, //触控板
        },
      ),

      navigatorKey: GlobalContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: getThemeData(),
      builder: (context, child) {
        // 延迟设置 title（不会影响 AppBar 的 title）
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(label: AppService().get()!.name.tr, primaryColor: Theme.of(context).primaryColor.value));
        });
        return child!;
      },

      home: child,
      /// 按照路由展示界面
      // onGenerateRoute: (setting) {
      //         return getRoute(setting);
      //       },
    );
  }
}
