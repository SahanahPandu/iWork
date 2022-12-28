class Light {
  Light({
    required this.lampuUtama,
    required this.lampuHenti,
    required this.lampuIsyarat,
    required this.lampuKecemasan,
    required this.lampuBeacon,
    required this.lampuPlet,
    this.remarks,
  });

  String lampuUtama;
  String lampuHenti;
  String lampuIsyarat;
  String lampuKecemasan;
  String lampuBeacon;
  String lampuPlet;
  String? remarks;

  static Light fromJson(json) => Light(
        lampuUtama: json["lampuUtama"],
        lampuHenti: json["lampuHenti"],
        lampuIsyarat: json["lampuIsyarat"],
        lampuKecemasan: json["lampuKecemasan"],
        lampuBeacon: json["lampuBeacon"],
        lampuPlet: json["lampuPlet"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "lampuUtama": lampuUtama,
        "lampuHenti": lampuHenti,
        "lampuIsyarat": lampuIsyarat,
        "lampuKecemasan": lampuKecemasan,
        "lampuBeacon": lampuBeacon,
        "lampuPlet": lampuPlet,
        "remarks": remarks,
      };
}
