class Fuel {
  Fuel({
    required this.liter,
    required this.rm,
    required this.resit,
    required this.fleetCard,
    required this.noFleetCard,
    required this.fuelLevel,
  });

  int liter;
  int rm;
  int resit;
  int fleetCard;
  int noFleetCard;
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
