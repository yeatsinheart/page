import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/log/logger.dart' show Log;
import 'package:flutter3/widget_of_path_info.dart';

// 顶层变量，Map<String, String>
final Map<String, String> ViewKeyPathMap = {
  "splash": "/app/splash/demo",
  "app_layout": "/layout/demo",

  //"app_layout": "/demo/main", // 先只跑演示

  "language": "/app/language",

  "home": "/app/home/wg",

  "swiper": "/market/swiper/demo",
  "marquee": "/market/marquee/demo",

  "game_home": "/game/home/top_category_demo",
  "game_search": "/game/search/demo",

};
class AppView{
  static slideTo(String? key, {params, Offset from = SlideRoute.right, int time = 300}){
    AppContext.navigatorKey.currentState?.push(SlideRoute(byKey(key,params: params), from: from, time: time));
  }

  static void back() {
    AppContext.navigatorKey.currentState?.pop();
  }

  static byKey(String? key, { params}){if (key == null) {
    Log.e('getWidget: key is null');
    return null;
  }
    return byPath(ViewKeyPathMap[key],params: params);
  }

  static Widget? byPath(String? path, {key, params}) {
    if (path == null) {
      Log.e('getWidgetByPath: path 路径为空 null');
      return null;
    }
    final widget = widgetOfPath(path, key: key, params: params) ?? widgetOfPath('$path/index', key: key, params: params);
    if (widget == null) {
      Log.e('getWidgetByPath: widget 找不到 path $path');
    }
    return widget;
  }
}

dynamic widgetOfKey(String? key, { params}) {
  if (key == null) {
    Log.e('getWidget: key is null');
    return null;
  }
  return getWidgetByPath(ViewKeyPathMap[key],params: params);
}

Widget? getWidgetByPath(String? path, {key, params}) {
  if (path == null) {
    Log.e('getWidgetByPath: path 路径为空 null');
    return null;
  }
  final widget = widgetOfPath(path, key: key, params: params) ?? widgetOfPath('$path/index', key: key, params: params);
  if (widget == null) {
    Log.e('getWidgetByPath: widget 找不到 path $path');
  }
  return widget;
}

PageRoute asRoute(String key,{params,RouteSettings? settings}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (cxt, ani1, ani2) {
      return FadeTransition(opacity: ani1, child: widgetOfKey(key,params: params) ?? Container());
    },
  );
}
