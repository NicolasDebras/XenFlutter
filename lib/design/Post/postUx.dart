import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/design/Post/AddEditPostWidget.dart';
import 'package:xenflutter/models/post.dart';

import '../../services/PostsService.dart';
import '../../services/provider/AuthState.dart';
import '../../services/provider/PostsProvider.dart';
import '../../services/provider/api_service.dart';
import 'AddEditCommentWidget.dart';


class PostUx extends StatefulWidget {
  final Post post;

  const PostUx(this.post, {Key? key}) : super(key: key);

  @override
  State<PostUx> createState() => _PostUxState();
}

class _PostUxState extends State<PostUx> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);
    final isUserPostOwner = authState.user.id == widget.post.user?.id;
    const backgroundColor = Color(0xFF15202B);
    const textColor = Colors.white;

    const actionIconColor = Color(0xFF1DA1F2);

    void _toggleExpansion() {
      setState(() {
        isExpanded = !isExpanded;
        if (isExpanded && widget.post.comments == null) {
          final postsProvider = Provider.of<PostsProvider>(context, listen: false);
          postsProvider.loadCommentsForPost(widget.post, context);
        }
      });
    }

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
            Center(
              child: SizedBox(
                height: 200,
                child: Center( child:
                Image.network(widget.post.image!.url!, fit: BoxFit.cover),)
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment, color: actionIconColor),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AddEditCommentWidget(postId: widget.post.id!),
                        );
                      },
                    ),
                    SizedBox(width: 5),
                    Text('${widget.post.commentsCount ?? 0}', style: TextStyle(color: textColor)),
                  ],
                ),
                if (isUserPostOwner)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: actionIconColor),
                        onPressed: () => _showEditDialog(context),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _deletePost(context),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: isExpanded ? _buildCommentsSection() : Container(),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    final authState = Provider.of<AuthState>(context, listen: false);

    return Consumer<PostsProvider>(
      builder: (context, provider, child) {
        final postWithComments = provider.posts.firstWhere((p) => p.id == widget.post.id, orElse: () => widget.post);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: postWithComments.comments?.map((comment) => Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.content!, style: TextStyle(color: Colors.white70)),
                      Text("- ${comment.author!.name}", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),  // Condition pour afficher les icônes de modification et de suppression
                if (authState.user.id == comment.author?.id) ...[
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white70),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AddEditCommentWidget(postId: widget.post.id!, comment: comment),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      final postsProvider = Provider.of<PostsProvider>(context, listen: false);
                      postsProvider.deleteCommentFromPost(widget.post.id!, comment.id, context, authState.authToken);
                    },
                  ),
                ],
              ],
            )).toList() ?? [],
          ),
        );
      },
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
      Provider.of<PostsProvider>(context, listen: false).deletePost(widget.post.id!);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la suppression: $error')));
    });
  }
}
