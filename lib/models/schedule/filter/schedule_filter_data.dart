//import files
import 'package:eswm/models/schedule/filter/schedule_filter_locations.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_parks.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_streets.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_sub_routes.dart';

class ScheduleFilterData {
  final dynamic subRoutes;
  final dynamic parks;
  final dynamic streets;
  final dynamic locations;

  ScheduleFilterData({
    required this.subRoutes,
    required this.parks,
    required this.streets,
    required this.locations,
  });

  factory ScheduleFilterData.fromJson(json) => ScheduleFilterData(
        subRoutes: json['sub_routes']
            .map<ScheduleFilterSubRoutes>(ScheduleFilterSubRoutes.fromJson)
            .toList(),
        parks: json['parks']
            .map<ScheduleFilterParks>(ScheduleFilterParks.fromJson)
            .toList(),
        streets: json['streets']
            .map<ScheduleFilterStreets>(ScheduleFilterStreets.fromJson)
            .toList(),
        locations: json['locations']
            .map<ScheduleFilterLocations>(ScheduleFilterLocations.fromJson)
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_routes'] = subRoutes;
    data['parks'] = parks;
    data['streets'] = streets;
    data['locations'] = locations;

    return data;
  }
}
