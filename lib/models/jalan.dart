class Jalan {
  final int id;
  final int idTaman;
  final String namaJalan;
  final String latLong;
  final int jumlahTong;

  const Jalan(
      {required this.id,
      required this.idTaman,
      required this.namaJalan,
      required this.latLong,
      required this.jumlahTong});

  static Jalan fromJson(json) => Jalan(
        id: json['id'] ?? 0,
        idTaman: json['idTaman'] ?? 0,
        namaJalan: json['namaJalan'] ?? "",
        latLong: json['latLong'] ?? "",
        jumlahTong: json['jumlahTong'] ?? 0,
      );
}
