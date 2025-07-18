import 'package:flutter3/service/data/skin_data.dart';

import 'data/app_data.dart';

class AppService {
  AppService._internal();

  factory AppService() => _instance;
  static final AppService _instance = AppService._internal();
  AppData? _cache = null;

  /// 当前代码版本，每次新内容时需要升级一次。
  static int version = 1;

  AppData? get() {
    // .获取 应用基础信息 加密秘钥
    //     品牌信息：Logo 名字

    //     路由
    //     皮肤

    //     语言
    //     币种
    //     关键数据， 监听数据，监听功能
    _cache ??= AppData.fromJson({"id": 1, "name": "测试应用", "logo": "https://open.weixin.qq.com/zh_CN/htmledition/res/assets/res-design-download/icon64_appwx_logo.png"});
    return AppData();
  }
  SkinData? skin(){
    return SkinData();
  }
}
