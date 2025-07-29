import 'package:flutter/material.dart';
import 'package:flutter3/app-route.dart';

to(widget, args) {
  AppRoute.open(
    PageRouteBuilder(
      opaque: false,
      fullscreenDialog: true,
      settings: RouteSettings(arguments: args),
      transitionDuration: const Duration(milliseconds: 500), //动画时间为500毫秒
      pageBuilder: (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
        /// 各种效果模式 https://juejin.cn/post/6844903890291261447
        return SizeTransition(
          axisAlignment: -1,
          sizeFactor: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeInSine)),
          // return ScaleTransition(
          //   scale: Tween(begin: 0.5, end: 1.0).animate(
          //       CurvedAnimation(
          //       parent: animation, curve: Curves.easeInExpo)),

          child: widget,
        );
      },
    ),
    // MaterialPageRoute(
    //     builder: (context) {
    //       return HeroDetailPage();
    //     },
    //     fullscreenDialog: true,
    //     settings: RouteSettings(arguments: game)),
  );
}
