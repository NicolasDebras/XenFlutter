import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/register.dart';
import 'package:xenflutter/services/provider/AuthState.dart';

import 'login.dart';

class AuthFormSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showLogin = Provider.of<AuthState>(context).showLogin;

    return Expanded(
      child: Container(
        color: Colors.white,
        child: showLogin ? Login() : Register(),
      ),
    );
  }
}
