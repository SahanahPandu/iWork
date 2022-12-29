class BinLifterCleanliness {
  BinLifterCleanliness({
    required this.binDicuci,
    this.remarks,
  });

  String binDicuci;
  String? remarks;

  static BinLifterCleanliness fromJson(json) => BinLifterCleanliness(
        binDicuci: json["binDicuci"],
        remarks: json["remarks"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "binDicuci": binDicuci,
        "remarks": remarks,
      };
}
