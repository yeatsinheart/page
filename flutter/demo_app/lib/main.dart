import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter3/store/language_store.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'service/app_service.dart';
import 'service/network_service.dart';
import 'util/context.dart';

import 'views.dart';

void main() async {
  // 默认输屏
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
  //Flutter 中存在三棵树，Widget[虚拟的结构]、Element 和 RenderObject。
  WidgetsFlutterBinding.ensureInitialized();
  //debugPaintSizeEnabled = true; // ✅ 开启边界调试 会把所有东西，边距什么的都画线
  // 多语言初始化
  await Get.putAsync(() => LanguageStore().init());
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

// 空界面，方便overlay等设置
  @override
  Widget build(BuildContext context) {
    final languageStore = Get.find<LanguageStore>();
      // 多语言
    return GetMaterialApp(
      translations: languageStore.translations,
      locale: parseLocale("en_US"),             // 默认语言
      //fallbackLocale: Locale('en', 'US'),     // 回退语言

      scrollBehavior: ScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      navigatorKey: GlobalContext.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: AppService().get()!.name.tr,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // 全局页面背景色
        // 点击时的高亮效果设置为透明 长按时的扩散效果设置为透明 以上两者去除按钮点击水波纹
        splashFactory: NoSplash.splashFactory,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        //,background: Colors.grey
        //colorScheme: ColorScheme.fromSeed(seedColor: colorFromHex(AppService().get()!.color)),
        useMaterial3: true,
      ),
      onGenerateRoute: (setting) {
        return getRoute(setting);
      },
    );
  }
}
