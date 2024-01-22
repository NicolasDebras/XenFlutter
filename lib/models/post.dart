class Post {

  final int? id;
  final int? createdAt;
  final String? content;
  final ImageModel? image;
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
  });
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
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      image: ImageModel.fromJson(json['image']),
      user: User.fromJson(json['user']),
      commentsCount: json['comments_count'],
    );
  }
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
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
  static List<Post> fromQueryAllPostsResponse(Map<String, dynamic> json) {
    return (json['items'] as List<dynamic>?)
        ?.map((post) => Post.fromJsonMap(post))
        .toList() ?? [];
  }
  static Post fromJsonMap(Map<String, dynamic> json) {
    return Post(
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
  static Post editPost(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }
  static Post deletePost(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'created_at': this.createdAt,
      'content': this.content,
      'image': this.image?.toJson(),
      'user': this.user?.toJson(),
      'comments_count': this.commentsCount,
    };
  }

  PostEntity toEntity() {
    return PostEntity(
      id: this.id,
      createdAt: this.createdAt,
      content: this.content,
      image: this.image?.toEntity(),
      user: this.user?.toEntity(),
      commentsCount: this.commentsCount,
    );
  }

}
