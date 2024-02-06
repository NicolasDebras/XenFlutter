import 'package:dio/dio.dart';
import 'package:xenflutter/models/user.dart';
import 'package:xenflutter/models/post.dart';
import 'package:xenflutter/services/signup_request.dart';
import 'package:xenflutter/services/signup_response.dart';

class ApiService {
  final Dio _dio;

  ApiService({required String baseUrl}) : _dio = Dio(BaseOptions(baseUrl: baseUrl ?? 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi'));

  //à retirer potentiellement
  Future<SignupResponse> signUp(SignupRequest request) async {
    final response = await _dio.post('/auth/signup', data: request.toJson());
    return SignupResponse.fromJson(response.data);
  }
}
