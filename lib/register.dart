import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/services/AuthService.dart';
import 'package:xenflutter/services/provider/AuthState.dart';
import 'package:xenflutter/services/request/signup_request.dart';

class Register extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context, listen: false);

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
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: Icon(Icons.person, color: Color(0xFF1DA1F2)),
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
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
                    String name = nameController.text;

                    try {
                      final requestJson = SignupRequest(name: name, email: email, password: password);
                      await authService.signUp(requestJson);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inscription réussie')));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur d\'inscription: $e')));
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
                  child: Text('S\'inscrire'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      // Utilisez Provider pour basculer l'état.
                      Provider.of<AuthState>(context, listen: false).toggleForm();
                    },
                    child: Text(
                      "Se coonecter",
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
