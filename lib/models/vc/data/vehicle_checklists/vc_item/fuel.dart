class Fuel {
  Fuel({
    required this.liter,
    required this.rm,
    required this.resit,
    required this.fleetCard,
    required this.noFleetCard,
    required this.fuelLevel,
  });

  dynamic liter;
  dynamic rm;
  String resit;
  String fleetCard;
  dynamic noFleetCard;
  int fuelLevel;

  static Fuel fromJson(json) => Fuel(
        liter: json["liter"],
        rm: json["rm"],
        resit: json["resit"],
        fleetCard: json["fleetCard"],
        noFleetCard: json["noFleetCard"],
        fuelLevel: json["fuelLevel"],
      );

  Map<String, dynamic> toJson() => {
        "liter": liter,
        "rm": rm,
        "resit": resit,
        "fleetCard": fleetCard,
        "noFleetCard": noFleetCard,
        "fuelLevel": fuelLevel,
      };
}
