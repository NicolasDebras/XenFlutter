class UserResponse {
  final int? id;
  final String? createdAt;
  final String? name;

  UserResponse({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      createdAt: json['created_at'],
      name: json['name'],
    );
  }
}
