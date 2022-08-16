class Notifikasi {
  final int id;
  final int notiTypeId;
  final String notiType;
  final dynamic dataId;
  final int descId;
  final String description;
  final int readIdStatus;

  const Notifikasi({
    required this.id,
    required this.notiTypeId,
    required this.notiType,
    required this.dataId,
    required this.descId,
    required this.description,
    required this.readIdStatus,
  });

  static Notifikasi fromJson(json) => Notifikasi(
        id: json['id'],
        notiTypeId: json['notiTypeId'],
        notiType: json['notiType'],
        dataId: json['dataId'],
        descId: json['descId'],
        description: json['description'],
        readIdStatus: json['readIdStatus'],
      );
}
