import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/sub_laluan.dart';

class TamanApi {
  static Future<List<SubLaluan>> getTamanData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_sub_laluan.json');
    final data = json.decode(jsonData);

    return data.map<SubLaluan>(SubLaluan.fromJson).toList();
  }
}
