import 'package:get/get.dart';

import 'global-config.dart';
import 'host-status.dart';
import 'language.dart';

// Bindings 是 GetX 提供的 依赖注入声明方式，用于在特定页面或全局初始化时自动注入 controller/store，
class StoreInitBinding extends Bindings {
  @override
  void dependencies() {
    GlobalConfigStore appStore = Get.put(GlobalConfigStore());
    HostStatusStore hostStatusStore = Get.put(HostStatusStore()); // 优先使用缓存 获取线路
    LanguageStore languageStore = Get.put(LanguageStore());
  }
}
