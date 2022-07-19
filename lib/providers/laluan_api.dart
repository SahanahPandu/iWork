import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/laluan.dart';

class LaluanApi {
  static Future<List<Laluan>> getLaluanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_laluan.json');
    final data = json.decode(jsonData);

    return data.map<Laluan>(Laluan.fromJson).toList();
  }
}
