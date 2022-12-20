class ScheduleFilterSubRoutes {
  ScheduleFilterSubRoutes({
    required this.subRoute,
  });

  final String subRoute;

  factory ScheduleFilterSubRoutes.fromJson(json) => ScheduleFilterSubRoutes(
        subRoute: json['sub_route'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_route'] = subRoute;

    return data;
  }
}
