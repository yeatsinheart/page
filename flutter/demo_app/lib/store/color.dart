import 'package:get/get.dart';
import '../util/color.dart';
import 'dart:math';

class ColorStore extends GetxController {
  // GetBuilder 手动调用 update  builder: (GetBuilder<Store>( id:特殊指定ID空为全局,store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // GetX GetX<Store>( id:特殊指定ID空为全局,builder: (store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // Obx Obx(()=> )
  var color = "#ffd900".obs;//使用 obs 变为响应式

  var page='#f7f8ff'.obs;
  var border='#e3e3e31a'.obs;
  var shadow='#41454940'.obs;
  var mask='#0000001f'.obs;
  // 默认情况下 GetxController 中的嵌套数据结构（比如 user.value.name = "x"）直接修改后不会触发 UI 自动刷新
  // ，除非你手动 .refresh() 或 .update()。这是因为 Dart 的引用类型不会自动触发响应式更新。
  //  user.update((val) {val?.name = 'Bob';}); 必须使用 .update() 包裹，UI 才会响应
  final Rx<ColorStoreData?> data = Rx<ColorStoreData?>(null);
  void setFromJson(Map<String, dynamic> json) {
    data.value = ColorStoreData.fromJson(json);
  }

  ColorStoreData? data1;
  void setFromJson1(Map<String, dynamic> json) {
    data1 = ColorStoreData.fromJson(json);
    update(); // 通知刷新
  }

  void updateName(String newName) {
    if (data.value != null) {
      data.update((val) {
        val?.name = newName;
      });
    }
  }

  void changeColor(String hex) {
    color.value = hexFromRgb(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
    //update();
  }

  // 可以写异步初始化、网络请求等
  @override
  void onInit() {
    super.onInit();
    print("ChatStore 初始化");
  }

  @override
  void onClose() {
    print("ChatStore 销毁");
    super.onClose();
  }

// late Timer _timer;
// void change() async {
//   _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
//     //Get.put(Store()).changeColor("");
//   });
// }
}
class ColorStoreData {
  int id;
  String name;
  List<String> roles;
  ColorStoreData({required this.id, required this.name, required this.roles});
  factory ColorStoreData.fromJson(Map<String, dynamic> json) {
    return ColorStoreData(
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

