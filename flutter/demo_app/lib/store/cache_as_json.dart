import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 整个Store 能保存进缓存中，这样重启时，缓存=store
abstract class CacheAsJson<S> extends GetxService {

  final String storeKey;

  //继承类构造器 UserStore() : super('user_store');
  CacheAsJson(this.storeKey);


  Future<S> init() async {
    await recoverFromCache();
    return this as S;
  }

  /// 初始化时自动从缓存加载
  Future<void> recoverFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(storeKey);
    // 缓存命中
    if (null != jsonStr) {await updateByJson(jsonDecode(jsonStr));}
    // 缓存中不存在数据 从接口请求数据
    load_from_api();
  }

  Future updateByJson(json);

  toJson();
  load_from_api();

  /// 保存到缓存
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storeKey, jsonEncode(toJson()));
  }
}
