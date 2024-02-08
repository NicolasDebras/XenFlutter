import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget implements PreferredSizeWidget {
  HeaderAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigo,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // hauteur standard
}
