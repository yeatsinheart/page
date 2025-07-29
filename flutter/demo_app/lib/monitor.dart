import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';
import 'package:flutter3/view/app-view.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'service/network_service.dart';
import 'share/context.dart';
// 测试网络状态，有网状态才能启动

// WidgetsBinding.instance.addPostFrameCallback((_) async {
// // 初始化启动时必须要有网
// NetworkService.check();
// GlobalContext.loadWidget(PageRouteBuilder(pageBuilder: (cxt, ani1, ani2) {
// return FadeTransition(opacity: ani1, child: AppRoute.splash());
// }));
// //_test_network_until_good();
// });
_test_network_until_good() {
  Future.delayed(Duration(milliseconds: 1000), () async {
    // 监听
    if (await NetworkService.check()) {
      AppRoute.slideToKey("splash");
    } else {
      _test_network_until_good();
    }
  });
}
