import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;
  static init() {
    _dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? queries,
      String lang = 'ar',
      String? token}) async {
    _dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token
    };
    return await _dio.get(url, queryParameters: queries);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? queries,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    _dio.options.headers = {'lang': lang, 'Authorization': token};
    return await _dio.post(url, queryParameters: queries, data: data);
  }

  static Future<Response> putData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? paramtersta,
    String lang = 'en',
    required String token,
  }) async {
    _dio.options.headers = {'lang': lang, 'Authorization': token};
    return await _dio.put(
      path,
      data: data,
      queryParameters: paramtersta,
    );
  }
}
