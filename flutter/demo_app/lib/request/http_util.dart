import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter3/request/cache.dart';
import 'package:flutter3/request/test.dart';
import 'package:flutter3/log/logger.dart';
import 'package:flutter3/store/language_store.dart';
import 'package:get/get.dart' hide Response, FormData;

Dio init() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://example.com/api/',
      connectTimeout: const Duration(seconds: 5),
      // 建立连接最大等待时间
      receiveTimeout: const Duration(seconds: 10),
      // 接收响应最大等待时间 等待服务器响应的最大时间
      sendTimeout: const Duration(seconds: 5),

      // 发送数据最大等待时间 向服务器写入数据的最大时间
      headers: {
        'Accept-Language': 'en-US',
        'Host': 'api.example.com', // 伪造域名 使用IP直连时才生效
      },
    ),
  );

  dio.interceptors.clear(); // 移除默认 LogInterceptor（有些包预置了）

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
  // 动态全局请求头
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
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
      },
      onResponse: (response, handler) async {
        final headers = response.headers;
        final api_request_version = headers.value(ApiCache.versionKey);
        if (null != api_request_version) {
          ApiCache.setCache(ApiCache.versionKey, api_request_version, expire: -1);
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        Log.err('Request to: ${e.requestOptions.uri} ', e);
        handler.next(e);
      },
    ),
  );
  return dio;
}

final dio = init();

class HttpRequestUtil {
  HttpRequestUtil._internal();
  factory HttpRequestUtil() => _instance;
  static final HttpRequestUtil _instance = HttpRequestUtil._internal();

  static get(String url, { Map<String, dynamic>? params,contentType=Headers.jsonContentType,Map<String, dynamic>? header}) async {
    try {
      var response = await dio.get(url, queryParameters:params??{},options: Options(contentType:contentType,headers: header));
      return response.data;
    } catch (e) {
      Log.error(e);
    }
  }

  static post(String url,params, {contentType=Headers.jsonContentType,Map<String, dynamic>? header}) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      Response response = await dio.post(
        url,
        data: params ?? {},
        options: Options(contentType: contentType, headers: header),
      );
      return response.data;
    } catch (e) {
      Log.error(e);
    }
  }

  static postJson(String url, Map<String, dynamic>? params, {Map<String, dynamic>? header}) async {
    return post(url,params,contentType: Headers.jsonContentType,header: header);
  }

  static postForm(String url, Map<String, dynamic>? params, {Map<String, dynamic>? header}) async {
    return post(url,params,contentType: Headers.formUrlEncodedContentType,header: header);
  }

  static upload(String url, dynamic params, {Map<String, dynamic>? header}) async {
      return post(url,FormData.fromMap(params ?? {}),contentType: Headers.multipartFormDataContentType,header: header);
  }

  static postString(String url, String? data, {Map<String, dynamic>? header}) async {
    return post(url,data,contentType: Headers.textPlainContentType,header: header);
  }
}
