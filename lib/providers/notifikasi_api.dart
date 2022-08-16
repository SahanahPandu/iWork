import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/notifikasi.dart';

class NotifikasiApi {
  static Future<List<Notifikasi>> getNotifikasiData(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_notifikasi.json');
    final data = json.decode(jsonData);

    return data.map<Notifikasi>(Notifikasi.fromJson).toList();
  }
}
