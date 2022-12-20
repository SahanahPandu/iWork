class ScheduleFilterParks {
  ScheduleFilterParks({
    required this.subRoute,
    required this.parkId,
    required this.parkName,
  });

  final String subRoute;
  final int parkId;
  final String parkName;

  factory ScheduleFilterParks.fromJson(json) => ScheduleFilterParks(
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
