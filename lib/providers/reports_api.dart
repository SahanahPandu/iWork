import 'dart:convert';
import 'package:flutter/material.dart';

//import files
import '../models/reports.dart';

class ReportsApi {
  static Future<List<Reports>> getReportsData(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final jsonData =
        await assetBundle.loadString('assets/data/data_report.json');
    final data = json.decode(jsonData);

    return data.map<Reports>(Reports.fromJson).toList();
  }
}
