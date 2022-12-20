class ObstacleTypes {
  final int id;
  final String name;
  final dynamic code;
  final dynamic category;
  final int? isAKBK;

  ObstacleTypes({
    required this.id,
    required this.name,
    this.code,
    this.category,
    this.isAKBK,
  });

  factory ObstacleTypes.fromJson(json) => ObstacleTypes(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        category: json['category'],
        isAKBK: json['is_akbk'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "category": category,
        "isAKBK": isAKBK,
      };
}
