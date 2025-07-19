import 'package:get/get.dart';
import 'dart:math';

class AppStore extends GetxController {
  var newRouteKey = "/".obs;//使用 obs 变为响应式

  // GetBuilder 手动调用 update  builder: (GetBuilder<Store>( id:特殊指定ID空为全局,store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // GetX GetX<Store>( id:特殊指定ID空为全局,builder: (store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // Obx Obx(()=> )

  // 默认情况下 GetxController 中的嵌套数据结构（比如 user.value.name = "x"）直接修改后不会触发 UI 自动刷新
  // ，除非你手动 .refresh() 或 .update()。这是因为 Dart 的引用类型不会自动触发响应式更新。
  //  user.update((val) {val?.name = 'Bob';}); 必须使用 .update() 包裹，UI 才会响应
  final Rx<AppStoreData?> data = Rx<AppStoreData?>(null);
  void setFromJson(Map<String, dynamic> json) {
    data.value = AppStoreData.fromJson(json);
  }

  AppStoreData? data1;
  void setFromJson1(Map<String, dynamic> json) {
    data1 = AppStoreData.fromJson(json);
    update(); // 通知刷新
  }

  void updateName(String newName) {
    if (data.value != null) {
      data.update((val) {
        val?.name = newName;
      });
    }
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

// late Timer _timer;
// void change() async {
//   _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
//     //Get.put(Store()).changeColor("");
//   });
// }
}
class AppStoreData {
  int id;
  String name;
  List<String> roles;
  AppStoreData({required this.id, required this.name, required this.roles});
  factory AppStoreData.fromJson(Map<String, dynamic> json) {
    return AppStoreData(
      id: json['id'],
      name: json['name'],
      roles: List<String>.from(json['roles']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'roles': roles,
  };
}

