import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/services/request/signup_request.dart';
import 'package:xenflutter/services/AuthService.dart';

class Register extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context, listen: false);

    return Expanded(
      child: Container(
        color: Colors.lightBlue,
        child: ListView(
            children: [
        //nom
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Nom',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person, color: Colors.white,),
          ),
        ),
      ),
      //email
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
      //mot de passe
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
          String name = nameController.text;
          print(email); //pour debug
          print(password); //idem
          final requestJson = SignupRequest(name: name, email: email, password: password);
          try {
            final signupResponse = await authService.signUp(requestJson);
            //ici la gestion post-inscription : retour page de co et message pour dire c'est ok
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Inscription réussie')),
            );
          } catch (e) {
            //erreur d'inscription
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur d\'inscription: $e')),
            );
          }
        },
        child: Text('S\'inscrire'),
        ),
        ],
      ),
    ),
    );
  }
}
