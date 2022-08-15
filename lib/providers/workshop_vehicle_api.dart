import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/workshop_vehicle.dart';

class WorkshopVehicleApi {
  static Future<List<WorkshopVehicle>> getWorkshopVehicleData(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_workshop.json');
    final data = json.decode(jsonData);

    return data.map<WorkshopVehicle>(WorkshopVehicle.fromJson).toList();
  }
}
