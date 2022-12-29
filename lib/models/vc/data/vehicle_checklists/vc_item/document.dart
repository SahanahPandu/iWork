class Document {
  Document({
    required this.puspakomDisc,
    required this.cukaiJalan,
    required this.lesen,
    this.remarks,
  });

  String puspakomDisc;
  String cukaiJalan;
  String lesen;
  String? remarks;

  static Document fromJson(json) => Document(
        puspakomDisc: json["puspakomDisc"],
        cukaiJalan: json["cukaiJalan"],
        lesen: json["lesen"],
        remarks: json["remarks"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "puspakomDisc": puspakomDisc,
        "cukaiJalan": cukaiJalan,
        "lesen": lesen,
        "remarks": remarks,
      };
}
