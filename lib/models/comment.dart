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
  static CrudComment addComment(Map<String, dynamic> json) {
    return CrudComment.fromJson(json);
  }
  static CrudComment editComment(Map<String, dynamic> json) {
    return CrudComment.fromJson(json);
  }

  static CrudComment deleteComment(Map<String, dynamic> json) {
    return CrudComment.fromJson(json);
  }
}
