
import 'api_cache.dart';
import 'http_util.dart';
/// 如果接口定义： 前段本地缓存毫秒时间
/// 初始打包默认配置文件key，如果刚安装，就碰上网络请求不通的情况，最坏策略就是本地有打包对应的数据。
/// 如果全用请求版本，那么我只改了一个活动，只改了游戏一张图片，那么全量的所有数据都要重新下载。。。
///
class ApiService {
  ApiService._internal();
  factory ApiService() => _instance;
  static final ApiService _instance = ApiService._internal();

  static get app => Api("asdf");

  static get login => Api("fres");

  static get update => Api("fres");

  static get first => Api("fasd");

  static get maintance => Api("fasd");

  static get customer => Api("fasd");

  static get alltag => Api("tgoef");

  static get videos_in_tag => Api("ggdf", params: {"size": 10});

  static get videos => Api("fg", params: {"size": 10});
}

class Api {
  static const empty_params = {};
  bool login = false;
  bool cache = false;
  int cacheTime = 0;
  int version = 0;
  String _path;
  Map<String, dynamic> _params = {};

  Api(this._path, {params = empty_params, login = false, cache = false, cacheTime = 0, version = 0});

  Map<String, dynamic> get params => _params ?? {};

  // 网关地址+API
  String get path => "/api/$_path";
  byHttp() async{
    // 静态资源版本号。打包时写入，每次请求后动态更新=>重启后还能生效。。
    String v = await ApiCache.getCache(ApiCache.versionKey);
    var cached = await ApiCache.getCache(_path,version: v);
    if (cache && null!=cached) {
      return cached;
    }
    return HttpRequestUtil.postJson(this.path, this.params);
  }
}

