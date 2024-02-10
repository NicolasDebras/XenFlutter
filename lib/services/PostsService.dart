import 'dart:io';
import 'package:dio/dio.dart';
import 'package:xenflutter/services/response/PostsResponse.dart';

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

  Future<void> addPost({required String content, File? image, required String token}) async {
    FormData formData = FormData.fromMap({
      'content': content,
    });
    if (image != null) {
      formData.files.add(MapEntry(
        'base_64_image',
        await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
      ));
    }
    try {
      await _dio.post(
        '/post',
        data: formData,
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
    } catch (e) {
      print('Erreur lors de l\'ajout d\'un post: $e');
      throw Exception('Erreur lors de l\'ajout d\'un post');
    }
  }

}
