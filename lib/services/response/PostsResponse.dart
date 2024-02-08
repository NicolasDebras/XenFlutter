import '../../models/post.dart';

class PostsResponse {
  final int itemsReceived;
  final int curPage;
  final int? nextPage;
  final int? prevPage;
  final int offset;
  final int itemsTotal;
  final int pageTotal;
  final List<Post> items;

  PostsResponse({
    required this.itemsReceived,
    required this.curPage,
    this.nextPage,
    this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    var itemsList = (json['items'] as List).map((i) => Post.fromJson(i)).toList();

    return PostsResponse(
      itemsReceived: json['itemsReceived'],
      curPage: json['curPage'],
      nextPage: json['nextPage'],
      prevPage: json['prevPage'],
      offset: json['offset'],
      itemsTotal: json['itemsTotal'],
      pageTotal: json['pageTotal'],
      items: itemsList,
    );
  }
}
