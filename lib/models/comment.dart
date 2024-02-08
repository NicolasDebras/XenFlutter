import 'package:xenflutter/models/user.dart';

class Comment {
  final int? id;
  final String? createdAt;
  final int? postId;
  final String? content;
  final User? author; //j'ai renommé pour cohérence avec API...

  Comment({
    required this.id,
    required this.createdAt,
    required this.postId,
    required this.content,
    required this.author,
  });


  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      createdAt: json['created_at'] as String,
      postId: json['post_id'] as int,
      content: json['content'] as String,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
    );
  }
}
