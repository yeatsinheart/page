import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter3/log/logger.dart';
import 'package:flutter3/service/language.dart';
import 'package:flutter3/share/default_config.dart';

import 'package:flutter3/share/app.dart';
import 'package:flutter3/store/global-config.dart';
import 'package:flutter3/store/host-status.dart';

import 'package:flutter3/store/language.dart';
import 'package:flutter3/store/store_init_binding.dart';

import 'package:get/get.dart';

import 'views.dart';

//Flutter 中存在三棵树，Widget[虚拟的结构]、Element 和 RenderObject。
void main() {
  PlatformDispatcher.instance.onError = (error, stack) {
    Log.err('Platform Error: ${error}',error,stackTrace: stack);
    return true; // 表示已处理，防止崩溃
  };
  // 捕获 Flutter 框架错误（UI 渲染、widget 构建等）
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details); // 打印日志
    Log.err('Flutter Error: ${details.exception}',details.exception,stackTrace: details.stack);
  };
  // 捕获 Dart 层异步错误
  runZonedGuarded(() async {
    init();
  }, (error, stackTrace) {
    // Dart 层全局错误处理
    Log.err('ZonedGuarded caught: $error', error,stackTrace: stackTrace);
  });
}

init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugPaintSizeEnabled = true; // ✅ 开启边界调试 会把所有东西，边距什么的都画线
  // 默认竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 手动初始化 初始化成功后 才注册到Getx中
  // 调用多次 Get.putAsync<GlobalConfigStore>，实际上最新的实例会覆盖旧的，GetX 只会保存一个。
  await Future.wait([
   Get.putAsync(() => GlobalConfigStore().init()),
   Get.putAsync(() => HostStatusStore().init()),
  ]);

  // 网络更新配置时，这些都需要按照最新网络的数据进行更新

  // 获取基础配置 远程更新->本地缓存->初始打包配置
  DefaultConfig.loadConfig().then((config) async {
    // 配置更新后，必须先加载完成当前语言的翻译信息
    await Get.find<GlobalConfigStore>().updateByJson(config);
    await Get.find<HostStatusStore>().updateByJson(config["host"]);
    await Future.wait<dynamic>([

      LanguageService().updateByJson(config["language"]),
    ]);
    runApp(App(widgetOfKey("app_layout") ?? Container()));
  });
}
