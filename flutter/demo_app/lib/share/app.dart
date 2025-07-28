import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/_theme_data.dart';

import 'package:flutter3/color-container/browser.dart';

import 'package:get/get.dart';

import 'package:flutter3/service/app_service.dart';
import 'package:flutter3/share/context.dart';

import 'network_monitor.dart';

/// 配置获取：运营中最新的配置=>没网或者失败=>本地缓存配置=>没有=>打包时候的配置
class App extends StatelessWidget {
  final Widget child;

  const App(this.child, {super.key, required});

  // 空界面，方便overlay等设置
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch, //移动设备的手指滑动
          PointerDeviceKind.mouse, //鼠标滚轮/拖动
          PointerDeviceKind.trackpad, //触控板
        },
      ),

      navigatorKey: GlobalContext.navigatorKey,
      theme: getThemeData(context),
      debugShowCheckedModeBanner: false,

      builder: (context, child) {
        // 延迟设置 title（不会影响 AppBar 的 title）
        WidgetsBinding.instance.addPostFrameCallback((_) {
          SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(label: AppService().get()!.name.tr, primaryColor: Theme.of(context).primaryColor.value));
        });
        return child!;
      },

      home: Browser(NetworkMonitor(child: child)),

      /// 按照路由展示界面
      // onGenerateRoute: (setting) {
      //         return getRoute(setting);
      //       },
    );
  }
}
