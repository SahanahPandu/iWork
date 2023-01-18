import 'accident.dart';
import 'bin_lifter_cleanliness.dart';
import 'cleanliness.dart';
import 'document.dart';
import 'engine.dart';
import 'fuel.dart';
import 'light.dart';
import 'mampatan.dart';
import 'odometer.dart';
import 'outside.dart';
import 'safety_things.dart';
import 'tyre.dart';
import 'vehicle_physical.dart';

class VcItem {
  VcItem({
    required this.fuel,
    required this.tyre,
    required this.light,
    required this.engine,
    required this.outside,
    required this.accident,
    required this.document,
    required this.mampatan,
    required this.odometer,
    required this.cleanliness,
    required this.safetyThings,
    required this.vehiclePhysical,
    required this.binLifterCleanliness,
  });

  Fuel fuel;
  Tyre tyre;
  Light light;
  Engine engine;
  Outside outside;
  Accident accident;
  Document document;
  Mampatan mampatan;
  Odometer odometer;
  Cleanliness cleanliness;
  SafetyThings safetyThings;
  VehiclePhysical vehiclePhysical;
  BinLifterCleanliness binLifterCleanliness;

  factory VcItem.fromJson(Map<String, dynamic> json) => VcItem(
        fuel: Fuel.fromJson(json["fuel"]),
        tyre: Tyre.fromJson(json["tyre"]),
        light: Light.fromJson(json["light"]),
        engine: Engine.fromJson(json["engine"]),
        outside: Outside.fromJson(json["outside"]),
        accident: Accident.fromJson(json["accident"]),
        document: Document.fromJson(json["document"]),
        mampatan: Mampatan.fromJson(json["mampatan"]),
        odometer: Odometer.fromJson(json["odometer"]),
        cleanliness: Cleanliness.fromJson(json["cleanliness"]),
        safetyThings: SafetyThings.fromJson(json["safetyThings"]),
        vehiclePhysical: VehiclePhysical.fromJson(json["vehiclePhysical"]),
        binLifterCleanliness:
            BinLifterCleanliness.fromJson(json["binLifterCleanliness"]),
      );

  Map<String, dynamic> toJson() => {
        "fuel": fuel.toJson(),
        "tyre": tyre.toJson(),
        "light": light.toJson(),
        "engine": engine.toJson(),
        "outside": outside.toJson(),
        "accident": accident.toJson(),
        "document": document.toJson(),
        "mampatan": mampatan.toJson(),
        "odometer": odometer.toJson(),
        "cleanliness": cleanliness.toJson(),
        "safetyThings": safetyThings.toJson(),
        "vehiclePhysical": vehiclePhysical.toJson(),
        "binLifterCleanliness": binLifterCleanliness.toJson(),
      };
}
