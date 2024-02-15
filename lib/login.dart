import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/register.dart';
import 'package:xenflutter/services/AuthService.dart';
import 'package:xenflutter/services/provider/AuthState.dart';
import 'package:xenflutter/services/provider/api_service.dart';
import 'package:xenflutter/services/request/login_request.dart';
import 'package:xenflutter/services/response/login_response.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final AuthService authService = AuthService(apiService.dio);

    return Expanded(
      child: Container(
        color: Colors.white, // Fond blanc pour le conteneur
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.flutter_dash,
                  size: 100,
                  color: Color(0xFF1DA1F2), // Couleur bleue de Twitter
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: Icon(Icons.email, color: Color(0xFF1DA1F2)),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF1DA1F2)),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Veuillez remplir tous les champs")),
                      );
                      return;
                    }

                    try {
                      final requestJson = LoginRequest(email: email, password: password);
                      final signInResponse = await authService.signIn(requestJson);
                      final loginResponse = LoginResponse(user: signInResponse.user, authToken: signInResponse.authToken);

                      final authState = Provider.of<AuthState>(context, listen: false);
                      authState.login(loginResponse.authToken, loginResponse.user);

                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Échec de la connexion: vérifiez vos informations")),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1DA1F2), // Couleur bleue de Twitter
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text('Se connecter'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      // Utilisez Provider pour basculer l'état.
                      Provider.of<AuthState>(context, listen: false).toggleForm();
                    },
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Color(0xFF1DA1F2), // Couleur bleue de Twitter
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
