import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter3/request/api_request.dart';
import 'package:flutter3/request/test.dart';
import 'package:get/get.dart' hide Response;

import '../log/logger.dart';
import '../store/host_status_store.dart';
import '../store/language_store.dart';
import 'cache.dart';

class ApiDio{
  ApiDio._internal();
  factory ApiDio() => _instance;
  static final ApiDio _instance = ApiDio._internal();
  Dio dio = getDio(Get.find<HostStatusStore>().chosenLine ?? 'https://example.com');
}

class HostCheckDio {
  final String host;
  HostCheckDio(this.host);
  Dio get dio => getDio(host);
}

Dio getDio(host) {
  final dio = Dio(
    BaseOptions(
      baseUrl: '${host}/api/',
      connectTimeout: const Duration(seconds: 5),
      // 建立连接最大等待时间
      receiveTimeout: const Duration(seconds: 10),
      // 接收响应最大等待时间 等待服务器响应的最大时间
      sendTimeout: const Duration(seconds: 5),
      // 发送数据最大等待时间 向服务器写入数据的最大时间
      headers: {
        'Accept-Language': Get.find<LanguageStore>().data.value["language"],
        'Host': 'api.example.com', // 伪造域名 使用IP直连时才生效
      },
    ),
  );
  _https_check(dio);
  _interceptors(dio);
  return dio;
}

_onRequest(options, handler) async {
  // 你可以从缓存/本地存储等获取 token
  // final token = await getToken(); // 假设是异步获取
  // if (token != null) {
  //   options.headers['Authorization'] = 'Bearer $token';
  // }
  options.headers['Accept-Language'] = Get.find<LanguageStore>().data.value["language"];
  // 模拟测试
  var response = ApiTest.test(options);
  if (null != response) return handler.resolve(Response(requestOptions: options, data: response, statusCode: 200));

  return handler.next(options);
}

_onResponse(response, handler) async {
  final headers = response.headers;
  final api_request_version = headers.value(ApiCache.versionKey);
  if (null != api_request_version) {
    ApiCache.setCache(ApiCache.versionKey, api_request_version, expire: -1);
  }
  return handler.next(response);
}

_onError(DioException e, handler) {
  //Log.err('Request to: ${e.requestOptions.uri} ', e);
  if (e.type == DioExceptionType.connectionError) {
    //Log.err("❌ 网络连接失败: ${e.requestOptions.uri} ${e.message}",e);
    handler.next(e);
  } else {
    Log.err("❌ 请求错误: ${e.requestOptions.uri} ${e.message}",e);
    handler.next(e);
  }
}

_interceptors(Dio dio) {
  dio.interceptors.clear(); // 移除默认 LogInterceptor（有些包预置了）
  // 动态全局请求头
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        return _onRequest(options, handler);
      },
      onResponse: (response, handler) {
        return _onResponse(response, handler);
      },
      onError: (DioException e, handler) {
        return _onError(e, handler);
      },
    ),
  );
}

_https_check(Dio dio) {
  // 忽略 HTTPS 证书校验
  if (!kIsWeb) {
    // ios 真机上是无效的，底层用 NSURLSession，属于系统底层拦截，还是要按照正常的文件配置去配信任域名
    final adapter = IOHttpClientAdapter()
      ..createHttpClient = () {
        final client = HttpClient();
        // 忽略 HTTPS 证书校验
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
    adapter.validateCertificate = (cert, host, port) {
      // 始终返回 true，表示跳过验证
      return true;
    };
    dio.httpClientAdapter = adapter;
  }
}
