import 'links/links.dart';
import 'vc_data/vc_list_detail.dart';

class VCData {
  VCData({
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

  int? currentPage;
  List<VCListDetail>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  factory VCData.fromJson(Map<String, dynamic> json) => VCData(
        currentPage: json["current_page"] ?? 0,
        data: json["data"] != null
            ? List<VCListDetail>.from(
                json["data"].map((x) => VCListDetail.fromJson(x)))
            : [],
        firstPageUrl: json["first_page_url"] ?? "",
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        lastPageUrl: json["last_page_url"] ?? "",
        links: json["links"] != null
            ? List<Link>.from(json["links"].map((x) => Link.fromJson(x)))
            : [],
        nextPageUrl: json["next_page_url"] ?? "",
        path: json["path"] ?? "",
        perPage: json["per_page"] ?? 0,
        prevPageUrl: json["prev_page_url"] ?? "",
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}
