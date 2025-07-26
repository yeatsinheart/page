import 'package:flutter3/store/host_status_store.dart';
import 'package:get/get.dart';

class AppStore extends GetxService {
  final Rx<AppStoreData?> data = Rx<AppStoreData?>(null);


  Future<AppStore> init() async {
    return this;
  }

  void setFromJson(Map<String, dynamic> json) {
    data.value = AppStoreData.fromJson(json);
    data.refresh();
    data.update((_)=>AppStoreData.fromJson(json));
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

class AppStoreData {
  String name;
  Map<String, String> views;

  AppStoreData({this.views = const {}, this.name = ""});

  factory AppStoreData.fromJson(Map<String, dynamic> json) {
    return AppStoreData(
      name: json['name']?? '',
      views: (json['views'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, value.toString())) ??
          {},
      //roles: List<String>.from(json['roles']),
    );
  }
}
