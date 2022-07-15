class Cuti {
  final int id;
  final int idJenisCuti;
  final String jenisCuti;
  final int idStatus;
  final String status;
  final String tarikhMula;
  final String tarikhTamat;
  final String lampiran;
  final String catatan;

  const Cuti(
      {required this.id,
      required this.idJenisCuti,
      required this.jenisCuti,
      required this.idStatus,
      required this.status,
      required this.tarikhMula,
      required this.tarikhTamat,
      required this.lampiran,
      required this.catatan});

  static Cuti fromJson(json) => Cuti(
      id: json['id'],
      idJenisCuti: json['idJenisCuti'],
      jenisCuti: json['jenisCuti'],
      idStatus: json['idStatus'],
      status: json['status'],
      tarikhMula: json['tarikhMula'],
      tarikhTamat: json['tarikhTamat'],
      lampiran: json['lampiran'],
      catatan: json['catatan'] ?? "");
}
