import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/jalan.dart';

class JalanApi {
  static Future<List<Jalan>> getJalanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_jalan.json');
    final data = json.decode(jsonData);

    return data.map<Jalan>(Jalan.fromJson).toList();
  }
}
