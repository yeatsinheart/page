import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/service/bootstrap-service.dart';
import 'package:flutter3/style/browser.dart';
import 'package:flutter3/view/app/network_monitor.dart';

import 'app-context.dart';
import 'view/app-view.dart';

//Flutter 中存在三棵树，Widget[虚拟的结构]、Element 和 RenderObject。
void main() {
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
  // 默认竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // 网络更新配置时，这些都需要按照最新网络的数据进行更新
  BootstrapService.init().then((_) {
    runApp(_main(AppView.ofKey("app_layout") ?? Container()));
  });
}

_main(child) {
  return MaterialApp(
    scrollBehavior: ScrollBehavior().copyWith(
      dragDevices: {
        PointerDeviceKind.touch, //移动设备的手指滑动
        PointerDeviceKind.mouse, //鼠标滚轮/拖动
        PointerDeviceKind.trackpad, //触控板
      },
    ),
    navigatorKey: AppContext.navigatorKey,
    debugShowCheckedModeBanner: false,
    home: Browser(NetworkMonitor(child: child)),

    /// 按照路由展示界面
    // onGenerateRoute: (setting) {
    //         return getRoute(setting);
    //       },
  );
}

/*builder: (context, child) {
      // 延迟设置 title（不会影响 AppBar 的 title）
      WidgetsBinding.instance.addPostFrameCallback((_) {
        SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(label: AppService().get()!.name.tr, primaryColor: Theme.of(context).primaryColor.value));
      });
      return child!;
    },*/
