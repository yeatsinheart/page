import 'package:flutter3/log/logger.dart';
import 'package:hive/hive.dart';

class CacheService {
  static final Map<String, Box> _map = {};
  static final version=0;
  static String version_control(String table){
    return "${table}_${version}";
  }
  static Future<Box> _openTable(String table) async {
    String tableName = version_control(table);
    if (_map.containsKey(tableName)) {
      return _map[tableName]!;
    }
    try {
      var box = await Hive.openBox(tableName);
      _map[tableName] = box;
      return box;
    } catch (e) {
      Log.err('Failed to open Hive box $tableName: ', e);
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
