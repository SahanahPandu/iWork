class Tyre {
  Tyre({
    required this.bungaTayar,
    required this.nutTayar,
    required this.tekananTayar,
    required this.remarks,
  });

  int bungaTayar;
  int nutTayar;
  int tekananTayar;
  String remarks;

  static Tyre fromJson(json) => Tyre(
        bungaTayar: json["bungaTayar"],
        nutTayar: json["nutTayar"],
        tekananTayar: json["tekananTayar"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "bungaTayar": bungaTayar,
        "nutTayar": nutTayar,
        "tekananTayar": tekananTayar,
        "remarks": remarks,
      };
}
