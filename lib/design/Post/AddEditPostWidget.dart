import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../../services/PostsService.dart';
import '../../services/provider/AuthState.dart';
import '../../services/provider/PostsProvider.dart';
import '../../services/provider/api_service.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class AddEditPostWidget extends StatefulWidget {
  final Post? post;

  const AddEditPostWidget({Key? key, this.post}) : super(key: key);

  @override
  _AddEditPostWidgetState createState() => _AddEditPostWidgetState();
}

class _AddEditPostWidgetState extends State<AddEditPostWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;
  File? _image;

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addOrEditPost() async {
    if (_formKey.currentState!.validate()) {
      final content = _contentController.text;
      try {
        final apiService = Provider.of<ApiService>(context, listen: false);
        final PostsService postsService = PostsService(apiService.dio);
        final authState = Provider.of<AuthState>(context, listen: false);
        final postsProvider = Provider.of<PostsProvider>(context, listen: false);

        Post post;
        if (widget.post == null) {
          post = await postsService.addPost(content: content, image: _image, token: authState.authToken);
          postsProvider.addPost(post);
        } else {
          await postsService.editPost(postId: widget.post!.id!, content: content, image: _image, token: authState.authToken);
          postsProvider.editPost(content, widget.post!.id!);
        }
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de l\'ajout/édition du post: $e')));
      }
    }
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
              const SizedBox(height: 10),
              _image != null ? Image.file(_image!) : Container(),
              TextButton(
                onPressed: _pickImage,
                child: Text('Choisir une image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addOrEditPost,
                child: Text(widget.post == null ? 'Ajouter' : 'Éditer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
