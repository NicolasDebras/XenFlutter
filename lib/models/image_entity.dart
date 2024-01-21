class ImageEntity {
  final String? path;
  final String? name;
  final String? type;
  final int? size;
  final String? mime;
  final String? url;

  ImageEntity({
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    required this.mime,
    required this.url,
  });

  String? get getPath => path;
  String? get getName => name;
  String? get getType => type;
  int? get getSize => size;
  String? get getMime => mime;
  String? get getUrl => url;

  factory ImageEntity.fromJson(Map<String, dynamic> json) {
    return ImageEntity(
      path: json['path'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      mime: json['mime'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'name': name,
      'type': type,
      'size': size,
      'mime': mime,
      'url': url,
    };
  }

  ImageEntity toEntity() {
    return ImageEntity(
      path: path,
      name: name,
      type: type,
      size: size,
      mime: mime,
      url: url,
    );
  }

  List<Object?> get props => [path, name, type, size, mime, url];
}
