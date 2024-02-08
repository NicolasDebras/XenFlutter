import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/design/Post/postUx.dart';
import 'package:xenflutter/services/PostsService.dart';

import '../../models/post.dart';
import '../../services/api_service.dart';

// Liste des posts
class Postlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final PostsService postsService = PostsService(apiService.dio);

    return FutureBuilder(
      future: postsService.getAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.data == null) {
          return Center(child: Text("Aucun post à afficher."));
        } else {
          final List<Post> posts = snapshot.data.items;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostUx(posts[index]);
            },
          );
        }
      },
    );
  }
}