class Pekerja {
  final String id;
  final String name;
  final String designCat;
  final String designation;
  final String displayPicture;
  final int idAttStatus;
  final String attStatus;
  final String skills;
  final String idSv;
  final String timeIn;
  final String timeOut;
  final String reportsTo;
  final String tiedLaluan;
  final String tiedVehicle;

  Pekerja(
      {required this.id,
      required this.name,
      required this.designCat,
      required this.designation,
      required this.displayPicture,
      required this.idAttStatus,
      required this.attStatus,
      required this.skills,
      required this.idSv,
      required this.timeIn,
      required this.timeOut,
      required this.reportsTo,
      required this.tiedLaluan,
      required this.tiedVehicle});

  static Pekerja fromJson(json) => Pekerja(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        designCat: json['designCat'] ?? "",
        designation: json['designation'] ?? "",
        displayPicture: json['displayPicture'] ?? "",
        idAttStatus: json['idAttStatus'] ?? 0,
        attStatus: json['attStatus'] ?? "",
        skills: json['skills'] ?? "",
        idSv: json['idSv'] ?? "",
        timeIn: json['timeIn'] ?? "",
        timeOut: json['timeOut'] ?? "",
        reportsTo: json['reportsTo'] ?? "",
        tiedLaluan: json['tiedLaluan'] ?? "",
        tiedVehicle: json['tiedVehicle'] ?? "",
      );
}
