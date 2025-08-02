import 'package:flutter3/service/language.dart';
import 'package:get/get.dart';

class DepositStore extends GetxService {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  DepositStore._internal();
  static final DepositStore _instance = DepositStore._internal();
  factory DepositStore() => _instance;

  var chosen_payment = "".obs;
  var chosen_channel = "".obs;

  List<Map<String,dynamic>> payments = [];
  List<Map<String,dynamic>> channels = [];


  listen(data) async {}

  final chosen = "".obs;
  final list = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  choose(String code) async {
    await LanguageService().choose(code);
    chosen.value = code;
  }
}
