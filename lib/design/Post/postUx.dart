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
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.post.user?.name ?? 'Anonyme'),
            if (widget.post.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.post.content),
              ),
            if (widget.post.image?.url != null)
              Image.network(widget.post.image!.url!),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.comment, size: 20.0),
                  Text('${widget.post.commentsCount ?? 0}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    // TODO A FAIRE AFFICHAGES DES COMMENTAIRES
  }
}

