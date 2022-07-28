class Cleanliness {
  Cleanliness({
    required this.dalamKokpit,
    required this.luarBadanTrak,
    required this.remarks,
  });

  int dalamKokpit;
  int luarBadanTrak;
  String remarks;

  static Cleanliness fromJson(json) => Cleanliness(
        dalamKokpit: json["dalamKokpit"],
        luarBadanTrak: json["luarBadanTrak"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "dalamKokpit": dalamKokpit,
        "luarBadanTrak": luarBadanTrak,
        "remarks": remarks,
      };
}
