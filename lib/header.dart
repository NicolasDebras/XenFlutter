import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/provider/AuthState.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  HeaderAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo,
      elevation: 0,
      title: Center(
        child: Icon(
          Icons.flutter_dash,
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.white),
          onPressed: () {
            _logout(context);
          },
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);
    authState.logout();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Hauteur standard
}
