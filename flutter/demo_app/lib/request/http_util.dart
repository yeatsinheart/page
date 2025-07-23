import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

Dio createDioWithBadCertSupport() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://example.com/api',
      connectTimeout: const Duration(seconds: 5),
      // 建立连接最大等待时间
      receiveTimeout: const Duration(seconds: 10),
      // 接收响应最大等待时间 等待服务器响应的最大时间
      sendTimeout: const Duration(seconds: 5),

      // 发送数据最大等待时间 向服务器写入数据的最大时间
      headers: {
        'Authorization': 'Bearer your_token_here',
        'Content-Type': 'application/json',
        'Accept-Language': 'en-US',
        'Host': 'api.example.com', // 伪造域名 使用IP直连时才生效
      },
    ),
  );

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
        options.headers['Accept-Language'] = 'en-US';
        return handler.next(options);
      },
    ),
  );
  return dio;
}

final dio = createDioWithBadCertSupport();

/*
dio.options.headers['Authorization'] = 'Bearer $token';
dio.options.headers['Accept-Language'] = 'zh-CN';

dio.options.headers.remove('Authorization');


* */
class HttpRequestUtil {
  HttpRequestUtil._internal();

  factory HttpRequestUtil() => _instance;
  static final HttpRequestUtil _instance = HttpRequestUtil._internal();

  static get(String url) async {
    try {
      var response = await dio.get(url);
      return Future.value(response);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  /*
而我们在实际开发中常用的 Content-Type如下
multipart/form-data
application/json JSON数据格式
application/x-www-form-urlencoded 表单数据格式
* */
  //Content-type 是 text/plain

  static postJson(String url, Map<String, dynamic>? params) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      Response response = await dio.post(
        url,
        data: params ?? {},
        options: Options(contentType: Headers.jsonContentType),
      );
      return Future.value(response);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  static postForm(String url, Map<String, dynamic>? params) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      Response response = await dio.post(
        url,
        data: params ?? {},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return Future.value(response);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  static upload(String url, Map<String, dynamic>? params) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      FormData formData = FormData.fromMap(params ?? {});
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
      return Future.value(response);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  static postString(String url, String? data) async {
    try {
      return dio.post(
        url,
        data: data,
        options: Options(contentType: Headers.textPlainContentType),
      );
    } catch (e) {
      print(e);
      //MsgOverlay.notify("网络异常");
      return Future.error(e);
    }
  }
}

main() async {
  Future a = HttpRequestUtil.get("https://www.baiduddddd.com");
  a.then((valua) {
    print(valua);
  });
}
