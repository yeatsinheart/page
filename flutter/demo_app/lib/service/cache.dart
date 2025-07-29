import 'dart:convert';

import 'package:flutter3/log/logger.dart';
import 'package:hive/hive.dart';

class CacheService {
  static final Map<String, Box> _map = {};

  static Future<Box> _openTable(String table) async {
    if (_map.containsKey(table)) {
      return _map[table]!;
    }
    try {
      var box = await Hive.openBox(table);
      _map[table] = box;
      return box;
    } catch (e) {
      Log.err('Failed to open Hive box $table: ', e);
      rethrow; // 或者返回一个默认值
    }
  }

  static Future<String?> get(String table, String key) async {
    Box _box = await _openTable(table);
    return _box.get(key);
  }

  static Future<void> set(String table, String key, String? str) async {
    Box _box = await _openTable(table);
    await _box.put(key, str);
  }
}
