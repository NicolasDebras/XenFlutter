import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddEditPostWidget.dart';
import 'PostList.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Expanded(
          child: Postlist(),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: AddEditPostWidget(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
