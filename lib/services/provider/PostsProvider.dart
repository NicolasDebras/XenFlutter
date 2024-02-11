import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../models/post.dart';
import '../PostsService.dart';
import '../response/PostsResponse.dart';
import 'api_service.dart';

class PostsProvider with ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> loadPosts(BuildContext context) async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final PostsService postsService = PostsService(apiService.dio);
    try {
      final PostsResponse response = await postsService.getAll();
      _posts = response.items;
      notifyListeners();
    } catch (e) {
      print("Erreur lors du chargement des posts: $e");
    }
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
