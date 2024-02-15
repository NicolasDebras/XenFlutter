import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/design/Post/postUx.dart';
import 'package:xenflutter/services/PostsService.dart';

import '../../models/post.dart';
import '../../services/provider/PostsProvider.dart';
import '../../services/provider/api_service.dart';

class Postlist extends StatefulWidget {
  @override
  _PostlistState createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    await Provider.of<PostsProvider>(context, listen: false).loadPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsProvider>(
      builder: (context, postsProvider, child) {
        return RefreshIndicator(
          onRefresh: _loadPosts,
          child: ListView.builder(
            itemCount: postsProvider.posts.isNotEmpty ? postsProvider.posts.length : 0,
            itemBuilder: (context, index) {
              return PostUx(postsProvider.posts[index]);
            },
            padding: EdgeInsets.zero,
            shrinkWrap: true,
          ),
        );
      },
    );
  }
}
