import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/design/Post/AddEditPostWidget.dart';
import 'package:xenflutter/models/post.dart';

import '../../services/PostsService.dart';
import '../../services/provider/AuthState.dart';
import '../../services/provider/api_service.dart';

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
    final authState = Provider.of<AuthState>(context, listen: false);
    final isUserPostOwner = authState.user.id == widget.post.user?.id;
    final apiService = Provider.of<ApiService>(context, listen: false);
    final PostsService postsService = PostsService(apiService.dio);

    return GestureDetector(
      onTap: _onTap,
      child: Card(
        color: Colors.indigoAccent,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.post.user?.name ?? 'Anonyme',
              style: const TextStyle(
                color: Colors.pinkAccent,
              ),),
            if (widget.post.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(widget.post.content, style: const TextStyle(
                  color: Colors.white,
                ),),
              ),
            if (widget.post.image?.url != null)
              SizedBox(
                height: 100,
                child: Image.network(
                  widget.post.image!.url!,
                  fit: BoxFit.cover,
                ),
              ),
            // Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.comment, color: Colors.white,),
                  Text('${widget.post.commentsCount ?? 0}', style: const TextStyle(
                    color: Colors.white,
                  ),),
                  if (isUserPostOwner) ...[
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white,),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: AddEditPostWidget(post: widget.post),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.white,),
                      onPressed: () {
                        postsService.deletePost(postId: widget.post!.id!, token: authState.authToken);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    // TODO: Affichage des commentaires
  }
}
