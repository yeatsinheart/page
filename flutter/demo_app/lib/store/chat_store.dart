import 'package:get/get.dart';
import '../util/color.dart';
import 'dart:math';

class ChatStore extends GetxController {
  // GetBuilder 手动调用 update  builder: (GetBuilder<Store>( id:特殊指定ID空为全局,store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // GetX GetX<Store>( id:特殊指定ID空为全局,builder: (store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // Obx Obx(()=> )
  var color = "#ffd900".obs;//使用 obs 变为响应式

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
