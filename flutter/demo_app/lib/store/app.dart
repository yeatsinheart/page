import 'package:flutter/material.dart';
import 'package:flutter3/service/language.dart';
import 'package:get/get.dart';

class AppStore extends GetxService {
  // 单例一旦创建，就会一直存在内存中，直到程序退出或手动销毁
  AppStore._internal();
  static final AppStore _instance = AppStore._internal();
  factory AppStore() => _instance;
  Rx<Key> appKey = UniqueKey().obs;

  void rebuildApp() {
    appKey.value = UniqueKey(); // 改变 key，触发 rebuild
  }

  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
