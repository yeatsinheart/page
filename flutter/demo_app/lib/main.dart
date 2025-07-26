import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/share/app.dart';
import 'package:flutter3/share/default_config.dart';
import 'package:flutter3/share/network_monitor.dart';
import 'package:flutter3/store/host_status_store.dart';
import 'package:flutter3/store/language_store.dart';
import 'package:flutter3/_theme_data.dart';
import 'package:get/get.dart';
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

  // 获取基础配置 远程更新->本地缓存->初始打包配置
  DefaultConfig.loadConfig().then((value){});

  // 必须先加载完成当前语言的翻译信息
  await Get.putAsync(() => LanguageStore().init());
  //Get.put(LanguageStore()); // 应用启动时注入一次
  Get.put(HostStatusStore()); // 应用启动时注入一次
  // 多语言初始化
  runApp(NetworkMonitor(child: App(child: widgetOfKey("app_layout") ?? Container())));
}
