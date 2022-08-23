import 'package:eswm/models/vc/sebelum.dart';
import 'package:eswm/models/vc/selepas.dart';

class VehicleChecklist {
  VehicleChecklist({
    required this.id,
    required this.tarikh,
    required this.status,
    required this.statusId,
    required this.noLaluan,
    required this.noKenderaan,
    required this.masaKeluar,
    required this.masaBalik,
    required this.statusOperasi,
    required this.sebelum,
    required this.selepas,
  });

  int id;
  String tarikh;
  String status;
  int statusId;
  String noLaluan;
  String noKenderaan;
  String masaKeluar;
  String masaBalik;
  String statusOperasi;
  Sebelum sebelum;
  Selepas selepas;

  static VehicleChecklist fromJson(json) => VehicleChecklist(
        id: json["id"],
        tarikh: json["tarikh"],
        status: json["status"],
        statusId: json["statusId"],
        noLaluan: json["noLaluan"],
        noKenderaan: json["noKenderaan"],
        masaKeluar: json["masaKeluar"],
        masaBalik: json["masaBalik"],
        statusOperasi: json["statusOperasi"],
        sebelum: Sebelum.fromJson(json["sebelum"]),
        selepas: Selepas.fromJson(json["selepas"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tarikh": tarikh,
        "status": noLaluan,
        "statusId": noLaluan,
        "noLaluan": noLaluan,
        "noKenderaan": noKenderaan,
        "masaKeluar": masaKeluar,
        "masaBalik": masaBalik,
        "statusOperasi": statusOperasi,
        "sebelum": sebelum.toJson(),
        "selepas": selepas.toJson(),
      };
}
