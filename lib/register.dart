
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/services/AuthService.dart';
import 'package:xenflutter/services/api_service.dart';
import 'package:xenflutter/services/request/login_request.dart';
import 'package:xenflutter/services/response/login_response.dart';

import 'models/AuthState.dart';

class Register extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final AuthService authService = AuthService(apiService.dio);

    return Expanded(
      child: Container(
        color: Colors.indigoAccent,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.white,),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: Colors.white,),
                ),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                print(email);
                print(password);
                final requestJson = LoginRequest(email: email, password: password);
                final signupResponse = await authService.signIn(requestJson);
                final loginResponse = LoginResponse(user: signupResponse.user, authToken: signupResponse.authToken);

                // Trouver AuthState dans le contexte et mettre à jour l'état
                final authState = Provider.of<AuthState>(context, listen: false);
                authState.login(loginResponse.authToken, loginResponse.user);
              },
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
