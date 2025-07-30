import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/request/api.dart';
import 'package:flutter3/service/cache.dart';
import 'package:flutter3/store/host-status.dart';
import 'package:flutter3/store/language.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/view/app-view.dart';
import 'package:get/get.dart';

/// 获取 分发 数据
class BootstrapService {
  static const table = 'bootstrap_config';
  static const key = 'all';

  static Map<String, dynamic> data = {};

  // 将配置分发到各个store
  static _dispatch(Map<String, dynamic> config) async {
    data = config;
    await Future.wait<dynamic>([
      /// 数据和页面绑定，且一变动就要在界面展示出来的才放到store中
      //()async{AppStyle.style=config["host"]??{};}(),
      //()async{AppStyle.style=config["language"]??{};}(),
      () async {
        AppView.setViews(config["view"] ?? {});
      }(),
      () async {
        AppView.setLayout(config["layout"] ?? {});
      }(),
      () async {
        AppStyle.data = config["style"] ?? {};
      }(),
      //()async{AppStyle.style=config["app"]??{};}(),
    ]);
    AppStyle.data = config["style"];
  }

  static init() async {
    Get.put(LanguageStore());
    Get.put(HostStatusStore());
    _updateAsync();
    await _dispatch(await _get());
  }

  /// 加载配置
  static Future<Map<String, dynamic>> _get() async {
    // 尝试读取本地缓存
    final cache = await CacheService.get(table, key);
    if (cache != null) return jsonDecode(cache);

    // 加载打包内置配置
    final str = await _readBuildInConfig();
    return json.decode(str!);
  }

  /// 获取远程配置
  static _updateAsync() async {
    try {
      // 最好是Api调用
      Map<String, dynamic>? remote = await Api.init(null);
      if (remote != null) {
        CacheService.set(table, key, jsonEncode(remote));
        _dispatch(remote);
      }
    } catch (e) {
      // 忽略错误或打印日志
      Log.e("获取远程配置出错，所以取消");
    }
  }

  static Future<String?> _readBuildInConfig() async {
    if (kIsWeb) {
      //String path = 'assets/config/bootstrap.json'; 感觉会自动加 assets/ 导致加载时是assets/assets/config/bootstrap.json
      String path = 'config/bootstrap.json'; //   Web 运行时 会自动加前缀 assets/
      try {
        final result = await rootBundle.loadString(path);
        return result;
      } catch (e) {
        print('[Web] 读取 $path 失败: $e');
        return null;
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      String path = 'assets/config/bootstrap.json';
      try {
        final result = await rootBundle.loadString(path); //
        return result;
      } catch (e) {
        print('[Android}] 读取 $path 失败: $e');
        return null;
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // 考虑ios复用2进制时打包写入方式
      const channel = MethodChannel('bootstrap');
      try {
        final result = await channel.invokeMethod<String>('loadConfigJson');
        return result;
      } catch (e) {
        print('[iOS] 读取 config.json 失败: $e');
        return null;
      }
    } else {
      print('Unsupported platform');
      return null;
    }
  }
}
