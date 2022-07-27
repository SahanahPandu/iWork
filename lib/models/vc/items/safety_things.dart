class SafetyThings {
  SafetyThings({
    required this.penandaKecemasan,
    required this.pemadamApi,
    required this.kotakKecemasan,
    required this.remarks,
  });

  int penandaKecemasan;
  int pemadamApi;
  int kotakKecemasan;
  String remarks;

  static SafetyThings fromJson(json) => SafetyThings(
        penandaKecemasan: json["penandaKecemasan"],
        pemadamApi: json["pemadamApi"],
        kotakKecemasan: json["kotakKecemasan"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "penandaKecemasan": penandaKecemasan,
        "pemadamApi": pemadamApi,
        "kotakKecemasan": kotakKecemasan,
        "remarks": remarks,
      };
}
