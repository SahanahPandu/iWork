class StatusCode {
  StatusCode({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory StatusCode.fromJson(Map<String, dynamic> json) => StatusCode(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
