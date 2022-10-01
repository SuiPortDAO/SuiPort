import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  get(path, queryParameters) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  post(path, data) {
    return _dio.post(path, data: data);
  }
}
