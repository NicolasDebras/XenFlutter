import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  //TODO à completer
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.10,
        width: MediaQuery.of(context).size.width,
        color: Colors.indigo
    );
  }
 }