import 'package:flutter/material.dart';
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

class AppView {
  static Widget? ofKey(String? key, {params}) {
    if (key == null) {
      Log.e('getWidget: key is null');
      return null;
    }
    return ofPath(ViewKeyPathMap[key], params: params);
  }

  static Widget? ofPath(String? path, {key, params}) {
    if (path == null) {
      Log.e('getWidgetByPath: path 路径为空 null');
      return null;
    }
    final widget =
        widgetOfPath(path, key: key, params: params) ??
        widgetOfPath('$path/index', key: key, params: params);
    if (widget == null) {
      Log.e('getWidgetByPath: widget 找不到 path $path');
    }
    return widget;
  }
}
