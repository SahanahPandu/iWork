class ScheduleFilterStatus {
  final int id;
  final String code;
  final String name;
  final String category;

  const ScheduleFilterStatus({
    required this.id,
    required this.code,
    required this.name,
    required this.category,
  });

  factory ScheduleFilterStatus.fromJson(json) => ScheduleFilterStatus(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        category: json['category'],
      );
}
