class StatusCode {
  StatusCode({
    required this.code,
    required this.name,
  });

  String code;
  String name;

  factory StatusCode.fromJson(Map<String, dynamic> json) => StatusCode(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
