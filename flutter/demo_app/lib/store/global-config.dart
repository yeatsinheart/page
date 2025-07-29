import 'package:flutter3/store/cache_as_json.dart';
import 'package:get/get.dart';

class GlobalConfigStore extends CacheAsJson<GlobalConfigStore> {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  GlobalConfigStore._internal() : super('global-config-store');
  static final GlobalConfigStore _instance = GlobalConfigStore._internal();

  factory GlobalConfigStore() => _instance;

  final Rxn<Map<String, dynamic>?> data = Rxn<Map<String, dynamic>?>();

  @override
  updateByJson(json) async {
    data.value = json;
    data.refresh();
    await save(); // 保存到缓存中
  }

  @override
  toJson() {
    return data.value;
  }

  @override
  load_from_api() async {}
}
