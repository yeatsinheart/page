import 'package:dio/dio.dart';
import 'package:flutter3/log/logger.dart';
import 'dio.dart';

class ApiRequest {
  ApiRequest._internal();

  factory ApiRequest() => _instance;
  static final ApiRequest _instance = ApiRequest._internal();
  static Dio dio = ApiDio().dio;

  static check(String url, host, {contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      Response response = await HostCheckDio(host).dio.post(
        url,
        data: {},
        options: Options(contentType: contentType, headers: header),
      );
      return response.data;
    } catch (e, s) {
      Log.error(e, stackTrace: s);
    }
  }

  static get(String url, {Map<String, dynamic>? params, contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    try {
      var response = await dio.get(
        url,
        queryParameters: params ?? {},
        options: Options(contentType: contentType, headers: header),
      );
      return response.data;
    } catch (e, s) {
      Log.error(e, stackTrace: s);
    }
  }

  static post(String url, params, {contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      Response response = await dio.post(
        url,
        data: params ?? {},
        options: Options(contentType: contentType, headers: header),
      );
      return response.data;
    } catch (e, s) {
      Log.error(e, stackTrace: s);
    }
  }

  static postJson(String url, Map<String, dynamic>? params, {Map<String, dynamic>? header}) async {
    return post(url, params, contentType: Headers.jsonContentType, header: header);
  }

  static postForm(String url, Map<String, dynamic>? params, {Map<String, dynamic>? header}) async {
    return post(url, params, contentType: Headers.formUrlEncodedContentType, header: header);
  }

  static postString(String url, String? data, {Map<String, dynamic>? header}) async {
    return post(url, data, contentType: Headers.textPlainContentType, header: header);
  }

  static upload(String url, dynamic params, {Map<String, dynamic>? header}) async {
    return post(url, FormData.fromMap(params ?? {}), contentType: Headers.multipartFormDataContentType, header: header);
  }
}
