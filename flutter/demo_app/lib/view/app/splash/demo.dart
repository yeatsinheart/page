import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter3/app.dart';
import 'package:flutter3/service/app_service.dart';
import 'package:flutter3/share/img.dart';
import 'package:flutter3/share/context.dart';

class AppSplashDemo extends StatefulWidget {

  final dynamic params;
  const AppSplashDemo({this.params,super.key});

  @override
  _AppSplashDemoState createState() => _AppSplashDemoState();
}

class _AppSplashDemoState extends State<AppSplashDemo> {
  late Timer _timer;
  int count = 1;
  bool initialed = false;

  void nextPage() {
    _timer.cancel();
    GlobalContext.load("app_layout", params: {"test": "test"});
  }

  getTip() {
    if (count > 0) return "$count 跳过";
    return "跳过";
  }

  @override
  void initState() {
    super.initState();
    // 倒计时
    startInitial();
  }

  @override
  Widget build(BuildContext context) {
    //展示广告
    //alignment: Alignment(1.0, -1.0), // 右上角对齐
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            AppImg(AppService().get()!.splash,width: App.width,height:App.height * 7 / 8),
            Expanded(
              child: Container(
                width: App.width,
                color: AppService().skin()?.container,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, //垂直方向居中对齐
                  children: <Widget>[
                    AppImg(AppService().get()!.logo,width: 32,height: 32),
                    Text(
                      AppService().get()!.name,
                      style: TextStyle(color: AppService().skin()?.font, fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          right: 15,
          top: 32,
          child: MaterialButton(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text(
              getTip(),
              style: TextStyle(color: Colors.white70, fontSize: 15.0),
            ),
            onPressed: () {
              if (count <= 0) {
                // 倒计时结束 同时没有别的问题。。。
                nextPage();
                //if (initialed) {} else {ErrOverlay.notify();}
              }
            },
          ),
        ),
      ],
    ));
  }

  void startInitial() async {
    //设置启动图生效时间
    var _duration = new Duration(seconds: 1);
    _timer = Timer.periodic(_duration, (v) {
      count--;
      if (count <= -1 && initialed) {
        _timer.cancel();
        nextPage();
      } else {
        setState(() {});
      }
    });

    // 异步初始化流程
    //initialed = await AppService().open();
  }
}

//http://laomengit.com/guide/animation/NavigatorAnimation.html 转场动画
class LeftToRightPageRoute extends PageRouteBuilder {
  final Widget newPage;

  LeftToRightPageRoute(this.newPage)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              newPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(animation),
            child: child,
          ),
        );
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget currentPage;
  final Widget newPage;

  CustomPageRoute(this.currentPage, this.newPage)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              currentPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0, 0),
                  end: const Offset(0, -1),
                ).animate(animation),
                child: currentPage,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset(0, 0),
                ).animate(animation),
                child: newPage,
              )
            ],
          ),
        );
}
