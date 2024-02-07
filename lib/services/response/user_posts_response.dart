import '../../models/post.dart';

class UserPostsResponse {
  final int? itemsReceived;
  final int? curPage;
  final int? nextPage;
  final int? prevPage;
  final int? offset;
  final int? itemsTotal;
  final int? pageTotal;
  final List<Post>? items;

  UserPostsResponse({
    required this.itemsReceived,
    required this.curPage,
    required this.nextPage,
    required this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory UserPostsResponse.fromJson(Map<String, dynamic> json) {
    return UserPostsResponse(
      itemsReceived: json['itemsReceived'],
      curPage: json['curPage'],
      nextPage: json['nextPage'],
      prevPage: json['prevPage'],
      offset: json['offset'],
      itemsTotal: json['itemsTotal'],
      pageTotal: json['pageTotal'],
      items: (json['items'] as List<dynamic>)
          .map((post) => Post.fromJson(post))
          .toList(),
    );
  }
}
