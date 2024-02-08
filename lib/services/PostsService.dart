import 'package:dio/dio.dart';
import 'package:xenflutter/services/response/PostsResponse.dart';
import 'package:xenflutter/services/response/user_posts_response.dart';

class PostsService {
  final Dio _dio;

  PostsService(this._dio);

  Future<PostsResponse> getAll() async {
    try {
      final response = await _dio.get('/post');
      PostsResponse test =  PostsResponse.fromJson(response.data);
      return test;
    } catch (e) {
      print('erreur');
      throw Exception('Erreur lors de la récupération des posts: $e');
    }
  }

}
