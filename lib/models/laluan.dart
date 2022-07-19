class Laluan {
  final int id;
  final String namaLaluan;
  final int idSubLaluan;
  final String subLaluan;
  final int idStatus;
  final String status;
  final int idKenderaan;
  final String noKenderaan;
  final int jumlahTaman;
  final int jumlahJalan;
  final int idJenisKutipan;
  final String jenisKutipan;

  Laluan(
      {required this.id,
      required this.namaLaluan,
      required this.idSubLaluan,
      required this.subLaluan,
      required this.idStatus,
      required this.status,
      required this.idKenderaan,
      required this.noKenderaan,
      required this.jumlahTaman,
      required this.jumlahJalan,
      required this.idJenisKutipan,
      required this.jenisKutipan});

  static Laluan fromJson(json) => Laluan(
        id: json['id'] ?? 0,
        namaLaluan: json['namaLaluan'] ?? "",
        idSubLaluan: json['idSubLaluan'] ?? 0,
        subLaluan: json['subLaluan'] ?? "",
        idStatus: json['idStatus'] ?? 0,
        status: json['status'] ?? "",
        idKenderaan: json['idKenderaan'] ?? 0,
        noKenderaan: json['noKenderaan'] ?? "",
        jumlahTaman: json['jumlahTaman'] ?? 0,
        jumlahJalan: json['jumlahJalan'] ?? 0,
        idJenisKutipan: json['idJenisKutipan'] ?? 0,
        jenisKutipan: json['jenisKutipan'] ?? "",
      );
}
