import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/akbk.dart';

//import files

class AkbkApi {
  static Future<List<Akbk>> getAkbkData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData = await assetBundle.loadString('assets/data/data_akbk.json');
    final data = json.decode(jsonData);

    return data.map<Akbk>(Akbk.fromJson).toList();
  }
}
