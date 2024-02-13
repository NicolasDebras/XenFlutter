import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/design/Post/AddEditPostWidget.dart';
import 'package:xenflutter/models/post.dart';

import '../../services/PostsService.dart';
import '../../services/provider/AuthState.dart';
import '../../services/provider/api_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/design/Post/AddEditPostWidget.dart';
import 'package:xenflutter/models/post.dart';
import '../../services/PostsService.dart';
import '../../services/provider/AuthState.dart';
import '../../services/provider/api_service.dart';

class PostUx extends StatefulWidget {
  final Post post;

  const PostUx(this.post, {Key? key}) : super(key: key);

  @override
  State<PostUx> createState() => _PostUxState();
}

class _PostUxState extends State<PostUx> {
  bool isExpanded = false;
  Future<Post>? postDetailsFuture;

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      // Charge les détails du post uniquement lors du premier clic
      if (postDetailsFuture == null) {
        final apiService = Provider.of<ApiService>(context, listen: false);
        final postsService = PostsService(apiService.dio);
        postDetailsFuture = postsService.getById(widget.post.id!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);
    final isUserPostOwner = authState.user.id == widget.post.user?.id;
    const backgroundColor = Color(0xFF15202B);
    const textColor = Colors.white;
    const subtextColor = Color(0xFF8899A6);
    const actionIconColor = Color(0xFF1DA1F2);


    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(widget.post.user?.name ?? 'Anonyme', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            subtitle: Text(widget.post.content, style: TextStyle(color: textColor)),
            onTap: _toggleExpansion,
          ),
          if (widget.post.image?.url != null)
            Image.network(widget.post.image!.url!, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.comment, color: actionIconColor),
                Text('${widget.post.commentsCount ?? 0}', style: TextStyle(color: textColor)),
                Spacer(), // Utilisez Spacer pour pousser les icônes d'action à la droite
                if (isUserPostOwner) ...[
                  IconButton(
                    icon: Icon(Icons.edit, color: actionIconColor),
                    onPressed: () => _showEditDialog(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent), // Rouge pour l'action de suppression
                    onPressed: () => _deletePost(context),
                  ),
                ],
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: FutureBuilder<Post>(
              future: postDetailsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Erreur: ${snapshot.error}", style: TextStyle(color: subtextColor));
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data!.comments!.map((comment) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text("${comment.author!.name}: ${comment.content}", style: TextStyle(color: subtextColor)),
                      )).toList(),
                    ),
                  );
                } else {
                  return Text("Aucun commentaire disponible", style: TextStyle(color: subtextColor));
                }
              },
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: AddEditPostWidget(post: widget.post),
      ),
    );
  }

  void _deletePost(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);
    final apiService = Provider.of<ApiService>(context, listen: false);
    final postsService = PostsService(apiService.dio);
    postsService.deletePost(postId: widget.post.id!, token: authState.authToken).then((_) {
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la suppression: $error')));
    });
  }
}
