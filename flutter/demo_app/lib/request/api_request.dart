import 'package:dio/dio.dart';
import 'package:flutter3/log/logger.dart';
import 'dio.dart';

class ApiRequest {
  ApiRequest._internal();

  factory ApiRequest() => _instance;
  static final ApiRequest _instance = ApiRequest._internal();
  static Dio dio = ApiDio().dio;

  static check(String apiId, host, {contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
      int now = DateTime.now().millisecondsSinceEpoch;
      Dio checkdio = HostCheckDio(host).dio;
    try {
      Response response = await checkdio.post(
        apiId,
        data: {},
        options: Options(contentType: contentType, headers: header),
      );
      return response.data;
    } on DioException catch (e) {
      //很多 async 跳过了真实调用点
      Log.err("check 请求出错 ${checkdio.options.baseUrl}$apiId",e,stackTrace: e.stackTrace);
    } catch(e){
      Log.err("check 请求出错",e);
    }
  }

  static get(String apiId, {Map<String, dynamic>? params, contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    try {
      var response = await dio.get(
        apiId,
        queryParameters: params ?? {},
        options: Options(contentType: contentType, headers: header),
      );
      return response.data;
    } on DioException catch (e) {
      //很多 async 跳过了真实调用点
      Log.err("get 请求出错 ${dio.options.baseUrl}$apiId ${params?? {}}",e,stackTrace: e.stackTrace);
    } catch(e){
      Log.err("get 请求出错 ${dio.options.baseUrl}$apiId ${params?? {}}",e);
    }
  }

  static post(String apiId, params, {contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    try {
      int now = DateTime.now().millisecondsSinceEpoch;
      Response response = await dio.post(
        apiId,
        data: params ?? {},
        options: Options(contentType: contentType, headers: header),
      );
      return response.data;
    } on DioException catch (e) {
      //很多 async 跳过了真实调用点
      Log.err("post 请求出错 ${dio.options.baseUrl}$apiId ${params?? {}}",e,stackTrace: e.stackTrace);
    } catch(e){
      Log.err("post 请求出错 ${dio.options.baseUrl}$apiId ${params?? {}}",e);
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
