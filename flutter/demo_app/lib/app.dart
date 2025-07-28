
import 'package:flutter/material.dart';

class App {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Rex');
  static BuildContext get _context {
    final ctx = navigatorKey.currentState?.context;
    if (ctx == null) throw Exception('GlobalContext.context is null');
    return ctx;
  }

  static void go(key ,{Offset from = AnimationOfRoute.right, int time = 500, RouteSettings? settings}) {
    navigatorKey.currentState?.push(AnimationOfRoute(Container(),from: from,time: time));
  }

  static void back() {
    navigatorKey.currentState?.pop();
  }
  static double get width{
    return MediaQuery.of(_context).size.width;
  }
  static double get height{
    return MediaQuery.of(_context).size.height;
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

// RelativePositionedTransition 平移动画
// ScaleTransition 缩放动画
// SizeTransition 宽度或者高度缩放
class AnimationOfRoute extends PageRouteBuilder {
  static const Offset left = Offset(-1, 0);
  static const Offset leftTop = Offset(-1, -1);
  static const Offset leftBottom = Offset(-1, 1);

  static const Offset right = Offset(1, 0);
  static const Offset rightTop = Offset(1, -1);
  static const Offset rightBottom = Offset(1, 1);
  final Widget newPage;

  // 左上角为-1,-1 左下角为 0,0  右上角为1,-1 右为 1,0  右下角 1,1
  // 默认页面都是从右到左
  AnimationOfRoute(this.newPage, {Offset from = right, int time = 500, RouteSettings? settings})
      : super(
    settings: settings,
    transitionDuration: Duration(milliseconds: time),
    reverseTransitionDuration: Duration(milliseconds: time),
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => newPage,
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => SlideTransition(
      //使新页面从底部动画出来，它应该从 Offset(0,1) 到 Offset(0, 0) 进行动画
      //Offset (dx,dy) dx=-1:左边 dy=-1:上面 =0当前屏幕  方向和距离 1整个屏幕宽 高 系数
      position: Tween(begin: from, end: const Offset(0, 0)).animate(animation),
      child: child,
    ),
  );
}

