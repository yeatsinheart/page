import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiTest{
  static dynamic test(RequestOptions options){
    // 只有本地运行开发模式才能模拟数据
    if(!kDebugMode)return null;

    if(options.path.contains("other")){
      String api = options.headers["api"];
      return {};
    }

    // 默认非模拟接口
    return null;
  }
}