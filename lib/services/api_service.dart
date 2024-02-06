import 'package:dio/dio.dart';

class ApiService {
   late Dio _dio;

   ApiService() {
    _dio = Dio();

    _dio.options.baseUrl = 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/';
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

  }
   Dio get dio => _dio;
}
