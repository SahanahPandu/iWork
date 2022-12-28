class VehiclePhysical {
  VehiclePhysical({
    required this.sampah,
    required this.kecacatan,
    this.remarks,
  });

  String sampah;
  String kecacatan;
  String? remarks;

  static VehiclePhysical fromJson(json) => VehiclePhysical(
        sampah: json["sampah"],
        kecacatan: json["kecacatan"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "sampah": sampah,
        "kecacatan": kecacatan,
        "remarks": remarks,
      };
}
