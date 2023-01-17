class ScheduleFilterParks {
  final String mainRoute;
  final String subRoute;
  final int parkId;
  final String parkName;

  ScheduleFilterParks({
    required this.mainRoute,
    required this.subRoute,
    required this.parkId,
    required this.parkName,
  });

  factory ScheduleFilterParks.fromJson(json) => ScheduleFilterParks(
        mainRoute: json['main_route'],
        subRoute: json['sub_route'],
        parkId: json['park_id'],
        parkName: json['park_name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sub_route"] = subRoute;
    data["park_id"] = parkId;
    data["park_name"] = parkName;

    return data;
  }
}
