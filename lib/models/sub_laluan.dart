class SubLaluan {
  final int id;
  final String namaSubLaluan;

  const SubLaluan({
    required this.id,
    required this.namaSubLaluan,
  });

  static SubLaluan fromJson(json) =>
      SubLaluan(id: json['id'], namaSubLaluan: json['namaSubLaluan']);
}
