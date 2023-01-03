import 'package:eswm/models/schedule/schedule_details.dart';
import 'package:json_annotation/json_annotation.dart';

class ScheduleDataDarawer {
  @JsonKey(defaultValue: null)
  final int? currentPage;

  @JsonKey(defaultValue: [])
  final dynamic data;

  @JsonKey(defaultValue: null)
  final String? firstPageUrl;

  @JsonKey(defaultValue: null)
  final int? from;

  @JsonKey(defaultValue: null)
  final int? lastPage;

  @JsonKey(defaultValue: null)
  final String? lastPageUrl;

  @JsonKey(defaultValue: [])
  final List<Links?>? links;

  @JsonKey(defaultValue: null)
  final String? nextPageUrl;

  @JsonKey(defaultValue: null)
  final String? path;

  @JsonKey(defaultValue: null)
  final int? perPage;

  @JsonKey(defaultValue: null)
  final String? prevPageUrl;

  @JsonKey(defaultValue: null)
  final int? to;

  @JsonKey(defaultValue: null)
  final int? total;

  const ScheduleDataDarawer({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory ScheduleDataDarawer.fromJson(json) => ScheduleDataDarawer(
        currentPage: json['current_page'],
        data: json['data'] != []
            ? json['data']
                .map<ScheduleDetails>(ScheduleDetails.fromJson)
                .toList()
            : [],
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
        links: json['links'] != []
            ? json['links'].map<Links>(Links.fromJson).toList()
            : [],
        nextPageUrl: json['next_page_url'],
        path: json['path'],
        perPage: json['per_page'],
        prevPageUrl: json['prev_page_url'],
        to: json['to'],
        total: json['total'],
      );
}

class Links {
  @JsonKey(defaultValue: null)
  final String? url;

  @JsonKey(defaultValue: "")
  final String? label;

  final bool active;

  const Links({
    this.url,
    this.label,
    required this.active,
  });

  factory Links.fromJson(json) => Links(
        url: json['url'],
        label: json['label'],
        active: json['active'],
      );
}
