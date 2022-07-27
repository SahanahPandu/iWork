class Mampatan {
  Mampatan({
    required this.sistemHidraulik,
    required this.ptdPam,
    required this.allPenutup,
    required this.buangAir,
    required this.leachate,
    required this.remarks,
  });

  int sistemHidraulik;
  int ptdPam;
  int allPenutup;
  int buangAir;
  int leachate;
  String remarks;

  static Mampatan fromJson(json) => Mampatan(
        sistemHidraulik: json["sistemHidraulik"],
        ptdPam: json["ptd/pam"],
        allPenutup: json["allPenutup"],
        buangAir: json["buangAir"],
        leachate: json["leachate"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "sistemHidraulik": sistemHidraulik,
        "ptd/pam": ptdPam,
        "allPenutup": allPenutup,
        "buangAir": buangAir,
        "leachate": leachate,
        "remarks": remarks,
      };
}
