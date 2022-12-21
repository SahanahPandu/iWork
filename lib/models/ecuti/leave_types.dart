class LeaveTypes {
  final int id;
  final String name;

  const LeaveTypes({
    required this.id,
    required this.name,
  });

  factory LeaveTypes.fromJson(json) => LeaveTypes(
        id: json['id'],
        name: json['name'],
      );
}
