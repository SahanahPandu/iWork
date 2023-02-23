class VcStatus {
  VcStatus({
    required this.id,
    required this.code,
    required this.name,
    required this.category,
  });

  int id;
  String code;
  String name;
  String category;

  factory VcStatus.fromJson(json) => VcStatus(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "category": category,
      };
}
