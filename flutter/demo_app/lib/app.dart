import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/style/theme/all-theme.dart';
import 'package:flutter3/style/widget/browser.dart';
import 'package:flutter3/view/app/network_monitor.dart';
import 'package:get/get.dart';

import 'app-context.dart';
import 'app-style.dart';

class App extends StatelessWidget {
  final Widget child;

  App(this.child);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: Obx(() {
        return MaterialApp(
          key: Get.find<AppStyle>().appKey.value,
          scrollBehavior: ScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch, //移动设备的手指滑动
              PointerDeviceKind.mouse, //鼠标滚轮/拖动
              PointerDeviceKind.trackpad, //触控板
            },
          ),
          // theme: ThemeData.light(useMaterial3: true),
          theme: getFlutterTheme(),
          navigatorKey: AppContext.navigatorKey,
          debugShowCheckedModeBanner: false,
          // 不生效了
          home: Browser(AppNetworkMonitor(child: child)),

          /// 按照路由展示界面
          // onGenerateRoute: (setting) {
          //         return getRoute(setting);
          //       },
        );
      }),
    );
  }
}
