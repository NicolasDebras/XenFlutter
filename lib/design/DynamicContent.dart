import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AuthFormSwitcher.dart';
import '../login.dart';
import '../services/provider/AuthState.dart';
import 'Post/PostPage.dart';

class DynamicContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, authState, child) {
        final content = authState.isLoggedIn ? PostsPage() : AuthFormSwitcher();
        return authState.isLoggedIn ? Expanded(child: content) : content;
      },
    );
  }
}
