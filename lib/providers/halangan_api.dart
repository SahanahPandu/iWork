import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/halangan.dart';

class HalanganApi {
  static Future<List<Halangan>> getHalanganData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_jenis_halangan.json');
    final data = json.decode(jsonData);

    return data.map<Halangan>(Halangan.fromJson).toList();
  }
}
