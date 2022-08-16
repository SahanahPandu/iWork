class Notifikasi {
  final int id;
  final int notiTypeId;
  final String notiType;
  final int descId;
  final String description;

  const Notifikasi(
      {required this.id,
      required this.notiTypeId,
      required this.notiType,
      required this.descId,
      required this.description});

  static Notifikasi fromJson(json) => Notifikasi(
      id: json['id'],
      notiTypeId: json['notiTypeId'],
      notiType: json['notiType'],
      descId: json['descId'],
      description: json['description']);
}
