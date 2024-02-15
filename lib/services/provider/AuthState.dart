import 'package:flutter/cupertino.dart';
import 'package:xenflutter/models/user.dart';

class AuthState with ChangeNotifier {
  bool _isLoggedIn = false;
  String _authToken = '';
  User _user;

  bool _showLogin = true;

  bool get showLogin => _showLogin;

  void toggleForm() {
    _showLogin = !_showLogin;
    notifyListeners();
  }

  AuthState({bool isLoggedIn = false, String authToken = '', required User user})
      : _isLoggedIn = isLoggedIn,
        _authToken = authToken,
        _user = user;

  bool get isLoggedIn => _isLoggedIn;
  String get authToken => _authToken;
  User get user => _user;

  void login(String authToken, User user) {
    _isLoggedIn = true;
    _authToken = authToken;
    _user = user;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _authToken = '';
    _user = User.empty();
    notifyListeners();
  }
}