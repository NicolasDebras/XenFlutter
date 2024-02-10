import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../../services/PostsService.dart';
import '../../services/provider/AuthState.dart';
import '../../services/provider/api_service.dart';

class AddEditPostWidget extends StatefulWidget {
  final Post? post;

  const AddEditPostWidget({Key? key, this.post}) : super(key: key);

  @override
  _AddEditPostWidgetState createState() => _AddEditPostWidgetState();
}

class _AddEditPostWidgetState extends State<AddEditPostWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.post?.content ?? '');
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _addOrEditPost() async {
    if (_formKey.currentState!.validate()) {
      final content = _contentController.text;
      try {
        final apiService = Provider.of<ApiService>(context, listen: false);
        final PostsService postsService = PostsService(apiService.dio);
        final authState = Provider.of<AuthState>(context, listen: false);

        if (widget.post == null) {
          await postsService.addPost(content: content, token: authState.authToken);
        } else {
          await postsService.editPost(postId: widget.post!.id!, content: content, token: authState.authToken);
        }
        Navigator.of(context).pop();
      } catch (e) {
        // Gérer l'erreur ici
        print("Erreur lors de l'ajout/édition du post: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _contentController,
            decoration: InputDecoration(labelText: 'Contenu'),
            maxLines: null,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer du contenu';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _addOrEditPost,
            child: Text(widget.post == null ? 'Ajouter' : 'Éditer'),
          ),
        ],
      ),
    );
  }
}
