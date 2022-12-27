import 'package:eswm/models/attendance_log/attendance_log_details.dart';

class AttendanceLogPaging {
  final int currentPage;
  final List<AttendanceLogDetails?> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Links?>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  const AttendanceLogPaging({
    required this.currentPage,
    required this.data,
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

  factory AttendanceLogPaging.fromJson(json) => AttendanceLogPaging(
        currentPage: json['current_page'],
        data: json['data'] != null
            ? json['data']
                .map<AttendanceLogDetails>(AttendanceLogDetails.fromJson)
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
  final String? url;
  final String? label;
  final bool? active;

  const Links({
    this.url,
    this.label,
    this.active,
  });

  factory Links.fromJson(json) => Links(
        url: json['url'],
        label: json['label'],
        active: json['active'],
      );
}
