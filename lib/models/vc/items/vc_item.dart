import 'package:eswm/models/vc/items/safety_things.dart';
import 'package:eswm/models/vc/items/tyre.dart';
import 'package:eswm/models/vc/items/document.dart';
import 'package:eswm/models/vc/items/vehicle_physical.dart';

import 'accident.dart';
import 'bin_lifter_cleanliness.dart';
import 'cleanliness.dart';
import 'engine.dart';
import 'fuel.dart';
import 'light.dart';
import 'mampatan.dart';
import 'odometer.dart';
import 'outside.dart';

class VcItem {
  VcItem({
    required this.odometer,
    required this.fuel,
    required this.document,
    required this.tyre,
    required this.mampatan,
    required this.light,
    required this.engine,
    required this.outside,
    required this.safetyThings,
    required this.cleanliness,
    required this.binLifterCleanliness,
    required this.accident,
    required this.vehiclePhysical,
  });

  Odometer odometer;
  Fuel fuel;
  Document document;
  Tyre tyre;
  Mampatan mampatan;
  Light light;
  Engine engine;
  Outside outside;
  SafetyThings safetyThings;
  Cleanliness cleanliness;
  BinLifterCleanliness binLifterCleanliness;
  Accident accident;
  VehiclePhysical vehiclePhysical;

  static VcItem fromJson(json) => VcItem(
        odometer: Odometer.fromJson(json["odometer"]),
        fuel: Fuel.fromJson(json["fuel"]),
        document: Document.fromJson(json["document"]),
        tyre: Tyre.fromJson(json["tyre"]),
        mampatan: Mampatan.fromJson(json["mampatan"]),
        light: Light.fromJson(json["light"]),
        engine: Engine.fromJson(json["engine"]),
        outside: Outside.fromJson(json["outside"]),
        safetyThings: SafetyThings.fromJson(json["safetyThings"]),
        cleanliness: Cleanliness.fromJson(json["cleanliness"]),
        binLifterCleanliness:
            BinLifterCleanliness.fromJson(json["binLifterCleanliness"]),
        accident: Accident.fromJson(json["accident"]),
        vehiclePhysical: VehiclePhysical.fromJson(json["vehiclePhysical"]),
      );

  Map<String, dynamic> toJson() => {
        "odometer": odometer.toJson(),
        "fuel": fuel.toJson(),
        "document": document.toJson(),
        "tyre": tyre.toJson(),
        "mampatan": mampatan.toJson(),
        "light": light.toJson(),
        "engine": engine.toJson(),
        "outside": outside.toJson(),
        "safetyThings": safetyThings.toJson(),
        "cleanliness": cleanliness.toJson(),
        "binLifterCleanliness": binLifterCleanliness.toJson(),
        "accident": accident.toJson(),
        "vehiclePhysical": vehiclePhysical.toJson(),
      };
}
