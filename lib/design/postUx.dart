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
    Color color = Colors.indigoAccent.shade700;

    return GestureDetector(
      onTap: _onTap,
      child: Container(
        height: 25,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
            child: Text(widget.post.content)
        ),
      ),
    );
  }

  void _onTap() {
    // TODO A FAIRE AFFICHAGES DES COMMENTAIRES
  }
}

