class ScheduleFilterStreets {
  ScheduleFilterStreets({
    required this.subRoute,
    required this.parkId,
    required this.parkName,
    required this.streetId,
    required this.streetName,
  });

  final String subRoute;
  final int parkId;
  final String parkName;
  final int streetId;
  final String streetName;

  factory ScheduleFilterStreets.fromJson(json) => ScheduleFilterStreets(
        subRoute: json['sub_route'],
        parkId: json['park_id'],
        parkName: json['park_name'],
        streetId: json['street_id'],
        streetName: json['street_name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sub_route"] = subRoute;
    data["park_id"] = parkId;
    data["park_name"] = parkName;
    data["street_id"] = streetId;
    data["street_name"] = streetName;

    return data;
  }
}
