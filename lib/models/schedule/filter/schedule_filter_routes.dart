class ScheduleFilterRoutes {
  final String mainRoute;

  const ScheduleFilterRoutes({
    required this.mainRoute,
  });

  factory ScheduleFilterRoutes.fromJson(json) => ScheduleFilterRoutes(
        mainRoute: json['main_route'],
      );
}
