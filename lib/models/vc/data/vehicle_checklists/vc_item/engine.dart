class Engine {
  Engine({
    required this.dipstikMinyakEnjin,
    required this.parasMinyak,
    required this.penutupMinyak,
    required this.parasAirRadiator,
    required this.parasExpansion,
    required this.dipstikMintakTransmission,
    required this.parasMinyakTransmission,
    required this.parasMinyakSteering,
    required this.parasMinyakBrek,
    required this.sistemCengkamanSistemBrek,
    required this.parasMinyakClutch,
    required this.sistemClutch,
    required this.parasAirWiper,
    required this.keadaanWiper,
    required this.parasAirBateri,
    required this.asapEkzos,
    this.remarks,
  });

  String dipstikMinyakEnjin;
  String parasMinyak;
  String penutupMinyak;
  String parasAirRadiator;
  String parasExpansion;
  String dipstikMintakTransmission;
  String parasMinyakTransmission;
  String parasMinyakSteering;
  String parasMinyakBrek;
  String sistemCengkamanSistemBrek;
  String parasMinyakClutch;
  String sistemClutch;
  String parasAirWiper;
  String keadaanWiper;
  String parasAirBateri;
  String asapEkzos;
  String? remarks;

  static Engine fromJson(json) => Engine(
        dipstikMinyakEnjin: json["dipstikMinyakEnjin"],
        parasMinyak: json["parasMinyak"],
        penutupMinyak: json["penutupMinyak"],
        parasAirRadiator: json["parasAirRadiator"],
        parasExpansion: json["parasExpansion"],
        dipstikMintakTransmission: json["dipstikMintakTransmission"],
        parasMinyakTransmission: json["parasMinyakTransmission"],
        parasMinyakSteering: json["parasMinyakSteering"],
        parasMinyakBrek: json["parasMinyakBrek"],
        sistemCengkamanSistemBrek: json["sistemCengkamanSistemBrek"],
        parasMinyakClutch: json["parasMinyakClutch"],
        sistemClutch: json["sistemClutch"],
        parasAirWiper: json["parasAirWiper"],
        keadaanWiper: json["keadaanWiper"],
        parasAirBateri: json["parasAirBateri"],
        asapEkzos: json["asapEkzos"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "dipstikMinyakEnjin": dipstikMinyakEnjin,
        "parasMinyak": parasMinyak,
        "penutupMinyak": penutupMinyak,
        "parasAirRadiator": parasAirRadiator,
        "parasExpansion": parasExpansion,
        "dipstikMintakTransmission": dipstikMintakTransmission,
        "parasMinyakTransmission": parasMinyakTransmission,
        "parasMinyakSteering": parasMinyakSteering,
        "parasMinyakBrek": parasMinyakBrek,
        "sistemCengkamanSistemBrek": sistemCengkamanSistemBrek,
        "parasMinyakClutch": parasMinyakClutch,
        "sistemClutch": sistemClutch,
        "parasAirWiper": parasAirWiper,
        "keadaanWiper": keadaanWiper,
        "parasAirBateri": parasAirBateri,
        "asapEkzos": asapEkzos,
        "remarks": remarks,
      };
}
