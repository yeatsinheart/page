import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/demo/main.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/style/theme/all-theme.dart';
import 'package:flutter3/style/widget/browser.dart';
import 'package:flutter3/view/app/network_monitor.dart';
import 'package:flutter3/app-style.dart';
import 'package:get/get.dart';
import 'app-context.dart';

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
          // 一直 pop 到最后一页：如果这是用 home 设置的首页 → 继续 pop 会直接退出应用 如果是用 onGenerateRoute 生成 / 路径页面 → 效果一样，最后退出应用

          /// 按照路由展示界面
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name.toString().toLowerCase()) {
              case '/':/// 等同于配置home属性
                return MaterialPageRoute(builder: (context) => _to_route(Browser(AppNetworkMonitor(child: child))));
              case '/test':
                return MaterialPageRoute(builder: (context) => _to_route(Browser(MainDemo())));
              case '/details':
                final args = settings.arguments as String?; // 取传过来的参数
                return MaterialPageRoute(builder: (context) => _to_route(Container()));
              default:
              // 未匹配的路由
                return MaterialPageRoute(builder: (context) => _to_route(Container()));
            }
          },
        );
      }),
    );
  }
  _to_route(child){
    return Material(type: MaterialType.transparency, child: child);
  }
/*
           ┌──────────────────────────┐
           │  启动 MaterialApp         │
           └──────────────┬───────────┘
                          │
                          ▼
         是否设置了 initialRoute ?
         ┌───────────────┬───────────────┐
         │ YES            │ NO            │
         ▼                ▼
 routes 里有这个路由?   使用 home 作为 "/"
 ┌───────────────┐
 │ YES            │
 ▼                │
直接返回对应页面   │
                   ▼
         onGenerateRoute(settings)
         ┌───────────────┬───────────────┐
         │ 返回了 Route? │ NULL           │
         ▼               ▼
    使用该 Route   onUnknownRoute(settings)
                        │
                        ▼
                返回 404 页面或报错

* */

}
