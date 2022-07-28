class Laluan {
  final int id;
  final String namaLaluan;
  final int jumSubLaluan;
  final int idStatus;
  final String status;
  final int idKenderaan;
  final String noKenderaan;
  final int jumlahTaman;
  final int jumlahJalan;
  final int idJenisKutipan;
  final String jenisKutipan;
  final String mulaKerja;
  final String tamatKerja;

  Laluan(
      {required this.id,
      required this.namaLaluan,
      required this.jumSubLaluan,
      required this.idStatus,
      required this.status,
      required this.idKenderaan,
      required this.noKenderaan,
      required this.jumlahTaman,
      required this.jumlahJalan,
      required this.idJenisKutipan,
      required this.jenisKutipan,
      required this.mulaKerja,
      required this.tamatKerja});

  static Laluan fromJson(json) => Laluan(
        id: json['id'] ?? 0,
        namaLaluan: json['namaLaluan'] ?? "",
        jumSubLaluan: json['jumSubLaluan'] ?? 0,
        idStatus: json['idStatus'] ?? 0,
        status: json['status'] ?? "",
        idKenderaan: json['idKenderaan'] ?? 0,
        noKenderaan: json['noKenderaan'] ?? "",
        jumlahTaman: json['jumlahTaman'] ?? 0,
        jumlahJalan: json['jumlahJalan'] ?? 0,
        idJenisKutipan: json['idJenisKutipan'] ?? 0,
        jenisKutipan: json['jenisKutipan'] ?? "",
        mulaKerja: json['mulaKerja'] ?? "",
        tamatKerja: json['tamatKerja'] ?? "",
      );
}
