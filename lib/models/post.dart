class Post {

  final int? id;
  final int? createdAt;
  final String? content;
  final ImageModel? image;
  final User? user;
  final int? commentsCount;

  Post({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.image,
    required this.user,
    required this.commentsCount,
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
