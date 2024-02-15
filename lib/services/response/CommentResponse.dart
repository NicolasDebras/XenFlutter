import '../../models/user.dart';

class CommentResponse {
  final int? id;
  final String? createdAt;
  final String? content;
  final User? user;

  CommentResponse({
    this.id,
    this.createdAt,
    this.content,
    this.user,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      id: json['id'],
      createdAt: json['created_at']?.toString(),
      content: json['content'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}