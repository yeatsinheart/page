import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 整个Store 能保存进缓存中，这样重启时，缓存=store
abstract class SaveAsJsonStore<T> extends GetxService {
  final String storeKey;
  //继承类构造器 UserStore() : super('user_store');
  SaveAsJsonStore(this.storeKey);

  init() async {
    await loadFromCache();
    return this;
  }

  update(data) async {
    if(null!=data)await initFromJson(data);
  }

  @override
  void onInit() async{
    super.onInit();
    await loadFromCache();
  }

  /// 初始化时自动从缓存加载
  Future<void> loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(storeKey);
    if (jsonStr != null) {
      final json = jsonDecode(jsonStr);
      await initFromJson(json);
    }
  }

  // 继承类实现封装   @override
  //   void fromJson(json) {
  //     _user.value = json处理 List<dynamic> Map<String,dynamic>;
  //   }
  Future initFromJson(json) ;

  // 继承类实现封装什么数据 @override dynamic toJson() {return value?.toJson() ?? {};}
  toJson();

  /// 保存到缓存
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storeKey, jsonEncode(toJson()));
  }
}
