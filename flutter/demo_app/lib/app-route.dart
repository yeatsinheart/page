import 'package:flutter/material.dart';
import 'package:flutter3/share/overlay.dart';
import 'package:flutter3/store/app.dart';
import 'package:flutter3/style/format/container.dart';
import 'package:flutter3/style/theme/all-theme.dart';
import 'package:flutter3/style/widget/browser.dart';
import 'package:flutter3/view/account/auth/demo/index.dart';
import 'package:flutter3/view/app-view.dart';

import 'app-context.dart';

class AppRoute {
  static OverlayState? get overlay => AppContext.navigatorKey.currentState!.overlay;

  static to(String? key, {params}) {
    var info = {
      "language":{ "popBy": "/pop/close_bottom"},
      "auth":{ "popBy": "/pop/close_bottom"}
    };
    if (null != info[key] && null != info[key]!["popBy"]) {
      GlobalOverlayContext.popBy(info[key]!["popBy"]!, key!,params: params);
    }else{
      slideToKey(key,params: params);
    }
  }

  /// 各种效果模式 https://juejin.cn/post/6844903890291261447
  static slideToKey(String? key, {params, Offset from = SlideRoute.right, int time = 300}) {
    open(
      SlideRoute(
        Browser(AppView.ofKey(key, params: params)),
        from: from,
        time: time,
      ),
    );
  }

  static slideToPath(String? path, {params, Offset from = SlideRoute.right, int time = 300}) {
    open(
      SlideRoute(
        Browser(AppView.ofPath(path, params: params)),
        from: from,
        time: time,
      ),
    );
  }

  static open(PageRouteBuilder route) {
    AppContext.navigatorKey.currentState?.push(route);
  }

  static void back() {
    AppContext.navigatorKey.currentState?.pop();
  }

  /// 获取路由携带的参数
  static Object? routeArgs() {
    return ModalRoute.of(AppContext.context)!.settings.arguments;
  }

  static dialog() {
    showDialog(
      context: AppContext.context,
      builder: (context) {
        // 直接挂载在 MaterialApp 下 所以样式哪些 要不要自己封装个Theme：data
        // Browser 下面有个 page 导致背景不透明了。但是又要broser 宽度限制效果，又不需要page限制。
        // return Browser( );
        var page = ContainerFormat("mask", Dialog(child: AccountAuthDemoIndex()));
        return Theme(
          data: getFlutterTheme(),
          child: AppStore.maxWidth == null
              ? page
              : Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: AppStore.maxWidth!),
                    child: page,
                  ),
                ),
        );
      },
    );
  }
}

/**
    Navigator.pop(context,[result]) 方法参数中的可选参数 result 就是页面回退时携带的参数，Navigator.push 会返回一个 Future 在 then 语句中处理页面回退的结果，具体使用参考如下：
    // 从Navigator中移除当前所在路由再跳转到新的路由，相当于finish再startActivity
    Navigator.popAndPushNamed
    // 根据指定的Route直接返回，在此之前的路由会被清除
    Navigator.popUntil
    // 跳转到新的Route，并将指定Route之前的的Route清空，pushNamedAndRemoveUntil与之类似
    Navigator.pushAndRemoveUntil
    // 页面替换，pushReplacementNamed与之类似
    Navigator.pushReplacement

 * */
//✅ 常见的路由动画效果（基于 Flutter 内置 Transition Widget）
// 以下是 Flutter 路由切换中最常用的动画类型和对应的 Widget：
// 动画类型	动画 Widget	说明
// 滑动	SlideTransition	页面从某个方向滑入/滑出
// 渐隐（淡入）	FadeTransition	页面透明度逐渐变化
// 缩放	ScaleTransition	页面从小变大 缩放动画（或相反）
// 旋转	RotationTransition	页面旋转进入
// 组合动画	FadeTransition + SlideTransition	常见在登录页/弹窗
// RelativePositionedTransition 平移动画
// SizeTransition 宽度或者高度缩放

class SlideRoute extends PageRouteBuilder {
  static const Offset left = Offset(-1, 0);
  static const Offset leftTop = Offset(-1, -1);
  static const Offset leftBottom = Offset(-1, 1);

  static const Offset right = Offset(1, 0);
  static const Offset rightTop = Offset(1, -1);
  static const Offset rightBottom = Offset(1, 1);
  final Widget? newPage;

  // 左上角为-1,-1 左下角为 0,0  右上角为1,-1 右为 1,0  右下角 1,1
  // 默认页面都是从右到左
  SlideRoute(this.newPage, {Offset from = right, int time = 500, RouteSettings? settings})
    : super(
        settings: settings,
        transitionDuration: Duration(milliseconds: time),
        reverseTransitionDuration: Duration(milliseconds: time),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => newPage ?? Container(),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => SlideTransition(
          //使新页面从底部动画出来，它应该从 Offset(0,1) 到 Offset(0, 0) 进行动画
          //Offset (dx,dy) dx=-1:左边 dy=-1:上面 =0当前屏幕  方向和距离 1整个屏幕宽 高 系数
          position: Tween(begin: from, end: const Offset(0, 0)).animate(animation),
          child: child,
        ),
        //SizeTransition(axisAlignment: -1,sizeFactor: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeInSine)),child: widget,
      );
}
