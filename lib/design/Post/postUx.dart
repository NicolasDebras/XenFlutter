import 'package:flutter/material.dart';
import 'package:xenflutter/models/post.dart';

//Post a mettre dans la liste des postes
class PostUx extends StatefulWidget {
  final Post post;

  const PostUx(this.post, {super.key});

  @override
  State<PostUx> createState() => _PostUx();

}

class _PostUx extends State<PostUx> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: 25,
        color: Colors.indigoAccent,
        child: Center(
            child: Text(widget.post.content,
                  style: const TextStyle(color: Colors.white),)
        ),
      ),
    );
  }

  void _onTap() {
    // TODO A FAIRE AFFICHAGES DES COMMENTAIRES
  }
}

