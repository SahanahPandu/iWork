import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/taman.dart';

class TamanApi {
  static Future<List<Taman>> getTamanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_taman.json');
    final data = json.decode(jsonData);

    return data.map<Taman>(Taman.fromJson).toList();
  }
}
