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
  final String pemohon;
  final String approvalBy;
  final String maklumbalasSV;

  const Cuti({
    required this.id,
    required this.idJenisCuti,
    required this.jenisCuti,
    required this.idStatus,
    required this.status,
    required this.tarikhMula,
    required this.tarikhTamat,
    required this.lampiran,
    required this.catatan,
    required this.pemohon,
    required this.approvalBy,
    required this.maklumbalasSV,
  });

  static Cuti fromJson(json) => Cuti(
        id: json['id'] ?? 0,
        idJenisCuti: json['idJenisCuti'] ?? 0,
        jenisCuti: json['jenisCuti'] ?? "",
        idStatus: json['idStatus'] ?? 0,
        status: json['status'] ?? "",
        tarikhMula: json['tarikhMula'] ?? "",
        tarikhTamat: json['tarikhTamat'] ?? "",
        lampiran: json['lampiran'] ?? "",
        catatan: json['catatan'] ?? "",
        pemohon: json['pemohon'] ?? "",
        approvalBy: json['approvalBy'] ?? "",
        maklumbalasSV: json['maklumbalasSV'] ?? "",
      );
}
