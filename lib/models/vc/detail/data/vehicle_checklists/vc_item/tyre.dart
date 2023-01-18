class Tyre {
  Tyre({
    required this.bungaTayar,
    required this.nutTayar,
    required this.tekananTayar,
    this.remarks,
  });

  String bungaTayar;
  String nutTayar;
  String tekananTayar;
  String? remarks;

  static Tyre fromJson(json) => Tyre(
        bungaTayar: json["bungaTayar"],
        nutTayar: json["nutTayar"],
        tekananTayar: json["tekananTayar"],
        remarks: json["remarks"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "bungaTayar": bungaTayar,
        "nutTayar": nutTayar,
        "tekananTayar": tekananTayar,
        "remarks": remarks,
      };
}
