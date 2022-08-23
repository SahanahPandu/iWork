import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/vc/vc.dart';


class VehicleChecklistApi {
  static Future<List<VehicleChecklist>> getVehicleChecklistData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData = await assetBundle.loadString('assets/data/data_vc.json');
    final data = json.decode(jsonData);

    return data.map<VehicleChecklist>(VehicleChecklist.fromJson).toList();
  }
}
