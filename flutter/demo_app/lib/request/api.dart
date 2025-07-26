import 'package:flutter3/share/context.dart';

import 'api_cache.dart';
import 'http_util.dart';

/// 如果接口定义： 前段本地缓存毫秒时间
/// 初始打包默认配置文件key，如果刚安装，就碰上网络请求不通的情况，最坏策略就是本地有打包对应的数据。
/// 如果全用请求版本，那么我只改了一个活动，只改了游戏一张图片，那么全量的所有数据都要重新下载。。。
///
class ApiRequest {
  ApiRequest._internal();

  factory ApiRequest() => _instance;
  static final ApiRequest _instance = ApiRequest._internal();

  static init() => _Api("init").post_json(null); // app初始化配置

  static translate(data) => _Api("translate").post_json(data); //页面组合
  static getApp(data) => _Api("asdf").post_json(data); //页面组合
  static getApp1(data) => _Api("asdf",loginRequired: true,cache: true,cacheTime: 0).post_json(data); //页面组合
  static upload(data) => _Api("asdf").upload({"file":data}); //页面组合
}
class _Api {
  String _path;
  bool loginRequired;
  bool cache;
  int cacheTime;
  _Api(this._path, {this.loginRequired = false, this.cache = false, this.cacheTime = 0});

  dynamic post_json(data) async {
    if (loginRequired) {
      //   /// 未登陆 去 登陆
      GlobalContext.load("login", params: {"action":"login"});
      //   //userStore().toLogin();return Promise.reject("un-login");
    }
    if (cache) {
      // 静态资源版本号。打包时写入，每次请求后动态更新=>重启后还能生效。。
      String v = await ApiCache.getCache(ApiCache.versionKey);
      var cached = await ApiCache.getCache(_path, version: v);
      if (null != cached) {
        return cached;
      }
    }

    var response = await HttpRequestUtil.postJson(_path, data);
    if (cache) {
      ApiCache.setCache(_path, response,expire: cacheTime);
    }
    return response;
  }

  dynamic upload(data) {
    return HttpRequestUtil.upload(_path, data);
  }
}

/*

 upload(data,loginRequired) => {
if(loginRequired && !userStore().isLoggedIn){userStore().toLogin();return Promise.reject("un-login");}
const formData = new FormData();
formData.append('file', data.data);
return request({
url: "/api/client",
method: "POST",
Api: data.api,
data:formData,
headers: {
'Content-Type': 'multipart/form-data', // 文件上传类型
},
})
}
*/
