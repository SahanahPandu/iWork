class ScheduleFilterLocations {
  ScheduleFilterLocations({
    required this.id,
    required this.pdibId,
    required this.subRoute,
    required this.parkId,
    required this.parkName,
    required this.streetId,
    required this.streetName,
    required this.location,
    required this.premiseType,
  });

  final int id;
  final int pdibId;
  final String subRoute;
  final int parkId;
  final String parkName;
  final int streetId;
  final String streetName;
  final String location;
  final dynamic premiseType;

  factory ScheduleFilterLocations.fromJson(json) => ScheduleFilterLocations(
        id: json['id'],
        pdibId: json['pdib_id'],
        subRoute: json['sub_route'],
        parkId: json['park_id'],
        parkName: json['park_name'],
        streetId: json['street_id'],
        streetName: json['street_name'],
        location: json['location'],
        premiseType: PremiseType.fromJson(json['premise_type']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pdib_id'] = pdibId;
    data['sub_route'] = subRoute;
    data['park_id'] = parkId;
    data['park_name'] = parkName;
    data['street_id'] = streetId;
    data['street_name'] = streetName;
    data['location'] = location;
    data['premise_type'] = premiseType.toJson();

    return data;
  }
}

class PremiseType {
  final String code;
  final String name;

  const PremiseType({required this.code, required this.name});

  static PremiseType fromJson(json) => PremiseType(
        code: json['code'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
