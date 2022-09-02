class Taman {
  final int id;
  final int idSubLaluan;
  final String namaTaman;

  const Taman({
    required this.id,
    required this.idSubLaluan,
    required this.namaTaman,
  });

  static Taman fromJson(json) => Taman(
        id: json['id'],
        idSubLaluan: json['idSubLaluan'] ?? 0,
        namaTaman: json['namaTaman'],
      );
}
