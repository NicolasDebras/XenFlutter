import 'package:dio/dio.dart';
import 'package:xenflutter/models/user.dart';
import 'package:xenflutter/services/request/signup_request.dart';
import 'package:xenflutter/services/response/signup_response.dart';
import 'package:xenflutter/services/request/login_request.dart';
import 'package:xenflutter/services/response/login_response.dart';

//ici on essaye de gérer l'inscription et la connexion d'un user
class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<SignupResponse> signUp(SignupRequest request) async {
    try {
      final response = await _dio.post('/auth/signup', data: request.toJson());
      return SignupResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de l\'inscription: $e');
    }
  }

  Future<LoginResponse> signIn(LoginRequest request) async {
    try {
      final response = await _dio.post('/auth/login', data: request.toJson());
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de la connexion: $e');
    }
  }
}
