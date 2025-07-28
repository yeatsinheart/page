import 'package:dio/dio.dart';
import 'package:flutter3/log/logger.dart';
import 'dio.dart';

class ApiRequest {
  ApiRequest._internal();

  factory ApiRequest() => _instance;
  static final ApiRequest _instance = ApiRequest._internal();
  static Dio dio = ApiDio().dio;

  static request(Dio requestDio, String apiId, {method = 'GET', queryParameters, data, contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    try {
      var response = await requestDio.request(
        apiId,
        queryParameters: queryParameters,
        data: data,
        options: Options(method: method, contentType: contentType, headers: header),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {}
      //很多 async 跳过了真实调用点
      Log.err("dio出错 ${requestDio.options.baseUrl}$apiId ${data ?? {}}", e, stackTrace: e.stackTrace);
    } catch (e) {
      Log.err("请求出错 ${requestDio.options.baseUrl}$apiId ${data ?? {}}", e);
    }
  }

  static check(String apiId, host, {contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    Dio checkDio = HostCheckDio(host).dio;
    return request(checkDio, apiId, method: 'POST', contentType: Headers.jsonContentType, header: header);
  }

  static get(String apiId, {Map<String, dynamic>? params, contentType = Headers.jsonContentType, Map<String, dynamic>? header}) async {
    return request(dio, apiId, data: params, method: 'GET', contentType: Headers.jsonContentType, header: header);
  }

  static postJson(String apiId, Map<String, dynamic>? params, {Map<String, dynamic>? header}) async {
    return request(dio, apiId, data: params, method: 'POST', contentType: Headers.jsonContentType, header: header);
  }

  static postForm(String apiId, Map<String, dynamic>? params, {Map<String, dynamic>? header}) async {
    return request(dio, apiId, data: params, method: 'POST', contentType: Headers.formUrlEncodedContentType, header: header);
  }

  static postString(String apiId, String? data, {Map<String, dynamic>? header}) async {
    return request(dio, apiId, data: data, method: 'POST', contentType: Headers.textPlainContentType, header: header);
  }

  static upload(String apiId, dynamic params, {Map<String, dynamic>? header}) async {
    return request(dio, apiId, data: FormData.fromMap(params ?? {}), contentType: Headers.multipartFormDataContentType, header: header);
  }
}
