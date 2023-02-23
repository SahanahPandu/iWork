import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import files
import '../../config/config.dart';
import '../../models/options/options_data.dart';
import '../../models/vc/detail/vc_main.dart';
import '../../models/vc/list/data/vc_data.dart';
import '../../models/vc/status/vc_filter_status.dart';
import '../../utils/calendar/date.dart';
import '../http/error/api_error.dart';
import '../http/service/http_header.dart';
import '../http/service/http_service.dart';

class VehicleChecklistApi {
  static Future<VehicleChecklistMain?>? getVehicleChecklist() async {
    VehicleChecklistMain? dataVC;
    String? getAccessToken = userInfo[1];

    try {
      var response = await Dio().get(
        HttpService().loadVehicleChecklist,
        queryParameters: {'vehicle_checklist_id': '3'},
        options: HttpHeader.getApiHeader(getAccessToken),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        VehicleChecklistMain convertData =
            VehicleChecklistMain.fromJson(decode);
        dataVC = convertData;
      } else {
        //print("ERROR");
      }
    } catch (e) {
      //print(e);
    }
    return dataVC;
  }

  static Future<VehicleChecklistMain> getVehicleChecklistData(
      BuildContext context, int? vcId) async {
    late VehicleChecklistMain dataVC;
    String? getAccessToken = userInfo[1];
    try {
      var response = await Dio().get(
        HttpService().loadVehicleChecklist,
        queryParameters: {'vehicle_checklist_id': vcId},
        options: HttpHeader.getApiHeader(getAccessToken),
      );
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> decode = jsonDecode(jsonEncode(response.data));
          //logDev.log(decode.toString(), name: "myResponseLog");
          VehicleChecklistMain convertData =
              VehicleChecklistMain.fromJson(decode);
          dataVC = convertData;
          break;
        case 401:
        default:
          return VehicleChecklistMain(status: "Invalid");
      }
    } on DioError catch (e) {
      /// Checks for Dio returns error
      ApiError.findDioError(e, context);
    }

    return dataVC;
  }

  static Future<String> uploadVehicleChecklistData(
    String? isBefore,
    int? vehicleChecklistId,
    Map<String, Map<String, Map<String, Object>>> vcBody,
  ) async {
    String getAccessToken = userInfo[1];
    /* final bodyTest = {
      "vcItem": {
        "odometer": {
          "bacaanOdo": 111111,
          "odoFungsi": "Ya",
          "totalKM": 126,
          "noAkbk": "L-23984"
        },
        "fuel": {
          "liter": 0,
          "rm": 123.45,
          "resit": 'Ya',
          "fleetCard": 'Ya',
          "noFleetCard": 23455,
          "fuelLevel": 80
        },
        "document": {
          "puspakomDisc": "Ada",
          "cukaiJalan": "Ada",
          "lesen": "Ada",
          "remarks": "Dokumen OK"
        },
        "tyre": {
          "bungaTayar": "Tiada",
          "nutTayar": "Tiada",
          "tekananTayar": "Tiada",
          "remarks": "Tayar Tiada"
        },
        "mampatan": {
          "sistemHidraulik": "Tiada",
          "ptd/pam": "Ada",
          "allPenutup": "Ada",
          "buangAir": "Ada",
          "leachate": "Ada",
          "remarks": "Ada"
        },
        "light": {
          "lampuUtama": "Ada",
          "lampuHenti": "Ada",
          "lampuIsyarat": "Ada",
          "lampuKecemasan": "Ada",
          "lampuBeacon": "Ada",
          "lampuPlet": "Ada",
          "remarks": "Ada"
        },
        "engine": {
          "dipstikMinyakEnjin": "Ada",
          "parasMinyak": "Ada",
          "penutupMinyak": "Ada",
          "parasAirRadiator": "Ada",
          "parasExpansion": "Ada",
          "dipstikMintakTransmission": "Ada",
          "parasMinyakTransmission": "Ada",
          "parasMinyakSteering": "Ada",
          "parasMinyakBrek": "Ada",
          "sistemCengkamanSistemBrek": "Ada",
          "parasMinyakClutch": "Ada",
          "sistemClutch": "Ada",
          "parasAirWiper": "Ada",
          "keadaanWiper": "Ada",
          "parasAirBateri": "Ada",
          "asapEkzos": "Ada",
          "remarks": "Ada"
        },
        "outside": {"cermin": "Ada", "hon": "Ada", "remarks": ""},
        "safetyThings": {
          "penandaKecemasan": "Ada",
          "pemadamApi": "Tiada",
          "kotakKecemasan": "Ada",
          "remarks": "Ya mix"
        },
        "cleanliness": {
          "dalamKokpit": "Ada",
          "luarBadanTrak": "Ada",
          "remarks": "Ada bersih"
        },
        "binLifterCleanliness": {"binDicuci": "Ada", "remarks": "Ada"},
        "accident": {
          "terlibatKemalangan": "Ada",
          "noKenderaanPartiKetiga": "Ada",
          "remarks": "Ada third parti"
        },
        "vehiclePhysical": {
          "sampah": "Ada",
          "kecacatan": "Ada",
          "remarks": "Ada"
        }
      }
    };*/
    final jsonString = json.encode(vcBody);
    //logDev.log(jsonString, name: "myEncodedLog");
    final data = {'is_before': isBefore, 'checklist_before': jsonString};

    final dataAfter = {
      'is_before': isBefore,
      'vehicle_checklist_id': vehicleChecklistId.toString(),
      'checklist_after': jsonString
    };
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $getAccessToken'};
    final response = await http.post(HttpService().updateVehicleChecklistTest,
        headers: headers, body: isBefore == '1' ? data : dataAfter);
    switch (response.statusCode) {
      case 200:
        return 'ok';
      case 401:
        return 'ng';
      default:
        return 'error';
    }
  }

  static Future<VCData> fetchVehicleChecklistList(
      BuildContext context, int pageNumber,
      [Map<String, Object>? passData]) async {
    String? getAccessToken = userInfo[1];
    dynamic vcList;
    dynamic myData =
        passData != null ? Map<String, dynamic>.from(passData) : null;
    dynamic convDate = "";
    dynamic statusList;
    List newStatusList = [];
    dynamic futureResponse;
    try {
      if (myData != null) {
        if (myData['filteredDate'] != "") {
          convDate = Date.getTheDate(
              myData['filteredDate'], "dd/MM/yyyy", "yyyy-MM-dd", "ms");
        }
        statusList = myData['selectedStatus'];
        if (statusList.length > 0) {
          for (int i = 0; i < statusList.length; i++) {
            newStatusList.add(statusList[i].code);
          }
        }
        futureResponse = Dio().get(
            '$theBase/task/vehicle-checklist-list?page=$pageNumber',
            options: HttpHeader.getApiHeader(getAccessToken),
            queryParameters:
                _getQueryParameter(passData, convDate, newStatusList));
      } else {
        futureResponse = Dio().get(
            '$theBase/task/vehicle-checklist-list?page=$pageNumber',
            options: HttpHeader.getApiHeader(getAccessToken));
      }

      final response = await futureResponse;
      if (response.statusCode == 200) {
        Map<String, dynamic> decode =
            json.decode(json.encode(response.data['data']));
        vcList = VCData.fromJson(decode);
      } else {
        vcList = [];
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
    }

    return vcList;
  }

  static _getQueryParameter(
      Map<String, Object>? passData, String? convDate, dynamic status) {
    /// no passdata
    if (passData == null) {
      return null;
    }

    /// filtered date only
    else if (convDate != null && (status.length == 0 || status.isEmpty)) {
      return {'date': convDate};
    }

    /// filtered status only
    else if (convDate == null && (status.length >= 0 || status.isNotEmpty)) {
      return {
        'status_code[]': [status],
      };
    }

    /// filtered date and status
    else if (convDate != null && (status.length >= 0 || status.isNotEmpty)) {
      return {
        'date': convDate,
        'status_code[]': [status],
      };
    } else {
      return null;
    }
  }

  static Future<List<VcStatus?>?>? getVcStatus(BuildContext context) async {
    List<VcStatus?>? filterData = [];
    try {
      Response response = await Dio().get(
        HttpService().loadFilterOption,
        queryParameters: {
          'fields[]': 'vc_status',
        },
        options: HttpHeader.getApiHeader(userInfo[1]),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        var convertData = OptionsData.fromJson(decode);
        convertData.data?.vcStatus != null
            ? filterData = convertData.data!.vcStatus
            : filterData = [];
      }
    } on DioError catch (e) {
      ApiError.findDioError(e, context);
    }

    return filterData;
  }
}
