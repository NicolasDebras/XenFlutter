import '../../models/user.dart';

class LoginResponse {
  final String authToken;
  final User user;

  LoginResponse({required this.authToken, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      authToken: json['authToken'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
