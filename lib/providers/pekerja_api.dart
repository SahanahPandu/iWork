import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/pekerja.dart';

class PekerjaApi {
  static Future<List<Pekerja>> getPekerjaData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_pekerja.json');
    final data = json.decode(jsonData);

    return data.map<Pekerja>(Pekerja.fromJson).toList();
  }
}
