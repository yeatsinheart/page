import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 静态资源版本号 最好是数值递增
class ApiCache {
  static String versionKey = "api_request_version";
  static Future<void> setCache(String key, dynamic data, {String version = "0", int expire = 60 * 1000}) async {
    final prefs = await SharedPreferences.getInstance();
    if (expire == -1) {
      // 10年
      expire = 10 * 365 * 24 * 60 * 60 * 1000;
    }
    prefs.setString(
      key,
      jsonEncode({
        "${version}": {'data': data, 'expire': DateTime.now().millisecondsSinceEpoch + expire},
      }),
    );
  }

  static Future<dynamic> getCache(String key, {String version = "0"}) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;
    Map<String, dynamic> map = jsonDecode(raw);

    for (String key in map.keys) {
      // 如果 key 小于 version，则执行 {} 内代码。 等于删除过期版本
      if (key.compareTo(version) < 0) {
        map.remove(key);
      }
    }

    final data = map[version];
    final expire = data['expire'] as int;
    if (DateTime.now().millisecondsSinceEpoch > expire) {
      // 缓存过期
      return null;
    }
    return data['data'];
  }
}
