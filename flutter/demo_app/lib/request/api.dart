import 'package:flutter3/share/context.dart';

import 'cache.dart';
import 'http_util.dart';

/// 如果接口定义： 前段本地缓存毫秒时间
/// 初始打包默认配置文件key，如果刚安装，就碰上网络请求不通的情况，最坏策略就是本地有打包对应的数据。
/// 如果全用请求版本，那么我只改了一个活动，只改了游戏一张图片，那么全量的所有数据都要重新下载。。。
///
class ApiRequest {
  String path;
  String type;
  bool loginRequired;
  bool cache;
  int cacheTime;
  dynamic test;

  ApiRequest(this.path, {this.type = "post", this.loginRequired = false, this.cache = false, this.cacheTime = 0, this.test});

  static testHost(data) => ApiRequest("init").post_json(data);
  /// 接口 START 可动态生成
  static init(data) => ApiRequest("init").post_json(data);

  static translate(data) => ApiRequest("translate").post_json(data);

  static getApp(data) => ApiRequest("asdf").post_json(data);

  static refreshUser(data) => ApiRequest("asdf").post_json(data);

  static getApp1(data) => ApiRequest("asdf", loginRequired: true, cache: true, cacheTime: 0).post_json(data);

  static uploadFile(file) => ApiRequest("asdf").upload({"file": file});

  /// 接口 END 可动态生成

  bool notLoggedIn() {
    return true;
  }

  Future<dynamic> post_json(dynamic data) async {
    if (loginRequired && notLoggedIn()) {
      //   /// 未登陆 去 登陆
      GlobalContext.load("login", params: {"action": "login"});
      Future.error("未登陆");
      //   //userStore().toLogin();return Promise.reject("un-login");
    }

    if (null != test) return test;

    if (cache) {
      // 静态资源版本号。打包时写入，每次请求后动态更新=>重启后还能生效。。
      String v = await ApiCache.getCache(ApiCache.versionKey);
      var cached = await ApiCache.getCache(path, version: v);
      if (null != cached) {
        return cached;
      }
    }

    var response = type == "post" ? await HttpRequestUtil.postJson(path, data) : await HttpRequestUtil.get(path);
    if (cache) {
      ApiCache.setCache(path, response, expire: cacheTime);
    }
    return response;
  }

  dynamic upload(data) {
    return HttpRequestUtil.upload(path, data);
  }
}
