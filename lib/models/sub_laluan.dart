class SubLaluan {
  final int id;
  final int namaSubLaluan;

  const SubLaluan({
    required this.id,
    required this.namaSubLaluan,
  });

  static SubLaluan fromJson(json) =>
      SubLaluan(id: json['id'], namaSubLaluan: json['namaSubLaluan']);
}
