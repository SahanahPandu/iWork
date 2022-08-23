import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/penyelia.dart';

class PenyeliaApi {
  static Future<List<Penyelia>> getPenyeliaData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_penyelia.json');
    final data = json.decode(jsonData);

    return data.map<Penyelia>(Penyelia.fromJson).toList();
  }
}
