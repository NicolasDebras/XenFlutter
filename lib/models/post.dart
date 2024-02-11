import 'comment.dart';
import 'user.dart';
import 'image.dart';

class Post {
  final int? id;
  final int? createdAt;
  late  String content;
  final Image? image;
  final User? user;
  final int? commentsCount;
  final List<Comment>? comments;

  Post({
    this.id,
    this.createdAt,
    required this.content,
    this.image,
    this.user,
    this.commentsCount,
    this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var commentsList = json['comments'] != null ? (json['comments'] as List).map((i) => Comment.fromJson(i)).toList() : null;

    return Post(
      id: json['id'] as int?,
      createdAt: json['created_at'] as int?,
      content: json['content'] as String,
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      user: json['author'] != null ? User.fromJson(json['author']) : null,
      commentsCount: json['comments_count'] as int?,
      comments: commentsList,
    );
  }
}
