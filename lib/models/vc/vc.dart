import 'package:eswm/models/vc/sebelum.dart';
import 'package:eswm/models/vc/selepas.dart';

class VehicleChecklist {
  VehicleChecklist({
    required this.id,
    required this.tarikh,
    required this.noLaluan,
    required this.noKenderaan,
    required this.masaKeluar,
    required this.masaBalik,
    required this.status,
    required this.sebelum,
    required this.selepas,
  });

  int id;
  String tarikh;
  String noLaluan;
  String noKenderaan;
  String masaKeluar;
  String masaBalik;
  String status;
  Sebelum sebelum;
  Selepas selepas;

  static VehicleChecklist fromJson(json) => VehicleChecklist(
        id: json["id"],
        tarikh: json["tarikh"],
        noLaluan: json["noLaluan"],
        noKenderaan: json["noKenderaan"],
        masaKeluar: json["masaKeluar"],
        masaBalik: json["masaBalik"],
        status: json["status"],
        sebelum: Sebelum.fromJson(json["sebelum"]),
        selepas: Selepas.fromJson(json["selepas"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tarikh": tarikh,
        "noLaluan": noLaluan,
        "noKenderaan": noKenderaan,
        "masaKeluar": masaKeluar,
        "masaBalik": masaBalik,
        "status": status,
        "sebelum": sebelum.toJson(),
        "selepas": selepas.toJson(),
      };
}
