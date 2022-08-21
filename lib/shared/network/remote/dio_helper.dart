import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl:
          'http://192.168.43.7:8000/api/v1', //'http://mvs.bslmeiyu.com/api/v1',

      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      //'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    return await dio!.post(
      url,
      queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    print('data ${data}');
    print('token ${token}');
    return await dio!.put(
      url,
      //queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return await dio!.delete(
      url,
      //queryParameters: queryParameters,
      data: data,
    );
  }
}
