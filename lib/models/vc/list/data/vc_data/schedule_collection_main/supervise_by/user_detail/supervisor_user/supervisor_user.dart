class SupervisorUser {
  SupervisorUser({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory SupervisorUser.fromJson(Map<String, dynamic> json) => SupervisorUser(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
