import 'package:flutter/material.dart';
import 'package:flutter3/widget_of_path_info.dart';

// 顶层变量，Map<String, String>
final Map<String, String> ViewKeyPathMap = {
  "splash": "/app/splash/demo",
  "app_layout": "/layout/demo",

  "app_layout": "/ademo/main", // 先只跑演示

  "language": "/app/language",
  "home": "/app/home/wg",
  "swiper": "/market/swiper/demo",
  "marquee": "/market/marquee/demo",

  "game_home": "/game/home/top_category_demo",
  "game_search": "/game/search/demo",

  "discover": "/wechat/discover",
  "me": "/page/me/demo",
  "contact": "/wechat/contact",
};

dynamic widgetOfKey(String? key) {
  if (key == null) {
    debugPrint('getWidget: key is null');
    return null;
  }
  return getWidgetByPath(ViewKeyPathMap[key]);
}

Widget? getWidgetByPath(String? path, {key, params}) {
  if (path == null) {
    debugPrint('getWidgetByPath: path 路径为空 null');
    return null;
  }
  final widget = widgetOfPath(path, key: key, params: params) ?? widgetOfPath('$path/index', key: key, params: params);
  if (widget == null) {
    debugPrint('getWidgetByPath: widget 找不到 path $path');
  }
  return widget;
}

PageRoute asRoute(String key,{RouteSettings? settings}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (cxt, ani1, ani2) {
      return FadeTransition(opacity: ani1, child: widgetOfKey(key) ?? Container());
    },
  );
}

PageRoute getRoute(RouteSettings settings) {
  String routeName = settings.name!;
  // 自定义：PageRouteBuilder，可以自定义动画效果
  // Flutter 提供了两个转场动画，分别为 MaterialPageRoute 和 CupertinoPageRoute，
  // MaterialPageRoute 根据不同的平台显示不同的效果，Android效果为从下到上，iOS效果为从左到右。
  // CupertinoPageRoute 不分平台，都是从左到右。
  /// 全局路由管理，应用内，所有路由跳转都会经过这里
  /// 可以考虑把 方向，时间 物理返回键 都封装进来
  /// 动画效果：：
  /// 操作系统物理返回操作，是否返回 WillPopScope(onWillPop: 判断方法,child: 组件,),
  /// 手势操作也可以，GestureDetector(onPanUpdate: (details) {if (details.delta.dx < -10) {Navigator.pop(context);}},
  //           child: SizedBox(height: double.infinity,width: double.infinity,
  //              child: 页面组件
  //           ),
  //         ),
  // 传给Navigator一个PageRouter。我这边使用的是PageRouterBuilder组件，它有个opaque和barrierColor属性，前者是控制是否不透明，默认是true，而barrierColor控制新页面底部的颜色。如果我们仅设置barrierColor的颜色，肯定是不生效的，因为opaque告诉导航新页面的底部不透明，哪怕背景色设置为透明也是黑色，需要手动设置opaque为false，这样才可以透过半透明（或透明）的背景色看到上一个页面的UI。
  //
  // state:参数  Opacity (opacity:,child) 透明度可变 可用NotificationListener(onNotification(notify){if(notify is ScrollUpdateNotification && notify.depth==0){}})
  if (routeName == '/launch') {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (cxt, ani1, ani2) {
        return FadeTransition(opacity: ani1, child: widgetOfKey("splash") ?? Container());
      },
    );
  } else if (routeName == '/') {
    return AnimationPageRoute(widgetOfKey("app_layout") ?? Container(), settings: settings);
  } else {
    // 默认应用根节点 内容为空
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return Container();
      },
      maintainState: false,
    );
  }
}

// RelativePositionedTransition 平移动画
// ScaleTransition 缩放动画
// SizeTransition 宽度或者高度缩放
class AnimationPageRoute extends PageRouteBuilder {
  static const Offset left = Offset(-1, 0);
  static const Offset leftTop = Offset(-1, -1);
  static const Offset leftBottom = Offset(-1, 1);

  static const Offset right = Offset(1, 0);
  static const Offset rightTop = Offset(1, -1);
  static const Offset rightBottom = Offset(1, 1);
  final Widget newPage;

  // 左上角为-1,-1 左下角为 0,0  右上角为1,-1 右为 1,0  右下角 1,1
  // 默认页面都是从右到左
  AnimationPageRoute(this.newPage, {Offset from = right, int time = 500, RouteSettings? settings})
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
