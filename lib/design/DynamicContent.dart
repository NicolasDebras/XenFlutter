import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login.dart';
import '../services/provider/AuthState.dart';
import 'Post/PostPage.dart';

class DynamicContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, authState, child) {
        if (authState.isLoggedIn) {
          return Expanded(
            child: PostsPage(),
          );
        } else {
          return Login();
        }
      },
    );
  }
}