import 'package:flutter/material.dart';

import '../views.dart';

class GlobalContext {
  // 如果你的路由结构使用了 nested Navigator 或 shell（如 go_router 的 ShellRoute），则 GlobalKey<NavigatorState> 控制的并非是嵌套路由中的 Navigator，需要使用局部 navigatorKey。
  GlobalContext._internal();
  factory GlobalContext() => _instance;
  static final GlobalContext _instance = GlobalContext._internal();
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Rex');

  static BuildContext get context {
    final ctx = navigatorKey.currentState?.context;
    if (ctx == null) throw Exception('GlobalContext.context is null');
    return ctx;
  }
  static OverlayState? get overlay => navigatorKey.currentState!.overlay;

  // 整个组件碰上物理返回时，是否返回 WillPopScope(onWillPop: 判断方法,child: 组件,),
  /// 获取路由携带的参数
  static Object? routeArgs() {
    return ModalRoute.of(context)!.settings.arguments;
  }

  static void redirect(name, args) {
    navigatorKey.currentState?.pushNamed(name, arguments: args);
  }


  static void loadRoute(name, args) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(name, (route) => true, arguments: args);
  }

  static void loadWidget(Route widget) {
    navigatorKey.currentState?.pushAndRemoveUntil(widget, (route) => true);
  }

  static void open(Route route) {
    navigatorKey.currentState?.push(route);
  }

  static void load(String key) {
    // push(route) 表示 “压入一个新页面” 到栈顶。原有页面仍保留在栈中，用户可以返回。
    // pushAndRemoveUntil(route, predicate) 移除部分或全部页面，只保留满足条件的页面 登录后清除登录页、重置栈 (route) => false, // false 表示移除所有旧页面
    //   ModalRoute.withName('/home'), // 保留名为 /home 的页面
    navigatorKey.currentState?.push(asRoute(key));
  }
  static void pop() {
    navigatorKey.currentState?.pop();
  }

  static Color color() {
    return Theme.of(context).colorScheme.primary;
  }

  static ColorScheme colorScheme() {
    return Theme.of(context).colorScheme;
  }

  static double getWidth() {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight() {
    return MediaQuery.of(context).size.height;
  }

  static double getRem(double num) {
    // 7.5rem=100%;
    return num * getWidth() / (750/100);
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
}
