import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/app.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/service/bootstrap.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/store/auto-brightness.dart';
import 'package:flutter3/style/widget/browser.dart';
import 'package:flutter3/view/app/network_monitor.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'app-context.dart';
import 'view/app-view.dart';

//Flutter 中存在三棵树，Widget[虚拟的结构]、Element 和 RenderObject。
void main() {
  /*// 先保存原始回调函数引用
  final originalAddPersistentFrameCallback = SchedulerBinding.instance.addPersistentFrameCallback;

  // 重写 addPersistentFrameCallback，包装异常捕获和打印调用栈
  SchedulerBinding.instance.addPersistentFrameCallback=(FrameCallback callback) {
    FrameCallback wrappedCallback = (Duration timeStamp) {
      try {
        callback(timeStamp);
      } catch (e, stack) {
        debugPrint('🛑 SchedulerBinding frame callback error:\n$e\n$stack');
        rethrow;
      }
    };
    originalAddPersistentFrameCallback.call(wrappedCallback);
  };*/

  PlatformDispatcher.instance.onError = (error, stack) {
    Log.err('Platform Error: ${error}', error, stackTrace: stack);
    return true; // 表示已处理，防止崩溃
  };
  // 捕获 Flutter 框架错误（UI 渲染、widget 构建等）
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details); // 打印日志
    Log.err('Flutter Error: ${details.exception}', details.exception, stackTrace: details.stack);
  };
  // 捕获 Dart 层异步错误
  runZonedGuarded(
    () async {
      init();
    },
    (error, stackTrace) {
      // Dart 层全局错误处理
      Log.err('ZonedGuarded caught: $error', error, stackTrace: stackTrace);
    },
  );
}

init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true; // ✅ 开启边界调试 会把所有东西，边距什么的都画线
  // 默认竖屏 打开网页可能横屏
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  // 初始化 Hive，自动使用合适的目录（适用于 Android/iOS）
  await Hive.initFlutter();
  // （可选）注册适配器
  // Hive.registerAdapter(MyModelAdapter());
  // 网络更新配置时，这些都需要按照最新网络的数据进行更新
  BootstrapService.init().then((_) {
    // 在 Web 环境下手动清理可能挂着的回调
    if (kIsWeb) {
      WidgetsBinding.instance.platformDispatcher.onDrawFrame = null;
    }
    runApp(_main(AppView.ofKey("app_layout") ?? Container()));
  });
}

_main(child) {
  Get.put(AppStyle());
  AutoBrightness.check();
  return App(child);
}

/*builder: (context, child) {
      // 延迟设置 title（不会影响 AppBar 的 title）
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(label: AppService().get()!.name.tr, primaryColor: Theme.of(context).primaryColor.value));
      });
      return child!;
    },*/
