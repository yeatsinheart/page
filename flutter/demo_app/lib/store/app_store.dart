import 'package:get/get.dart';

class AppStore extends GetxService {
  final Rx<Map<String, dynamic>?> data = Rx<Map<String, dynamic>?>(null);


  Future<AppStore> init(Map<String, dynamic> json) async {
    setFromJson(json);
    return this;
  }

  void setFromJson(Map<String, dynamic> json) {
    data.value = json;
    data.refresh();
        //.update((_)=>data) 是用于 RxMap（即 Rx<Map>）的；
  }

  // 可以写异步初始化、网络请求等
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

