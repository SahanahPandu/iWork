//import files
import 'package:eswm/models/schedule/filter/schedule_filter_locations.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_parks.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_streets.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_sub_routes.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_main_routes.dart';

class ScheduleFilterData {
  final dynamic mainRoute;
  final dynamic subRoutes;
  final dynamic parks;
  final dynamic streets;
  final dynamic locations;

  ScheduleFilterData({
    required this.mainRoute,
    required this.subRoutes,
    required this.parks,
    required this.streets,
    required this.locations,
  });

  factory ScheduleFilterData.fromJson(json) => ScheduleFilterData(
        mainRoute: (json['main_route'] != null || json['main_route'] != [])
            ? json['main_route']
                .map<ScheduleFilterMainRoutes>(
                    ScheduleFilterMainRoutes.fromJson)
                .toList()
            : null,
        subRoutes: (json['sub_routes'] != null || json['sub_routes'] != [])
            ? json['sub_routes']
                .map<ScheduleFilterSubRoutes>(ScheduleFilterSubRoutes.fromJson)
                .toList()
            : null,
        parks: (json['parks'] != null || json['parks'] != [])
            ? json['parks']
                .map<ScheduleFilterParks>(ScheduleFilterParks.fromJson)
                .toList()
            : null,
        streets: (json['streets'] != null || json['streets'] != [])
            ? json['streets']
                .map<ScheduleFilterStreets>(ScheduleFilterStreets.fromJson)
                .toList()
            : null,
        locations: (json['locations'] != null || json['locations'] != [])
            ? json['locations']
                .map<ScheduleFilterLocations>(ScheduleFilterLocations.fromJson)
                .toList()
            : null,
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
