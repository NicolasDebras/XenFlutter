class UserPostsRequest {
  final int userId;
  final int page;
  final int perPage;

  UserPostsRequest({
    required this.userId,
    required this.page,
    required this.perPage,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
    };
  }
}

