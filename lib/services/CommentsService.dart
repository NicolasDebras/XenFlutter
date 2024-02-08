import 'package:dio/dio.dart';
import 'package:xenflutter/models/comment.dart';
import 'package:xenflutter/services/request/CommentRequest.dart';
import 'package:xenflutter/services/response/CommentResponse.dart';

class CommentsService {
  final Dio _dio;

  CommentsService(this._dio);

  //ajout d'un commentaire
  Future<CommentResponse> addComment(CommentRequest request) async {
    try {
      final response = await _dio.post('/comments', data: request.toJson());
      return CommentResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout du commentaire: $e');
    }
  }

  //modification d'un commentaire
  Future<CommentResponse> editComment(int commentId, CommentRequest request) async {
    try {
      final response = await _dio.patch('/comments/$commentId', data: request.toJson());
      return CommentResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Erreur lors de la modification du commentaire: $e');
    }
  }

  //suppression d'un commentaire
  Future<void> deleteComment(int commentId) async {
    try {
      await _dio.delete('/comments/$commentId');
    } catch (e) {
      throw Exception('Erreur lors de la suppression du commentaire: $e');
    }
  }
}


