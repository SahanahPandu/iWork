class Taman {
  final int id;
  final String namaTaman;

  const Taman({required this.id, required this.namaTaman});

  static Taman fromJson(json) =>
      Taman(id: json['id'], namaTaman: json['namaTaman']);
}
