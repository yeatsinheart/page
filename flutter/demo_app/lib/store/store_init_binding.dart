
import 'app_store.dart';
import 'host_status_store.dart';
import 'language_store.dart';

import 'package:get/get.dart';
// Bindings 是 GetX 提供的 依赖注入声明方式，用于在特定页面或全局初始化时自动注入 controller/store，
class StoreInitBinding extends Bindings {
  @override
  void dependencies() {
    //AppStore appStore =await Get.putAsync(() => AppStore().init());
    AppStore appStore = Get.put(AppStore());
    appStore.init();

    // 缓存线路测速
    //HostStatusStore hostStatusStore = await Get.putAsync(()=>HostStatusStore().init());// 优先使用缓存 获取线路
    HostStatusStore hostStatusStore = Get.put(HostStatusStore()); // 优先使用缓存 获取线路
    hostStatusStore.init(); // 因为会使用网络，会获取HostStatusStore,线路测速,可能就异常报错了,或者没有init，导致GetX没有这个Store

    // 缓存语言更新
    //LanguageStore languageStore =await Get.putAsync(() => LanguageStore().init());
    LanguageStore languageStore = Get.put(LanguageStore());
    languageStore.init(); // 因为会使用网络，会获取HostStatusStore，翻译更新，可能就异常报错了,或者没有init，导致GetX没有这个Store

  }
}
