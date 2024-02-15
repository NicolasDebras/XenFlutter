import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/comment.dart';
import '../../models/post.dart';
import '../../services/provider/AuthState.dart';
import '../../services/provider/PostsProvider.dart';

class AddEditCommentWidget extends StatefulWidget {
  final int postId;
  final Comment? comment; // Peut être null si on ajoute un nouveau commentaire

  const AddEditCommentWidget({Key? key, required this.postId, this.comment}) : super(key: key);

  @override
  _AddEditCommentWidgetState createState() => _AddEditCommentWidgetState();
}

class _AddEditCommentWidgetState extends State<AddEditCommentWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.comment?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Commentaire'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un commentaire';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitComment(context),
                child: Text(widget.comment == null ? 'Ajouter' : 'Éditer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitComment(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final authState = Provider.of<AuthState>(context, listen: false);
      final postsProvider = Provider.of<PostsProvider>(context, listen: false);
      final commentContent = _contentController.text;

      if (widget.comment == null) {
        postsProvider.addCommentToPost(widget.postId, commentContent, context, authState.authToken);
      } else {
        postsProvider.editCommentForPost(widget.postId, widget.comment!.id, commentContent, context, authState.authToken);
      }

      Navigator.of(context).pop(); // Fermer le dialogue après la soumission (comme en c#)
    }
  }
}
