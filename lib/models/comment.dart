import 'package:xenflutter/models/user.dart';

class Comment {
  final int? id;
  final String? createdAt;
  final int? postId;
  final String? content;
  final User? user;

  Comment({
    required this.id,
    required this.createdAt,
    required this.postId,
    required this.content,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      createdAt: json['created_at'],
      postId: json['post_id'],
      content: json['content'],
      user: User.fromJson(json['user']),
    );
  }
  static Comment addComment(Map<String, dynamic> json) {
    return Comment.fromJson(json);
  }
  static Comment editComment(Map<String, dynamic> json) {
    return Comment.fromJson(json);
  }

  static Comment deleteComment(Map<String, dynamic> json) {
    return Comment.fromJson(json);
  }
}
