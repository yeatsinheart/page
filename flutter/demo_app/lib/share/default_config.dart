import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter3/request/http_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

class DefaultConfig {
  static const _cacheKey = 'cached_default_config';

  /// 加载配置
  static Future<Map<String, dynamic>> loadConfig() async {
    // 1. 尝试拉取网络配置
    try {
      Map<String, dynamic> remote = await _loadRemote();
      if (remote != null) {
        await _saveCache(remote);
        return remote;
      }
    } catch (e) {
      // 忽略错误或打印日志
    }

    // 2. 尝试读取本地缓存
    final cache = await _loadCache();
    if (cache != null) return cache;

    // 3. 加载打包内置配置
    final asset = await _loadBuildIn();
    return asset;
  }

  /// 获取远程配置
  static Future<Map<String, dynamic>> _loadRemote() async {
    final response = await HttpRequestUtil.get('https://your-config-url.com/config.json');
    return response.data;
  }

  /// 保存缓存
  static Future<void> _saveCache(Map<String, dynamic> config) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_cacheKey, json.encode(config));
  }

  /// 读取本地缓存
  static Future<Map<String, dynamic>?> _loadCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_cacheKey);
    if (jsonStr == null) return null;
    return json.decode(jsonStr);
  }

  /// 读取内置配置 统一读取流程（安卓/iOS 通用）
  static Future<Map<String, dynamic>> _loadBuildIn() async {
    final str = await _readBuildInConfig();
    return json.decode(str!);
  }

  static Future<String?> _readBuildInConfig() async {
    if (kIsWeb || defaultTargetPlatform==TargetPlatform.android) {
      String path = 'assets/config/default_config.json';
      try {
        final result = await rootBundle.loadString(path);
        return result;
      } catch (e) {
        print('[${kIsWeb?'Web':'Android'}] 读取 $path 失败: $e');
        return null;
      }
    }else if (defaultTargetPlatform==TargetPlatform.iOS) {
      const channel = MethodChannel('default_config');
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
