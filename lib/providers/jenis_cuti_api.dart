import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/jenis_cuti.dart';

class JenisCutiApi {
  static Future<List<JenisCuti>> getJenisCutiData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_jenis_cuti.json');
    final data = json.decode(jsonData);

    return data.map<JenisCuti>(JenisCuti.fromJson).toList();
  }
}
