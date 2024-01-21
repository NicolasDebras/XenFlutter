class CrudPost {
  final int? id;
  final int? createdAt;
  final String? content;
  final ImageModel? image;
  final User? user;
  final List<Comment>? comments;
  final int? itemsReceived;
  final int? curPage;
  final int? nextPage;
  final int? prevPage;
  final int? offset;
  final int? itemsTotal;
  final int? pageTotal;
  final List<CrudPost> items;

  CrudPost({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.image,
    required this.user,
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

  static CrudPost editPost(Map<String, dynamic> json) {
    return CrudPost.fromJson(json);
  }

  static CrudPost fromJsonMap(Map<String, dynamic> json) {
    return CrudPost(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      image: ImageModel.fromJson(json['image']),
      user: User.fromJson(json['user']),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }

  static List<CrudPost> fromQueryAllPostsResponse(Map<String, dynamic> json) {
    return (json['items'] as List<dynamic>?)
        ?.map((post) => CrudPost.fromJsonMap(post))
        .toList() ?? [];
  }

  static CrudPost deletePost(Map<String, dynamic> json) {
    return CrudPost.fromJson(json);
  }

  factory CrudPost.fromJson(Map<String, dynamic> json) {
    return CrudPost(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      image: ImageModel.fromJson(json['image']),
      user: User.fromJson(json['user']),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }

  List<Object?> get props => [id, createdAt, content, image, user];
}
