import 'package:flutter3/share/context.dart';

import 'cache.dart';
import 'api_request.dart';

/// 如果接口定义： 前段本地缓存毫秒时间
/// 初始打包默认配置文件key，如果刚安装，就碰上网络请求不通的情况，最坏策略就是本地有打包对应的数据。
/// 如果全用请求版本，那么我只改了一个活动，只改了游戏一张图片，那么全量的所有数据都要重新下载。。。
///
class Api {
  String apiId;

  String type;
  bool loginRequired;
  bool cache;
  int cacheTime;
  dynamic test;

  static checkHost(host) => Api("init", type: "check").request(host);

  /// 接口 START 可动态生成
  static init(data) => Api("init").request(data);

  static language(data) => Api("language").request(data);
  static translate(data) => Api("translate").request(data);

  static refreshUser(data) => Api("refreshUser").request(data);

  static demo(data) => Api("demo", loginRequired: true, cache: true, cacheTime: 0).request(data);

  static uploadFile(file) => Api("uploadFile").upload({"file": file});

  /// 接口 END 可动态生成

  Api(this.apiId, {this.type = "post", this.loginRequired = false, this.cache = false, this.cacheTime = 0, this.test});

  bool notLoggedIn() {
    return true;
  }

  Future<dynamic> request(dynamic data) async {
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
      var cached = await ApiCache.getCache(apiId, version: v);
      if (null != cached) {
        return cached;
      }
    }

    var response = switch (type) {
      "post" => await ApiRequest.postJson(apiId, data),
      "get" => await ApiRequest.get(apiId, params: data),
      "check" => await ApiRequest.check(apiId, data),
      _ => null,
    };

    if (cache) {
      ApiCache.setCache(apiId, response, expire: cacheTime);
    }
    return response;
  }

  dynamic upload(data) {
    return ApiRequest.upload(apiId, data);
  }
}
