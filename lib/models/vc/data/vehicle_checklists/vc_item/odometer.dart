class Odometer {
  Odometer({
    required this.bacaanOdo,
    required this.odoFungsi,
    required this.totalKm,
    required this.noAkbk,
  });

  String bacaanOdo;
  String odoFungsi;
  String totalKm;
  String noAkbk;

  static Odometer fromJson(json) => Odometer(
        bacaanOdo: json["bacaanOdo"],
        odoFungsi: json["odoFungsi"],
        totalKm: json["totalKM"],
        noAkbk: json["noAkbk"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "bacaanOdo": bacaanOdo,
        "odoFungsi": odoFungsi,
        "totalKM": totalKm,
        "noAkbk": noAkbk,
      };
}
