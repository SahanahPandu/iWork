import 'dart:convert';

import 'package:dio/dio.dart';

import '../../config/config.dart';
import '../../models/vc/vc_main.dart';
import '../http/service/http_service.dart';

class VehicleChecklistApi {
  static Future<VehicleChecklistMain?>? getVehicleChecklist() async {
    VehicleChecklistMain? dataVC;
    String? getAccessToken = userInfo[1];

    try {
      var response = await Dio().get(
        HttpService().loadVehicleChecklist,
        queryParameters: {'vehicle_checklist_id': '3'},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decode = json.decode(json.encode(response.data));
        var convertData = VehicleChecklistMain.fromJson(decode);
        dataVC = convertData;
      } else {
        //print("ERROR");
      }
    } catch (e) {
      //print(e);
    }
    return dataVC;
  }

  static Future<VehicleChecklistMain> getVehicleChecklistData(int? vcId) async {
    late VehicleChecklistMain dataVC;
    String? getAccessToken = userInfo[1];

    try {
      var response = await Dio().get(
        HttpService().loadVehicleChecklist,
        queryParameters: {'vehicle_checklist_id': vcId},
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );
      Map<String, dynamic> decode = jsonDecode(jsonEncode(response.data));
      var convertData = VehicleChecklistMain.fromJson(decode);
      dataVC = convertData;
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return dataVC;
  }

  static Future uploadVehicleChecklistData(// String? vNo,
      // String? scMain,
      // int? isBefore,
      // ChecklistBefore? checklistBefore,
      // ChecklistAfter? checklistAfter
      ) async {
    String getAccessToken = userInfo[1];
    Map body = {
      'vcItem': {
        'odometer': {
          'bacaanOdo': 111111,
          'odoFungsi': 'Ya',
          'totalKM': 126,
          'noAkbk': 'L-23984'
        },
        'fuel': {
          'liter': 0,
          'rm': 123.45,
          'resit': 'Ya',
          'fleetCard': 'Ya',
          'noFleetCard': 23455,
          'fuelLevel': 80
        },
        'document': {
          'puspakomDisc': 'Ada',
          'cukaiJalan': 'Ada',
          'lesen': 'Ada',
          'remarks': 'Dokumen OK'
        },
        'tyre': {
          'bungaTayar': 'Tiada',
          'nutTayar': 'Tiada',
          'tekananTayar': 'Tiada',
          'remarks': 'Tayar Tiada'
        },
        'mampatan': {
          'sistemHidraulik': 'Tiada',
          'ptd/pam': 'Ada',
          'allPenutup': 'Ada',
          'buangAir': 'Ada',
          'leachate': 'Ada',
          'remarks': 'Ada'
        },
        'light': {
          'lampuUtama': 'Ada',
          'lampuHenti': 'Ada',
          'lampuIsyarat': 'Ada',
          'lampuKecemasan': 'Ada',
          'lampuBeacon': 'Ada',
          'lampuPlet': 'Ada',
          'remarks': 'Ada'
        },
        'engine': {
          'dipstikMinyakEnjin': 'Ada',
          'parasMinyak': 'Ada',
          'penutupMinyak': 'Ada',
          'parasAirRadiator': 'Ada',
          'parasExpansion': 'Ada',
          'dipstikMintakTransmission': 'Ada',
          'parasMinyakTransmission': 'Ada',
          'parasMinyakSteering': 'Ada',
          'parasMinyakBrek': 'Ada',
          'sistemCengkamanSistemBrek': 'Ada',
          'parasMinyakClutch': 'Ada',
          'sistemClutch': 'Ada',
          'parasAirWiper': 'Ada',
          'keadaanWiper': 'Ada',
          'parasAirBateri': 'Ada',
          'asapEkzos': 'Ada',
          'remarks': 'Ada'
        },
        'outside': {'cermin': 'Ada', 'hon': 'Ada', 'remarks': ""},
        'safetyThings': {
          'penandaKecemasan': 'Ada',
          'pemadamApi': 'Tiada',
          'kotakKecemasan': 'Ada',
          'remarks': 'Ya mix'
        },
        'cleanliness': {
          'dalamKokpit': 'Ada',
          'luarBadanTrak': 'Ada',
          'remarks': 'Ada bersih'
        },
        'binLifterCleanliness': {'binDicuci': 'Ada', 'remarks': 'Ada'},
        'accident': {
          'terlibatKemalangan': 'Ada',
          'noKenderaanPartiKetiga': 'Ada',
          'remarks': 'Ada third parti'
        },
        'vehiclePhysical': {
          'sampah': 'Ada',
          'kecacatan': 'Ada',
          'remarks': 'Ada'
        }
      }
    };

    var data = body;

    try {
      await Dio().get(
        HttpService().updateVehicleChecklist,
        queryParameters: {
          'vehicle_no': 'BLX3282',
          'sc_main_id': '506',
          'is_before': '0',
          'checklist_after': data
        },
        options: Options(headers: {
          'authorization': 'Bearer $getAccessToken',
        }),
      );
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
