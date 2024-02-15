import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:xenflutter/models/comment.dart';

import '../../models/post.dart';
import '../CommentsService.dart';
import '../PostsService.dart';
import '../request/CommentRequest.dart';
import '../response/CommentResponse.dart';
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

  void loadCommentsForPost(Post post, BuildContext context) async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final postsService = PostsService(apiService.dio);

    try {
      final comments = await postsService.getById(post.id!);
      final postIndex = _posts.indexWhere((p) => p.id == post.id);
      if (postIndex != -1) {
        _posts[postIndex].comments = comments.comments;
        notifyListeners();
      }
    } catch (e) {
      print("Erreur lors du chargement des commentaires: $e");
    }

  }

  Future<void> addCommentToPost(int postId, String content, BuildContext context, String token) async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final commentsService = CommentsService(apiService.dio);

    try {
      CommentRequest request = CommentRequest(content: content, postId: postId);
      CommentResponse response = await commentsService.addComment(request, token);

      // Mettre à jour le post avec le nouveau commentaire
      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        _posts[postIndex].comments?.add(response as Comment);
        _posts[postIndex].commentsCount = _posts[postIndex].commentsCount! + 1;
        notifyListeners();
      }
    } catch (e) {
      print("Erreur lors de l'ajout d'un commentaire: $e");
    }
  }

  Future<void> editCommentForPost(int postId, int commentId, String content, BuildContext context, String token) async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final commentsService = CommentsService(apiService.dio);

    try {
      CommentRequest request = CommentRequest(content: content, postId: postId);
      await commentsService.editComment(commentId, request, token);

      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        final commentIndex = _posts[postIndex].comments?.indexWhere((c) => c.id == commentId) ?? -1;
        if (commentIndex != -1) {
          _posts[postIndex].comments![commentIndex].content = content;
          notifyListeners();
        }
      }
    } catch (e) {
      print("Erreur lors de la modification d'un commentaire: $e");
    }
  }

  Future<void> deleteCommentFromPost(int postId, int commentId, BuildContext context, String token) async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final commentsService = CommentsService(apiService.dio);

    try {
      await commentsService.deleteComment(commentId, token);

      // Supprimer le commentaire du post
      final postIndex = _posts.indexWhere((p) => p.id == postId);
      if (postIndex != -1) {
        _posts[postIndex].comments?.removeWhere((c) => c.id == commentId);
        _posts[postIndex].commentsCount = _posts[postIndex].commentsCount! - 1;
        notifyListeners();
      }
    } catch (e) {
      print("Erreur lors de la suppression d'un commentaire: $e");
    }
  }



}
