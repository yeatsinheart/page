
import 'http_util.dart';

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
  byHttp(){
    if (cache) {
      // 是否支持离线数据。。。 版本更新后。。。老数据是否有效。
      // var stored =
      // if !=null
      // int request_time = stored['request_time']
      // api.cacheTime > now-request_time
    }
    HttpRequestUtil.postJson(this.path, this.params);
  }
}

