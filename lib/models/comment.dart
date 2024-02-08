import 'package:xenflutter/models/user.dart';

class Comment {
  final int? id;
  final String? createdAt;
  final int? postId;
  final String? content;
  final User? author; //j'ai renommé pour cohérence avec API...

  Comment({
    this.id,
    this.createdAt,
    this.postId,
    this.content,
    this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      createdAt: json['created_at'],
      postId: json['post_id'],
      content: json['content'],
      author: json['author'] != null ? User.fromJson(json['author']) : null,
    );
  }
}
