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


}
