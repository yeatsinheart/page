import 'package:get/get.dart';

class AppStore extends GetxService {
  final Rx<AppStoreData?> data = Rx<AppStoreData?>(null);


  Future<AppStore> init(Map<String, dynamic> json) async {
    setFromJson(json);
    return this;
  }

  void setFromJson(Map<String, dynamic> json) {
    data.value = AppStoreData.fromJson(json);
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
