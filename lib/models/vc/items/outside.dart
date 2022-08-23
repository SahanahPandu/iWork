class Outside {
  Outside({
    required this.cermin,
    required this.hon,
    required this.remarks,
  });

  String cermin;
  String hon;
  String remarks;

  static Outside fromJson(json) => Outside(
        cermin: json["cermin"],
        hon: json["hon"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "cermin": cermin,
        "hon": hon,
        "remarks": remarks,
      };
}
