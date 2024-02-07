import 'package:dio/dio.dart';
import 'package:xenflutter/services/response/user_posts_response.dart';

class PostsService {
  final Dio _dio;

  PostsService(this._dio);

  Future<UserPostsResponse> getAll() async {
    try {
      final response = await _dio.get('/post');
      return UserPostsResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de la récupération des posts: $e');
    }
  }

}
