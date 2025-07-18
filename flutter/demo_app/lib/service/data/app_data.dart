import 'package:flutter/material.dart';

class AppData {
  int id;
  String name;
  String logo;
  Color color;
  String splash;

  AppData({
    this.id = 1,
    this.name = "微信",
    this.color = Colors.green,
    this.splash = "https://picx.zhimg.com/80/v2-aceeab66b2dded2b4197ebe2649c880f_1440w.webp?source=1940ef5c",
    this.logo = "https://open.weixin.qq.com/zh_CN/htmledition/res/assets/res-design-download/icon64_appwx_logo.png",
  });

  static List<AppData> fromJsonArray(List<dynamic> array) {
    List<AppData> list = [];
    for (var item in array) {
      list.add(fromJson(item));
    }
    return list;
  }

  static fromJson(item) {
    if (item == null) {
      return null;
    }
    return AppData(
      id: item['id'],
      name: item['name'],
      //color: item['color'],
    );
  }
}
