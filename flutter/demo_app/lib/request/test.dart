import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter3/log/logger.dart';

class ApiTest{
  static dynamic test(RequestOptions options){
    // 只有本地运行开发模式才能模拟数据
    if(!kDebugMode)return null;

    if(options.path=="translate"){
      String language = options.data["language"]??"en_US";
      if (language == 'zh_CN') {
        return {'微信': '微信xxx', 'testImage': 'https://pic.616pic.com/photoone/00/02/58/618cf527354c35308.jpg!/fw/1120'};
      } else {
        return {'testImage': 'https://pic.616pic.com/photoone/00/06/02/618e27a728fd34751.jpg!/fw/1120', '首页': 'home', '发现': 'discover', '我': 'me', '微信': 'wechat', '热门': '🔥Hot'};
      }
    }

    // 默认非模拟接口
    return null;
  }
}