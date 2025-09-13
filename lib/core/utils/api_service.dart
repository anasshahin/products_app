import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://dummyjson.com/products';
  final Dio _dio;

  ApiService(this._dio);

  Future<dynamic> get({ String? endPoint}) async {
    Response response;
    if(endPoint == null) {
      response = await _dio.get(_baseUrl);
    } else {
      response = await _dio.get('$_baseUrl$endPoint');
    }

    return response.data;
  }

}
