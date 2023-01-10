import 'package:json_annotation/json_annotation.dart';
import '../report_details/report_details_info.dart';

class ReportPaging {
  final int? currentPage;

  @JsonKey(defaultValue: [])
  final dynamic data;

  final String? firstPageUrl;

  @JsonKey(defaultValue: null)
  final int? from;

  final int? lastPage;
  final String? lastPageUrl;

  @JsonKey(defaultValue: null)
  final List<Links>? links;

  @JsonKey(defaultValue: null)
  final String? nextPageUrl;

  final String? path;
  final int? perPage;

  @JsonKey(defaultValue: null)
  final String? prevPageUrl;

  @JsonKey(defaultValue: null)
  final int? to;

  final int? total;

  const ReportPaging({
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

  factory ReportPaging.fromJson(json) => ReportPaging(
        currentPage: json['current_page'],
        data: json['data'] != []
            ? json['data']
                .map<ReportDetailsInfo>(ReportDetailsInfo.fromJson)
                .toList()
            : [],
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
        links: json['links'] != null
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

  @JsonKey(defaultValue: null)
  final String? label;

  @JsonKey(defaultValue: false)
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
