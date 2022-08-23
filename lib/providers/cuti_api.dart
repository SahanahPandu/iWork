import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/cuti.dart';

class CutiApi {
  static Future<List<Cuti>> getCutiData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData = await assetBundle.loadString('assets/data/data_cuti.json');
    final data = json.decode(jsonData);

    return data.map<Cuti>(Cuti.fromJson).toList();
  }
}
