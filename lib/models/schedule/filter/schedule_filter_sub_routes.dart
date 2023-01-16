import 'package:json_annotation/json_annotation.dart';

class ScheduleFilterSubRoutes {
  @JsonKey(defaultValue: null)
  final String? mainRoute;

  @JsonKey(defaultValue: null)
  final String? subRoute;

  const ScheduleFilterSubRoutes({
    this.mainRoute,
    this.subRoute,
  });

  factory ScheduleFilterSubRoutes.fromJson(json) => ScheduleFilterSubRoutes(
        mainRoute: json['main_route'],
        subRoute: json['sub_route'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_route'] = subRoute;

    return data;
  }
}
