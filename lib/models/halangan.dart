class Halangan {
  final int id;
  final String namaHalangan;

  const Halangan({required this.id, required this.namaHalangan});

  static Halangan fromJson(json) => Halangan(
        id: json['id'] ?? 0,
        namaHalangan: json['namaHalangan'] ?? "",
      );
}
