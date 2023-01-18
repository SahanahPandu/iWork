import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/vc/detail/vc_main.dart';


class VehicleChecklistApis {
  static Future<List<VehicleChecklistMain>> getVehicleChecklistData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData = await assetBundle.loadString('assets/data/data_vc.json');
    final data = json.decode(jsonData);

    return data.map<VehicleChecklistMain>(VehicleChecklistMain.fromJson).toList();
  }
}
