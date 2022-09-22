class Notifikasi {
  final int id; //id notifikasi
  final int
      notiTypeId; // id jenis notifikasi (1 = Jadual , 2 = Kehadiran , 3 = E-Cuti, 4 = Laporan, 5 = Jadual)
  final String
      notiType; //jenis notifikasi (Tugasan , Kehadiran , E-Cuti, Laporan, Jadual)
  final dynamic dataId;
  final int descId; // id description
  final String description; //  template string show on notification page
  final int readIdStatus; // noti status (1= unread, 2 = read)
  final String dateReceived; // date received the notification

  const Notifikasi({
    required this.id,
    required this.notiTypeId,
    required this.notiType,
    required this.dataId,
    required this.descId,
    required this.description,
    required this.readIdStatus,
    required this.dateReceived,
  });

  static Notifikasi fromJson(json) => Notifikasi(
        id: json['id'],
        notiTypeId: json['notiTypeId'],
        notiType: json['notiType'],
        dataId: json['dataId'],
        descId: json['descId'],
        description: json['description'],
        readIdStatus: json['readIdStatus'],
        dateReceived: json['dateReceived'],
      );
}
