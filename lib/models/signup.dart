import '../services/signup_request.dart';
import '../services/signup_response.dart';

class Signup {
  final SignupRequest request;
  final SignupResponse response;

  Signup({
    required this.request,
    required this.response,
  });
}
