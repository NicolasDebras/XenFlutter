import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../PostsService.dart';
import 'api_service.dart';

class PostsProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void loadPosts(BuildContext context) async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final PostsService postsService = PostsService(apiService.dio);
    _posts = postsService.getAll() as List<Post>;
    notifyListeners();
  }

  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  void editPost(String content, int postId) {
    int postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      _posts[postIndex].content = content;
    }
    notifyListeners();
  }

  void deletePost(int postId) {
    _posts.removeWhere((post) => post.id == postId);
    notifyListeners();
  }
}
