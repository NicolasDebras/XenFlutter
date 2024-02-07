import '../services/request/signup_request.dart';
import '../services/response/signup_response.dart';

class Signup {
  final SignupRequest request;
  final SignupResponse response;

  Signup({
    required this.request,
    required this.response,
  });
}
