class ScheduleFilterMainRoutes {
  final String mainRouteName;

  const ScheduleFilterMainRoutes({
    required this.mainRouteName,
  });

  factory ScheduleFilterMainRoutes.fromJson(json) =>
      ScheduleFilterMainRoutes(mainRouteName: json['main_route']);
}
