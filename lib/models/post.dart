import 'comment.dart';
import 'user.dart';
import 'image.dart';

class Post {

  final int? id;
  final int? createdAt;
  final String content;
  final Image? image;
  final User? user;
  final int? commentsCount;
  final List<Comment>? comments;
  final int? itemsReceived;
  final int? curPage;
  final int? nextPage;
  final int? prevPage;
  final int? offset;
  final int? itemsTotal;
  final int? pageTotal;
  final List<Post> items;

  Post({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.image,
    required this.user,
    required this.commentsCount,
    required this.comments,
    required this.itemsReceived,
    required this.curPage,
    required this.nextPage,
    required this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as int?,
      content: json['content'] as String,
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      commentsCount: json['commentsCount'] as int?,
      comments: json['comments'] != null ? (json['comments'] as List).map((i) => Comment.fromJson(i)).toList() : null,
      itemsReceived: json['itemsReceived'] as int?,
      curPage: json['curPage'] as int?,
      nextPage: json['nextPage'] as int?,
      prevPage: json['prevPage'] as int?,
      offset: json['offset'] as int?,
      itemsTotal: json['itemsTotal'] as int?,
      pageTotal: json['pageTotal'] as int?,
      items: (json['items'] as List).map((i) => Post.fromJson(i)).toList(),
    );
  }
}
