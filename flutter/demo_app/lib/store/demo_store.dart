import 'package:get/get.dart';
import '../util/color.dart';
import 'dart:math';

class DemoStore extends GetxController {
  /*
  📌 建议使用方式对比
  场景	推荐用法
  全局状态（用户信息、配置等）	Get.put() 全局注册
  页面级状态（列表数据、表单等）	GetBuilder 或 Obx
  性能要求高、刷新粒度小	GetBuilder（手动刷新）
  简洁、响应式开发	Obx（自动刷新）
  */
  var xxx = "#ffd900".obs;//使用 obs 变为响应式

  void changeXxx(String hex) {
    xxx.value = hexFromRgb(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
    //update(); 没有带obs的属性
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
//  注册和使用控制器
//  ✅ 方式一：全局注册（推荐用于全局 store） 通常在入口或首次用到时注册 希望立即加载
//  final counterController = Get.put(CounterController());
//  ✅ 方式二：懒加载注册（适合按需加载） 使用懒加载，更省资源
//  Get.lazyPut(() => CounterController(), fenix: true);
  // 可选：提供访问器
  // static UserStore get user => Get.find<UserStore>();
  // static SettingsStore get settings => Get.find<SettingsStore>();

// 使用：
// final counterController = Get.find<CounterController>();
// Obx(() => Text('点击次数：${counterController.count}',style: TextStyle(fontSize: 30),)
// 非响应式的属性，也能调用
// GetBuilder<CounterController2>(init: CounterController2(),builder: (controller) {return Container(child:Text("点击次数：${controller.count}"))}

// late Timer _timer;
// void change() async {
//   _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
//     //Get.put(Store()).changeColor("");
//   });
// }
}
