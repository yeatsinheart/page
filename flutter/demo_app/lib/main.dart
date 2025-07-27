import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/share/default_config.dart';

import 'package:flutter3/share/app.dart';
import 'package:flutter3/store/app_store.dart';
import 'package:flutter3/store/host_status_store.dart';

import 'package:flutter3/store/loading_store.dart';
import 'package:flutter3/store/language_store.dart';
import 'package:flutter3/store/store_init_binding.dart';

import 'package:get/get.dart';

import 'views.dart';

//Flutter 中存在三棵树，Widget[虚拟的结构]、Element 和 RenderObject。
void main() {
  runZonedGuarded(
    () {
      init();
    },
    (error, stack) {
      Log.e("Uncaught error", error: error, stackTrace: stack);
    },
    // , zoneSpecification: ZoneSpecification(
    //   print: (self, parent, zone, message) {
    //     //Log.i(message);
    //     //debugPrint(message);
    //   },
    // )
  );

  //debugPaintSizeEnabled = true; // ✅ 开启边界调试 会把所有东西，边距什么的都画线
}

init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 默认竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  StoreInitBinding().dependencies();
  // 手动初始化（注意这里已经注册过了）
  await Get.find<AppStore>().init();
  await Get.find<HostStatusStore>().init();
  await Get.find<LanguageStore>().init();

  // 网络更新配置时，这些都需要按照最新网络的数据进行更新

  // 获取基础配置 远程更新->本地缓存->初始打包配置
  DefaultConfig.init().then((config) async {
    // 配置更新后，必须先加载完成当前语言的翻译信息
    await Get.find<AppStore>().update(config);
    await Get.find<HostStatusStore>().update(config["host"]);
    await Get.find<LanguageStore>().update(config["language"]);
    runApp(App(widgetOfKey("app_layout") ?? Container()));
  });
}
