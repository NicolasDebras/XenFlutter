import 'package:dio/dio.dart';
import 'package:xen_flutter/models/user.dart';
import 'package:xen_flutter/models/post.dart';

class ApiService {
  //connexion à l'api
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi'),
  );

  //inscrire un user (A TESTER) et a changer de place
  Future<SignupResponse> signUp(SignupRequest request) async {
    final response = await _dio.post('/users/signup', data: request.toJson());
    return SignupResponse.fromJson(response.data);
  }

}
