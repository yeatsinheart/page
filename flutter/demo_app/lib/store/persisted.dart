
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersistentService<T> extends GetxService {
  late SharedPreferences prefs;
  final Map<String, RxString> persistedStrings = {};

  final String key;
  PersistentService(this.key);

  Future<void> init(List<String> keys) async {
    prefs = await SharedPreferences.getInstance();
    for (final key in keys) {
      final rx = (prefs.getString(key) ?? '').obs;
      persistedStrings[key] = rx;
      // 监听变化 并 实时写入缓存
      ever(rx, (val) => prefs.setString(key, val));
    }
    await load();
  }
    /// RxString get token => use('token');
  RxString use(String key) => persistedStrings[key]!;


  // Future<void> save(T data);
  Future<void> save(T data) async {
    await prefs.setString(key, jsonEncode(stringify(data)));
  }
  // Future<void> load();
  Future<void> load() async {
    final json = prefs.getString(key);
    if (json != null) {
      return jsonDecode(json);
    }
  }


  static String stringify(dynamic obj) {
    if(null==obj)return '';
    return jsonEncode(
      obj,
      toEncodable: (nonEncodable) {
        // 尝试使用 toJson
        // try {
        //   return nonEncodable?.toJson();
        // } catch (_) {}
        // fallback 用 toString
        return nonEncodable.toString();
      },
    );
  }


  /*

  * */
}