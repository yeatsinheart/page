import 'package:get/get.dart';
import '../util/color.dart';
import 'dart:math';

class LoginStore extends GetxController {
  // GetBuilder 手动调用 update  GetBuilder<Store>( id:特殊指定ID空为全局,builder: (store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // GetX GetX<Store>( id:特殊指定ID空为全局,builder: (store){return ***** store.color   ******;},initState: (store){},dispose: (store){},),
  // Obx Obx(()=> )
  var color = "#ffd900".obs;

  void changeColor(String hex) {
    color.value = hexFromRgb(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
    //update();
  }

// late Timer _timer;
// void change() async {
//   _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
//     //Get.put(Store()).changeColor("");
//   });
// }
}
