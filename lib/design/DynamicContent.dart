import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login.dart';
import '../models/AuthState.dart';
import '../register.dart';
import 'Post/PostList.dart';

class DynamicContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, authState, child) {
        if (authState.isLoggedIn) {
          return Expanded(
            child: Postlist(),
          );
        } else {
          return Login();
        }
      },
    );
  }
}