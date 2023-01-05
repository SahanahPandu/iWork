import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../../config/config.dart';
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../config/string.dart';
import '../../../models/task/compactor/compactor_task.dart';
import '../../../models/vc/vc_main.dart';
import '../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/calendar/time.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import '../../../widgets/alert/alert_dialog.dart';
import '../../../widgets/alert/lottie_alert_dialog.dart';
import '../../../widgets/alert/toast.dart';
import '../../../widgets/custom_scroll/custom_scroll.dart';

class VehicleChecklistDetail extends StatefulWidget {
  final VehicleChecklistMain? data;
  final CompactorTask? compactorData;
  final bool before;

  const VehicleChecklistDetail(
      {Key? key, this.data, this.compactorData, required this.before})
      : super(key: key);

  @override
  State<VehicleChecklistDetail> createState() => _VehicleChecklistDetailState();
}

class _VehicleChecklistDetailState extends State<VehicleChecklistDetail>
    with TickerProviderStateMixin {
  /// Form Keys for Value input from Card 2 ~ Card 3
  final _valueKey =
      List<GlobalKey<FormState>>.generate(5, (index) => GlobalKey<FormState>());

  /// Form Keys for Remark input from Card 4 ~ Card 15
  final _textKeys = List<GlobalKey<FormState>>.generate(
      11, (index) => GlobalKey<FormState>());

  /// Controller Keys for Remark input from Card 4 ~ Card 15
  final _remarkController = List<TextEditingController>.generate(
      11, (index) => TextEditingController());

  /// Integer value of each radio button in every row
  final _buttonVal = List.generate(48, (index) => index = -1);

  /// String value of each radio button in every row
  final _buttonStrVal = List<String>.generate(48, (index) => "-");

  /// Total integer value of radio buttons in each section
  final _totalEntered = List<String>.generate(11, (index) => "0");
  final _colorResult = List<Color>.generate(11, (index) => grey400);

  /// Container expand/collapse boolean
  final formExpandFlag = List<bool>.generate(11, (index) => false);
  bool formExpandFlagDefault = true;
  bool _valid = false;
  bool empty = true;
  bool _incompleteRadioButton = false;
  bool isLoading = false;
  double _fuelValue = 25;
  var routeList = routeNames.join(", ");

  /// Below are the data variables declared individually, for easy reference by other developers
  final TextEditingController _odoReader = TextEditingController();
  final TextEditingController _totalKM = TextEditingController();
  final TextEditingController _diesel = TextEditingController();
  final TextEditingController _rm = TextEditingController();
  final TextEditingController _kad = TextEditingController();
  String _todayDate = "0";
  String _odometer = "";
  String _receipt = "";
  String _fleet = "";
  String _puspakom = "";
  String _tax = "";
  String _lesen = "";
  String _tayar = "";
  String _nut = "";
  String _angin = "";
  String _hidraulik = "";
  String _ptd = "";
  String _penutup = "";
  String _airTabung = "";
  String _leachate = "";
  String _lampuUtama = "";
  String _lampuBerhenti = "";
  String _lampuIsyarat = "";
  String _lampuKecemasan = "";
  String _lampuBeacon = "";
  String _lampuPlet = "";
  String _dipstik = "";
  String _parasEnjin = "";
  String _penutupEnjin = "";
  String _airRadiator = "";
  String _expansionTank = "";
  String _dipstikAuto = "";
  String _parasAuto = "";
  String _parasPower = "";
  String _parasMykBrek = "";
  String _sisCengkaman = "";
  String _parasClutch = "";
  String _sisClutch = "";
  String _airWiper = "";
  String _wiper = "";
  String _airBateri = "";
  String _asapEkzos = "";
  String _cermin = "";
  String _hon = "";
  String _penanda = "";
  String _pemadamApi = "";
  String _firstAid = "";
  String _kabin = "";
  String _badanTrak = "";
  String _binLifter = "";
  String _kemalangan = "";
  String _thirdParty = "";
  String _sampah = "";
  String _fizikal = "";

  @override
  void initState() {
    _todayDate = Date.getTheDate(DateTime.now(), '', "dd-MM-yyyy", 'ms');
    if (widget.compactorData!.data!.vehicleChecklistId != null) {
      empty = false;
      if (widget.before) {
        if (widget.compactorData!.data!.vehicleChecklistId!.statusCode!.code == "VC1" ||
            widget.compactorData!.data!.vehicleChecklistId!.statusCode!.code ==
                "VC2" ||
            widget.compactorData!.data!.vehicleChecklistId!.statusCode!.code ==
                "VC3") {
          widget.data!.data!.vehicleChecklists!.createdAt != null
              ? _todayDate = widget.data!.data!.vehicleChecklists!.createdAt!
                  .substring(0, 10)
              : _todayDate =
                  Date.getTheDate(DateTime.now(), '', "dd-MM-yyyy", 'ms');
          _odoReader.text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.odometer.bacaanOdo
              .toString();
          _totalKM.text = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.odometer.totalKm
              .toString();
          _odometer = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.odometer.odoFungsi
              .toString();
          _diesel.text = widget
              .data!.data!.vehicleChecklists!.checklistBefore!.vcItem.fuel.liter
              .toString();
          _rm.text = widget
              .data!.data!.vehicleChecklists!.checklistBefore!.vcItem.fuel.rm
              .toString();
          _receipt = widget
              .data!.data!.vehicleChecklists!.checklistBefore!.vcItem.fuel.resit
              .toString();
          _fleet = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .fuel.fleetCard
              .toString();
          _kad.text = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.fuel.noFleetCard
              .toString();
          _fuelValue = double.parse(widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.fuel.fuelLevel);

          /// Part 1 Dokumen
          _puspakom = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.document.puspakomDisc
              .toString();
          _tax = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .document.cukaiJalan
              .toString();
          _lesen = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .document.lesen
              .toString();
          _remarkController[0].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.document.remarks
              .toString();

          /// Part 2 Tayar
          _tayar = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .tyre.bungaTayar
              .toString();
          _nut = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .tyre.nutTayar
              .toString();
          _angin = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .tyre.tekananTayar
              .toString();
          _remarkController[1].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.tyre.remarks
              .toString();

          /// Part 3 Mampatan
          _hidraulik = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.mampatan.sistemHidraulik
              .toString();
          _ptd = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .mampatan.ptdPam
              .toString();
          _penutup = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.mampatan.allPenutup
              .toString();
          _airTabung = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.mampatan.buangAir
              .toString();
          _leachate = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.mampatan.leachate
              .toString();
          _remarkController[2].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.mampatan.remarks
              .toString();

          /// Part 4 Lampu
          _lampuUtama = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.light.lampuUtama
              .toString();
          _lampuBerhenti = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.light.lampuHenti
              .toString();
          _lampuIsyarat = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.light.lampuIsyarat
              .toString();
          _lampuKecemasan = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.light.lampuKecemasan
              .toString();
          _lampuBeacon = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.light.lampuBeacon
              .toString();
          _lampuPlet = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.light.lampuPlet
              .toString();
          _remarkController[3].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.light.remarks
              .toString();

          /// Part 5 Enjin
          _dipstik = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.dipstikMinyakEnjin
              .toString();
          _parasEnjin = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasMinyak
              .toString();
          _penutupEnjin = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.penutupMinyak
              .toString();
          _airRadiator = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasAirRadiator
              .toString();
          _expansionTank = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.engine.parasExpansion
              .toString();
          _dipstikAuto = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.dipstikMintakTransmission
              .toString();
          _parasAuto = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasMinyakTransmission
              .toString();
          _parasPower = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasMinyakSteering
              .toString();
          _parasMykBrek = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasMinyakBrek
              .toString();
          _sisCengkaman = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.sistemCengkamanSistemBrek
              .toString();
          _parasClutch = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasMinyakClutch
              .toString();
          _sisClutch = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.sistemClutch
              .toString();
          _airWiper = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasAirWiper
              .toString();
          _wiper = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .engine.keadaanWiper
              .toString();
          _airBateri = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.parasAirBateri
              .toString();
          _asapEkzos = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.engine.asapEkzos
              .toString();
          _remarkController[4].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.engine.remarks
              .toString();

          /// Part 6 Bahagian Luaran
          _cermin = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.outside.cermin
              .toString();
          _hon = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .outside.hon
              .toString();
          _remarkController[5].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.outside.remarks
              .toString();

          /// Part 7 Keselamatan
          _penanda = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.safetyThings.penandaKecemasan
              .toString();
          _pemadamApi = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.safetyThings.pemadamApi
              .toString();
          _firstAid = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.safetyThings.kotakKecemasan
              .toString();
          _remarkController[6].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.safetyThings.remarks
              .toString();

          /// Part 8 Kebersihan Kenderaan
          _kabin = widget.data!.data!.vehicleChecklists!.checklistBefore!.vcItem
              .cleanliness.dalamKokpit
              .toString();
          _badanTrak = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.cleanliness.luarBadanTrak
              .toString();
          _remarkController[7].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.cleanliness.remarks
              .toString();

          /// Part 9 Kebersihan Bin Lifter
          _binLifter = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.binLifterCleanliness.binDicuci
              .toString();
          _remarkController[8].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.binLifterCleanliness.remarks
              .toString();

          /// Part 10 Kemalangan
          _kemalangan = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.accident.terlibatKemalangan
              .toString();
          _thirdParty = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.accident.noKenderaanPartiKetiga
              .toString();
          _remarkController[9].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.accident.remarks
              .toString();

          /// Part 11 Fizikal Kenderaan
          _sampah = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.vehiclePhysical.sampah
              .toString();
          _fizikal = widget.data!.data!.vehicleChecklists!.checklistBefore!
              .vcItem.vehiclePhysical.kecacatan
              .toString();
          _remarkController[10].text = widget.data!.data!.vehicleChecklists!
              .checklistBefore!.vcItem.vehiclePhysical.remarks
              .toString();
        }
      } else {
        if (widget.compactorData!.data!.vehicleChecklistId == null ||
            widget.compactorData!.data!.vehicleChecklistId!.statusCode!.code ==
                "VC1") {
          empty = true;
        } else {
          widget.data!.data!.vehicleChecklists!.createdAt != null
              ? _todayDate = widget.data!.data!.vehicleChecklists!.createdAt!
                  .substring(0, 10)
              : _todayDate =
                  Date.getTheDate(DateTime.now(), '', "dd-MM-yyyy", 'ms');
          _odoReader.text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.odometer.bacaanOdo
              .toString();
          _totalKM.text = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.odometer.totalKm
              .toString();
          _odometer = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.odometer.odoFungsi
              .toString();
          _diesel.text = widget
              .data!.data!.vehicleChecklists!.checklistAfter!.vcItem.fuel.liter
              .toString();
          _rm.text = widget
              .data!.data!.vehicleChecklists!.checklistAfter!.vcItem.fuel.rm
              .toString();
          _receipt = widget
              .data!.data!.vehicleChecklists!.checklistAfter!.vcItem.fuel.resit
              .toString();
          _fleet = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .fuel.fleetCard
              .toString();
          _kad.text = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.fuel.noFleetCard
              .toString();
          _fuelValue = double.parse(widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.fuel.fuelLevel);

          /// Part 1 Dokumen
          _puspakom = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.document.puspakomDisc
              .toString();
          _tax = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .document.cukaiJalan
              .toString();
          _lesen = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .document.lesen
              .toString();
          _remarkController[0].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.document.remarks
              .toString();

          /// Part 2 Tayar
          _tayar = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .tyre.bungaTayar
              .toString();
          _nut = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .tyre.nutTayar
              .toString();
          _angin = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .tyre.tekananTayar
              .toString();
          _remarkController[1].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.tyre.remarks
              .toString();

          /// Part 3 Mampatan
          _hidraulik = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.mampatan.sistemHidraulik
              .toString();
          _ptd = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .mampatan.ptdPam
              .toString();
          _penutup = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.mampatan.allPenutup
              .toString();
          _airTabung = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.mampatan.buangAir
              .toString();
          _leachate = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.mampatan.leachate
              .toString();
          _remarkController[2].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.mampatan.remarks
              .toString();

          /// Part 4 Lampu
          _lampuUtama = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.light.lampuUtama
              .toString();
          _lampuBerhenti = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.light.lampuHenti
              .toString();
          _lampuIsyarat = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.light.lampuIsyarat
              .toString();
          _lampuKecemasan = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.light.lampuKecemasan
              .toString();
          _lampuBeacon = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.light.lampuBeacon
              .toString();
          _lampuPlet = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.light.lampuPlet
              .toString();
          _remarkController[3].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.light.remarks
              .toString();

          /// Part 5 Enjin
          _dipstik = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.dipstikMinyakEnjin
              .toString();
          _parasEnjin = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasMinyak
              .toString();
          _penutupEnjin = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.penutupMinyak
              .toString();
          _airRadiator = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasAirRadiator
              .toString();
          _expansionTank = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasExpansion
              .toString();
          _dipstikAuto = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.dipstikMintakTransmission
              .toString();
          _parasAuto = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasMinyakTransmission
              .toString();
          _parasPower = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasMinyakSteering
              .toString();
          _parasMykBrek = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasMinyakBrek
              .toString();
          _sisCengkaman = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.sistemCengkamanSistemBrek
              .toString();
          _parasClutch = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasMinyakClutch
              .toString();
          _sisClutch = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.sistemClutch
              .toString();
          _airWiper = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasAirWiper
              .toString();
          _wiper = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .engine.keadaanWiper
              .toString();
          _airBateri = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.parasAirBateri
              .toString();
          _asapEkzos = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.engine.asapEkzos
              .toString();
          _remarkController[4].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.engine.remarks
              .toString();

          /// Part 6 Bahagian Luaran
          _cermin = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .outside.cermin
              .toString();
          _hon = widget
              .data!.data!.vehicleChecklists!.checklistAfter!.vcItem.outside.hon
              .toString();
          _remarkController[5].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.outside.remarks
              .toString();

          /// Part 7 Keselamatan
          _penanda = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.safetyThings.penandaKecemasan
              .toString();
          _pemadamApi = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.safetyThings.pemadamApi
              .toString();
          _firstAid = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.safetyThings.kotakKecemasan
              .toString();
          _remarkController[6].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.safetyThings.remarks
              .toString();

          /// Part 8 Kebersihan Kenderaan
          _kabin = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .cleanliness.dalamKokpit
              .toString();
          _badanTrak = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.cleanliness.luarBadanTrak
              .toString();
          _remarkController[7].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.cleanliness.remarks
              .toString();

          /// Part 9 Kebersihan Bin Lifter
          _binLifter = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.binLifterCleanliness.binDicuci
              .toString();
          _remarkController[8].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.binLifterCleanliness.remarks
              .toString();

          /// Part 10 Kemalangan
          _kemalangan = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.accident.terlibatKemalangan
              .toString();
          _thirdParty = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.accident.noKenderaanPartiKetiga
              .toString();
          _remarkController[9].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.accident.remarks
              .toString();

          /// Part 11 Fizikal Kenderaan
          _sampah = widget.data!.data!.vehicleChecklists!.checklistAfter!.vcItem
              .vehiclePhysical.sampah
              .toString();
          _fizikal = widget.data!.data!.vehicleChecklists!.checklistAfter!
              .vcItem.vehiclePhysical.kecacatan
              .toString();
          _remarkController[10].text = widget.data!.data!.vehicleChecklists!
              .checklistAfter!.vcItem.vehiclePhysical.remarks
              .toString();
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 48),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            //CONTAINER #1
            Container(
                alignment: Alignment.center,
                height: Orientations().isLandscape(context)
                    ? (Sizes().screenHeight(context) * 0.18)
                    : (Sizes().screenHeight(context) * 0.11),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: cardListShadowColor,
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                          spreadRadius: 0.5)
                    ]),
                child: Container(
                    margin: Orientations().isPortrait(context)
                        ? const EdgeInsets.fromLTRB(20, 20, 20, 22)
                        : const EdgeInsets.all(20),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: Orientations().isPortrait(context)
                            ? const {
                                0: FlexColumnWidth(1.2),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(0.2),
                                3: FlexColumnWidth(1.2),
                                4: FlexColumnWidth(1.2)
                              }
                            : const {
                                0: FlexColumnWidth(0.8),
                                1: FlexColumnWidth(1.2),
                                2: FlexColumnWidth(0.5),
                                3: FlexColumnWidth(0.8),
                                4: FlexColumnWidth(1.7)
                              },
                        border: TableBorder.all(color: transparent),
                        children: [
                          TableRow(children: [
                            Text(date,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Text(_todayDate,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackCustom,
                                    fontWeight: FontWeight.w600)),
                            const Text(' '),
                            Text(
                              streetNo,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: greyCustom,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(routeList,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackCustom,
                                    fontWeight: FontWeight.w600))
                          ]),
                          TableRow(children: [
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context))
                          ]),
                          TableRow(children: [
                            Text(widget.before ? outTime : inTime,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Text(
                                empty
                                    ? "--:--"
                                    : widget.before
                                        ? widget.data!.data!.vehicleChecklists!
                                                    .timeOut! !=
                                                "--:--"
                                            ? Time.convertToHM(widget
                                                .data!
                                                .data!
                                                .vehicleChecklists!
                                                .timeOut!)
                                            : "--:--"
                                        : widget.data!.data!.vehicleChecklists!
                                                    .timeIn! !=
                                                "--:--"
                                            ? Time.convertToHM(widget
                                                .data!
                                                .data!
                                                .vehicleChecklists!
                                                .timeIn!)
                                            : "--:--",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackCustom,
                                    fontWeight: FontWeight.w600)),
                            const Text(' '),
                            Text(compactorID,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Text(
                                widget.compactorData!.data!.schedules![0]
                                    .vehicleNo!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackCustom,
                                    fontWeight: FontWeight.w600))
                          ]),
                        ]))),
            Padding(
              padding: const EdgeInsets.only(top: 36, bottom: 20),
              child: Text(
                fillUpVC,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // #CONTAINER 2
            Container(
                alignment: Alignment.center,
                height: Orientations().isLandscape(context)
                    ? (Sizes().screenHeight(context) * 0.28)
                    : (Sizes().screenHeight(context) * 0.18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: barShadowColor,
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: 2)
                    ]),
                child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: columnVC2Width(context),
                        border: TableBorder.all(color: Colors.transparent),
                        children: [
                          TableRow(children: [
                            Text(odometerLvl,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                  height: Orientations().isLandscape(context)
                                      ? 40
                                      : 36,
                                  width: Orientations().isLandscape(context)
                                      ? 260
                                      : 220,
                                  child: empty
                                      ? _valueTextFormBuild(0, _odoReader,
                                          TextInputType.number, km)
                                      : _buildInactiveTextField(
                                          _odoReader,
                                          "km",
                                        )),
                            )
                          ]),
                          TableRow(children: [
                            SizedBox(height: columnSpacing(context)),
                            SizedBox(height: columnSpacing(context))
                          ]),
                          TableRow(children: [
                            Text(totalKM,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                  height: Orientations().isLandscape(context)
                                      ? 40
                                      : 36,
                                  width: Orientations().isLandscape(context)
                                      ? 260
                                      : 220,
                                  child: empty
                                      ? _valueTextFormBuild(
                                          1, _totalKM, TextInputType.number, km)
                                      : _buildInactiveTextField(
                                          _totalKM,
                                          km,
                                        )),
                            )
                          ]),
                          TableRow(children: [
                            SizedBox(height: columnSpacing(context)),
                            SizedBox(height: columnSpacing(context))
                          ]),
                          TableRow(children: [
                            Text(
                              odometerFunc,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: greyCustom,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                                height: Orientations().isLandscape(context)
                                    ? 40
                                    : 36,
                                width: Orientations().isLandscape(context)
                                    ? 200
                                    : 100,
                                child: empty
                                    ? Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _buttonVal[0] = 1;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: _buttonVal[0],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _buttonVal[0] =
                                                        value as int;
                                                  });
                                                },
                                                activeColor: green,
                                              ),
                                              Text(yes),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: Orientations()
                                                    .isLandscape(context)
                                                ? 40
                                                : 30),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _buttonVal[0] = 2;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Radio(
                                                  value: 2,
                                                  groupValue: _buttonVal[0],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _buttonVal[0] =
                                                          value as int;
                                                    });
                                                  },
                                                  activeColor: green),
                                              Text(no),
                                            ],
                                          ),
                                        )
                                      ])
                                    : _buildInactiveRadio(_odometer, yes, no))
                          ]),
                        ]))),
            const SizedBox(height: 30),
            // #CONTAINER 3
            Container(
                alignment: Alignment.center,
                height: Orientations().isLandscape(context)
                    ? (Sizes().screenHeight(context) * 0.42)
                    : (Sizes().screenHeight(context) * 0.3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                          color: barShadowColor,
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: 2)
                    ]),
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: Orientations().isLandscape(context)
                            ? const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(2),
                              }
                            : const {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1)
                              },
                        border: TableBorder.all(color: transparent),
                        children: [
                          TableRow(children: [
                            Orientations().isLandscape(context)
                                ? Text(dieselFill,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: greyCustom,
                                        fontWeight: FontWeight.w400))
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(dieselFill,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: greyCustom,
                                              fontWeight: FontWeight.w400)),
                                      const SizedBox(height: 70)
                                    ],
                                  ),
                            Orientations().isLandscape(context)
                                ? Row(
                                    children: [
                                      SizedBox(
                                          height: Orientations()
                                                  .isLandscape(context)
                                              ? 40
                                              : 36,
                                          width: Orientations()
                                                  .isLandscape(context)
                                              ? 260
                                              : 220,
                                          child: empty
                                              ? _valueTextFormBuild(2, _diesel,
                                                  TextInputType.number, litre)
                                              : _buildInactiveTextField(
                                                  _diesel,
                                                  litre,
                                                )),
                                      const SizedBox(width: 20),
                                      SizedBox(
                                          height: Orientations()
                                                  .isLandscape(context)
                                              ? 40
                                              : 36,
                                          width: Orientations()
                                                  .isLandscape(context)
                                              ? 260
                                              : 220,
                                          child: empty
                                              ? _valueTextFormBuild(3, _rm,
                                                  TextInputType.number, rm)
                                              : _buildInactiveTextField(
                                                  _rm,
                                                  rm,
                                                ))
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 36,
                                          width: 220,
                                          child: empty
                                              ? _valueTextFormBuild(2, _diesel,
                                                  TextInputType.number, litre)
                                              : _buildInactiveTextField(
                                                  _diesel,
                                                  litre,
                                                )),
                                      const SizedBox(height: 18),
                                      SizedBox(
                                          height: 36,
                                          width: 220,
                                          child: empty
                                              ? _valueTextFormBuild(3, _rm,
                                                  TextInputType.number, rm)
                                              : _buildInactiveTextField(
                                                  _rm,
                                                  rm,
                                                )),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                          ]),
                          TableRow(children: [
                            Text(passReceipt,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: Orientations().isLandscape(context)
                                  ? empty
                                      ? 40
                                      : 46
                                  : 36,
                              child: empty
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _buttonVal[1] = 1;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: _buttonVal[1],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _buttonVal[1] =
                                                        value as int;
                                                  });
                                                },
                                                activeColor: green,
                                              ),
                                              Text(yes),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: Orientations()
                                                    .isLandscape(context)
                                                ? 40
                                                : 30),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _buttonVal[1] = 2;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Radio(
                                                  value: 2,
                                                  groupValue: _buttonVal[1],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _buttonVal[1] =
                                                          value as int;
                                                    });
                                                  },
                                                  activeColor: green),
                                              Text(no),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : _buildInactiveRadio(_receipt, yes, no),
                            )
                          ]),
                          TableRow(children: [
                            Text(fleetCard,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(
                                height: Orientations().isLandscape(context)
                                    ? 40
                                    : 36,
                                child: empty
                                    ? Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _buttonVal[2] = 1;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: _buttonVal[2],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _buttonVal[2] =
                                                        value as int;
                                                  });
                                                },
                                                activeColor: green,
                                              ),
                                              Text(yes),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: Orientations()
                                                    .isLandscape(context)
                                                ? 40
                                                : 30),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _buttonVal[2] = 2;
                                              });
                                            },
                                            child: Row(children: [
                                              Radio(
                                                  value: 2,
                                                  groupValue: _buttonVal[2],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _buttonVal[2] =
                                                          value as int;
                                                    });
                                                  },
                                                  activeColor: green),
                                              Text(no),
                                            ]))
                                      ])
                                    : _buildInactiveRadio(_fleet, yes, no))
                          ]),
                          TableRow(children: [
                            Text(cardNo,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: Orientations().isLandscape(context)
                                    ? 40
                                    : 36,
                                width: Orientations().isLandscape(context)
                                    ? 260
                                    : 220,
                                child: empty
                                    ? _valueTextFormBuild(4, _kad,
                                        TextInputType.number, "", false)
                                    : _buildInactiveTextField(_kad, "", false),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Text(fuelLvl,
                                textAlign: TextAlign.left,
                                style:
                                    TextStyle(fontSize: 16, color: greyCustom)),
                            Container(
                                alignment: Alignment.bottomLeft,
                                height: 70,
                                padding: const EdgeInsets.only(top: 18),
                                child: Row(children: [
                                  Container(
                                      width: Orientations().isLandscape(context)
                                          ? (Sizes().screenWidth(context) * 0.5)
                                          : (Sizes().screenWidth(context) *
                                              0.4),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular((10)),
                                        ),
                                        gradient: LinearGradient(
                                            colors: empty
                                                ? [
                                                    lightPink,
                                                    lightGreen,
                                                  ]
                                                : const [
                                                    Color(0xFFDCD7D7),
                                                    Color(0xFFE4EFE4),
                                                  ],
                                            begin: const FractionalOffset(0, 0),
                                            end: const FractionalOffset(1, 1),
                                            stops: const [0, 1],
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(width: 10),
                                            Transform(
                                              alignment: Alignment.center,
                                              transform:
                                                  Matrix4.rotationY(math.pi),
                                              child: Icon(
                                                Icons.local_gas_station,
                                                color: empty
                                                    ? red
                                                    : const Color(0xFFD5A2A2),
                                                size: Orientations()
                                                        .isLandscape(context)
                                                    ? 30
                                                    : 20,
                                              ),
                                            ),
                                            Expanded(
                                              child: SliderTheme(
                                                data: SliderTheme.of(context)
                                                    .copyWith(
                                                  disabledActiveTrackColor:
                                                      grey500,
                                                  disabledThumbColor: grey500,
                                                  activeTrackColor:
                                                      white.withOpacity(1),
                                                  inactiveTrackColor:
                                                      white.withOpacity(.5),
                                                  trackShape:
                                                      const RoundedRectSliderTrackShape(),
                                                  trackHeight: 5,
                                                  thumbShape:
                                                      const RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              12),
                                                  thumbColor: white,
                                                  overlayColor:
                                                      green.withAlpha(32),
                                                  overlayShape:
                                                      const RoundSliderOverlayShape(
                                                          overlayRadius: 28),
                                                  tickMarkShape:
                                                      const RoundSliderTickMarkShape(),
                                                  activeTickMarkColor: white,
                                                  inactiveTickMarkColor:
                                                      greenGrey,
                                                  valueIndicatorShape:
                                                      const PaddleSliderValueIndicatorShape(),
                                                  valueIndicatorColor: green600,
                                                  valueIndicatorTextStyle:
                                                      TextStyle(
                                                    color: white,
                                                  ),
                                                ),
                                                child: Slider(
                                                  min: 0,
                                                  max: 100,
                                                  value: _fuelValue,
                                                  divisions: 4,
                                                  label:
                                                      '${_fuelValue.round()}%',
                                                  semanticFormatterCallback:
                                                      (double newValue) {
                                                    return '${_fuelValue.round()}';
                                                  },
                                                  onChanged: empty
                                                      ? (value) {
                                                          setState(() {
                                                            _fuelValue = value;
                                                          });
                                                        }
                                                      : null,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(
                                                Icons.local_gas_station,
                                                color: empty
                                                    ? green800
                                                    : const Color(0xFF97C497),
                                                size: Orientations()
                                                        .isLandscape(context)
                                                    ? 30
                                                    : 20,
                                              ),
                                            ),
                                            Text('${_fuelValue.round()}%',
                                                style: TextStyle(
                                                    color:
                                                        empty ? white : grey500,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w900)),
                                            const SizedBox(width: 10),
                                          ]))
                                ]))
                          ])
                        ]))),
            const SizedBox(height: 30),
            // #CONTAINER 4
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                          color: barShadowColor,
                          offset: const Offset(1, 1),
                          blurRadius: 8,
                          spreadRadius: 0.5)
                    ]),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent),
                  child: ExpansionTile(
                    key: GlobalKey(),
                    tilePadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                    initiallyExpanded: formExpandFlagDefault,
                    onExpansionChanged: (d) {
                      Timer(const Duration(milliseconds: 300), () {
                        setState(() {
                          formExpandFlag[0] = !d;
                          formExpandFlagDefault = d;
                        });
                      });
                    },
                    title: Text("1. Dokumen Perjalanan (${_totalEntered[0]}/3)",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    collapsedBackgroundColor: tabBoxColor,
                    backgroundColor: activeColor,
                    textColor: white,
                    iconColor: white,
                    collapsedTextColor: greyCustom,
                    collapsedIconColor: greyCustom,
                    children: <Widget>[
                      Container(
                        color: white,
                        padding: Orientations().isTabletPortrait(context)
                            ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                            : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                        child: Column(
                          children: [
                            Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(1),
                                },
                                border: TableBorder.all(color: transparent),
                                children: [
                                  _tableRowBuild('1.1. Puspakom Disc', 3,
                                      _puspakom, has, dont),
                                  _tableRowBuild(
                                      '1.2. Cukai Jalan', 4, _tax, has, dont),
                                  _tableRowBuild('1.3. Lesen pembawa A/Permit',
                                      5, _lesen, has, dont),
                                ]),
                            Container(
                              color: white,
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                              height: 100,
                              child: empty
                                  ? _textFieldBuild(0)
                                  : _inactiveTextFieldBuild(0),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => green800),
                                    backgroundColor:
                                        MaterialStateProperty.all(greenCustom)),
                                onPressed: () {
                                  Timer(const Duration(milliseconds: 450), () {
                                    setState(() {
                                      formExpandFlagDefault =
                                          !formExpandFlagDefault;
                                      formExpandFlag[0] =
                                          !formExpandFlagDefault;
                                    });
                                  });
                                },
                                child: const Text("Seterusnya"),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            const SizedBox(height: 5),
            // #CONTAINER 5
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[0],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 300), () {
                            setState(() {
                              formExpandFlagDefault = !d;
                              formExpandFlag[0] = d;
                            });
                          });
                        },
                        title: Text(
                            "2. Pemeriksaan Tayar (${_totalEntered[1]}/3)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(
                                children: [
                                  Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(1),
                                      },
                                      border:
                                          TableBorder.all(color: transparent),
                                      children: [
                                        _tableRowBuild(
                                            '2.1. Bahagian bunga tayar diperiksa',
                                            6,
                                            _tayar,
                                            has,
                                            dont),
                                        _tableRowBuild(
                                            '2.2. Nut tayar diperiksa',
                                            7,
                                            _nut,
                                            has,
                                            dont),
                                        _tableRowBuild(
                                            '2.3. Tekanan angin diperiksa',
                                            8,
                                            _angin,
                                            has,
                                            dont),
                                      ]),
                                  Container(
                                    color: white,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                    height: 100,
                                    child: empty
                                        ? _textFieldBuild(1)
                                        : _inactiveTextFieldBuild(1),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: BorderSide(
                                                    color: grey500, //color
                                                  ),
                                                ),
                                              ),
                                              overlayColor: MaterialStateColor
                                                  .resolveWith(
                                                      (states) => grey200),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      white)),
                                          onPressed: () {
                                            Timer(
                                                const Duration(
                                                    milliseconds: 450), () {
                                              setState(() {
                                                formExpandFlagDefault = true;
                                                formExpandFlag[0] = false;
                                              });
                                            });
                                          },
                                          child: Text("Sebelum",
                                              style: TextStyle(
                                                  color: blackCustom)),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                              ),
                                              overlayColor: MaterialStateColor
                                                  .resolveWith(
                                                      (states) => green800),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      greenCustom)),
                                          onPressed: () {
                                            Timer(
                                                const Duration(
                                                    milliseconds: 450), () {
                                              setState(() {
                                                formExpandFlag[0] = false;
                                                formExpandFlag[1] = true;
                                              });
                                            });
                                          },
                                          child: const Text("Seterusnya"),
                                        )
                                      ])
                                ],
                              ))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 6
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[1],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[0] = !d;
                              formExpandFlag[1] = d;
                            });
                          });
                        },
                        title: Text(
                            "3. Sistem Mampatan (${_totalEntered[2]}/5)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '3.1. Sistem Hidraulik & Minyak',
                                          9,
                                          _hidraulik,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '3.2. PTD/PAM', 10, _ptd, has, dont),
                                      _tableRowBuild(
                                          '3.3. Semua penutup diperiksa',
                                          11,
                                          _penutup,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '3.4. Buang air dalam tabung angin',
                                          12,
                                          _airTabung,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '3.5. Sistem LEACHATE diperiksa',
                                          13,
                                          _leachate,
                                          has,
                                          dont)
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(2)
                                      : _inactiveTextFieldBuild(2),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[0] = true;
                                              formExpandFlag[1] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[1] =
                                                  !formExpandFlag[1];
                                              formExpandFlag[2] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 7
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[2],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[1] = !d;
                              formExpandFlag[2] = d;
                            });
                          });
                        },
                        title: Text("4. Sistem Lampu (${_totalEntered[3]}/6)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '4.1. Lampu utama dan belakang diperiksa',
                                          14,
                                          _lampuUtama,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '4.2. Lampu berhenti diperiksa',
                                          15,
                                          _lampuBerhenti,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '4.3. Lampu isyarat diperiksa',
                                          16,
                                          _lampuIsyarat,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '4.4. Lampu kecemasan diperiksa (Hazard Light)',
                                          17,
                                          _lampuKecemasan,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '4.5. Lampu isyarat sedang bekerja diperiksa (Beacon Light)',
                                          18,
                                          _lampuBeacon,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '4.6. Lampu nombor plet diperiksa',
                                          19,
                                          _lampuPlet,
                                          has,
                                          dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(3)
                                      : _inactiveTextFieldBuild(3),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[1] = true;
                                              formExpandFlag[2] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[2] =
                                                  !formExpandFlag[2];
                                              formExpandFlag[3] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 8
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[3],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[2] = !d;
                              formExpandFlag[3] = d;
                            });
                          });
                        },
                        title: Text(
                            "5. Sistem Enjin dan Driveline (${_totalEntered[4]}/16)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '5.1. Periksa dipstik minyak enjin',
                                          20,
                                          _dipstik,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.2. Periksa paras minyak enjin',
                                          21,
                                          _parasEnjin,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.3. Periksa penutup minyak enjin',
                                          22,
                                          _penutupEnjin,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.4. Periksa paras air radiator',
                                          23,
                                          _airRadiator,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.5. Periksa paras expansion tank',
                                          24,
                                          _expansionTank,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.6. Periksa dipstik minyak Auto Transmission',
                                          25,
                                          _dipstikAuto,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.7. Periksa paras minyak Auto Transmission',
                                          26,
                                          _parasAuto,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.8. Periksa paras minyak power steering',
                                          27,
                                          _parasPower,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.9. Periksa paras minyak brek',
                                          28,
                                          _parasMykBrek,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.10. Nyatakan sistem cengkaman sistem brek',
                                          29,
                                          _sisCengkaman,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.11. Periksa paras minyak sistem clutch',
                                          30,
                                          _parasClutch,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.12. Adakah sistem clutch berfungsi dengan baik',
                                          31,
                                          _sisClutch,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.13. Periksa paras air wiper tank',
                                          32,
                                          _airWiper,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.14. Periksa keadaan wiper (Kiri & Kanan)',
                                          33,
                                          _wiper,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.15. Periksa paras air bateri No. 1 & No. 2',
                                          34,
                                          _airBateri,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '5.16. Periksa keadaan asap ekzos',
                                          35,
                                          _asapEkzos,
                                          has,
                                          dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(4)
                                      : _inactiveTextFieldBuild(4),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[2] = true;
                                              formExpandFlag[3] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[3] =
                                                  !formExpandFlag[3];
                                              formExpandFlag[4] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 9
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[4],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[3] = !d;
                              formExpandFlag[4] = d;
                            });
                          });
                        },
                        title: Text(
                            "6. Bahagian Luaran (${_totalEntered[5]}/2)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '6.1. Cermin pandang belakang dan sisi',
                                          36,
                                          _cermin,
                                          has,
                                          dont),
                                      _tableRowBuild('6.2. Hon diperiksa', 37,
                                          _hon, has, dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(5)
                                      : _inactiveTextFieldBuild(5),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[3] = true;
                                              formExpandFlag[4] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[4] =
                                                  !formExpandFlag[4];
                                              formExpandFlag[5] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 10
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[5],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[4] = !d;
                              formExpandFlag[5] = d;
                            });
                          });
                        },
                        title: Text(
                            "7. Peralatan Keselamatan (${_totalEntered[6]}/3)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '7.1. Penanda amaran kecemasan (Triangle Reflector)',
                                          38,
                                          _penanda,
                                          has,
                                          dont),
                                      _tableRowBuild('7.2. Alat pemadam api',
                                          39, _pemadamApi, has, dont),
                                      _tableRowBuild(
                                          '7.3. Kotak kecemasan (First Aid Kit)',
                                          40,
                                          _firstAid,
                                          has,
                                          dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(6)
                                      : _inactiveTextFieldBuild(6),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[4] = true;
                                              formExpandFlag[5] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[5] =
                                                  !formExpandFlag[5];
                                              formExpandFlag[6] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 11
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[6],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[5] = !d;
                              formExpandFlag[6] = d;
                            });
                          });
                        },
                        title: Text(
                            "8. Kebersihan Kenderaan (${_totalEntered[7]}/2)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '8.1. Kebersihan dalam kokpit (kabin)',
                                          41,
                                          _kabin,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '8.2. Kebersihan sekitar luaran badan trak',
                                          42,
                                          _badanTrak,
                                          has,
                                          dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(7)
                                      : _inactiveTextFieldBuild(7),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[5] = true;
                                              formExpandFlag[6] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[6] =
                                                  !formExpandFlag[6];
                                              formExpandFlag[7] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 12
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[7],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[6] = !d;
                              formExpandFlag[7] = d;
                            });
                          });
                        },
                        title: Row(
                          children: [
                            const Text("9. Kebersihan Bin Lifter ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            ValueListenableBuilder(
                              valueListenable: attendanceMainCard,
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return Text("(${_totalEntered[8]}/1)",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500));
                              },
                            ),
                          ],
                        ),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '9.1. Bin lifter dicuci oleh pemandu',
                                          43,
                                          _binLifter,
                                          has,
                                          dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(8)
                                      : _inactiveTextFieldBuild(8),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[6] = true;
                                              formExpandFlag[7] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[7] =
                                                  !formExpandFlag[7];
                                              formExpandFlag[8] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            //CONTAINER 13
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[8],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[7] = !d;
                              formExpandFlag[8] = d;
                            });
                          });
                        },
                        title: Text("10. Kemalangan (${_totalEntered[9]}/2)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '10.1. Adakah anda terlibat dengan mana-mana kemalangan',
                                          44,
                                          _kemalangan,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '10.2. Nombor kenderaan pihak ketiga',
                                          45,
                                          _thirdParty,
                                          has,
                                          dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(9)
                                      : _inactiveTextFieldBuild(9),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[7] = true;
                                              formExpandFlag[8] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => green800),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    greenCustom)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[8] =
                                                  !formExpandFlag[8];
                                              formExpandFlag[9] = true;
                                            });
                                          });
                                        },
                                        child: const Text("Seterusnya"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5),
            // #CONTAINER 14
            Container(
                alignment: Alignment.center,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      spreadRadius: 0.5)
                ]),
                child: Theme(
                    data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent),
                    child: ExpansionTile(
                        key: GlobalKey(),
                        tilePadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        initiallyExpanded: formExpandFlag[9],
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formExpandFlag[8] = !d;
                              formExpandFlag[9] = d;
                            });
                          });
                        },
                        title: Text(
                            "11. Fizikal Kenderaan (${_totalEntered[10]}/2)",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        collapsedBackgroundColor: tabBoxColor,
                        backgroundColor: activeColor,
                        textColor: white,
                        iconColor: white,
                        collapsedTextColor: greyCustom,
                        collapsedIconColor: greyCustom,
                        children: <Widget>[
                          Container(
                              color: white,
                              padding: Orientations().isTabletPortrait(context)
                                  ? const EdgeInsets.fromLTRB(35, 20, 35, 20)
                                  : const EdgeInsets.fromLTRB(56, 20, 56, 20),
                              child: Column(children: [
                                Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1),
                                    },
                                    border: TableBorder.all(
                                        color: Colors.transparent),
                                    children: [
                                      _tableRowBuild(
                                          '11.1. Sampah dalam kompaktor',
                                          46,
                                          _sampah,
                                          has,
                                          dont),
                                      _tableRowBuild(
                                          '11.2. Keadaan fizikal/kecatatan pada trak',
                                          47,
                                          _fizikal,
                                          has,
                                          dont),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: empty
                                      ? _textFieldBuild(10)
                                      : _inactiveTextFieldBuild(10),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                side: BorderSide(
                                                  color: grey500, //color
                                                ),
                                              ),
                                            ),
                                            overlayColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => grey200),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    white)),
                                        onPressed: () {
                                          Timer(
                                              const Duration(milliseconds: 450),
                                              () {
                                            setState(() {
                                              formExpandFlag[8] = true;
                                              formExpandFlag[9] = false;
                                            });
                                          });
                                        },
                                        child: Text("Sebelum",
                                            style:
                                                TextStyle(color: blackCustom)),
                                      ),
                                      const SizedBox(width: 20),
                                      empty
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty
                                                          .all(0),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0)),
                                                  ),
                                                  overlayColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  green800),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          greenCustom)),
                                              onPressed: () {
                                                _handleSubmittedData(context);
                                              },
                                              child: const Text("Hantar"),
                                            )
                                          : const SizedBox(),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5)
          ]),
        )),
      ),
    );
  }

  /// Disabled Radio Button (fetch data from db)
  Row _buildInactiveRadio(String dbData, String yes, String no,
      [MainAxisAlignment? align = MainAxisAlignment.start]) {
    return Row(
      mainAxisAlignment: align!,
      children: [
        Row(
          children: [
            Stack(alignment: AlignmentDirectional.center, children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: transparent,
                    border: Border.all(color: grey300),
                    borderRadius: BorderRadius.circular(30)),
              ),
              dbData == yes
                  ? SizedBox(
                      height: 12,
                      width: 12,
                      child: CircleAvatar(backgroundColor: grey300, radius: 16),
                    )
                  : const SizedBox()
            ]),
            const SizedBox(width: 14),
            Text(
              yes,
              style: TextStyle(color: dbData == yes ? blackCustom : grey300),
            ),
          ],
        ),
        const SizedBox(width: 50),
        Row(
          children: [
            Stack(alignment: AlignmentDirectional.center, children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: transparent,
                    border: Border.all(color: grey300),
                    borderRadius: BorderRadius.circular(30)),
              ),
              dbData == no
                  ? SizedBox(
                      height: 12,
                      width: 12,
                      child: CircleAvatar(backgroundColor: grey300, radius: 16),
                    )
                  : const SizedBox()
            ]),
            const SizedBox(width: 14),
            Text(no,
                style: TextStyle(color: dbData == no ? blackCustom : grey300)),
          ],
        )
      ],
    );
  }

  /// Value TextField (Card 2 ~ Card 3 input)
  Form _valueTextFormBuild(
      int idx, TextEditingController controller, TextInputType type,
      [String? label = "", bool? icon = true]) {
    return Form(
        key: _valueKey[idx],
        child: TextFormField(
          controller: controller,
          cursorColor: greenCustom,
          cursorWidth: 1.2,
          keyboardType: type,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                  color: borderTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              //isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              isDense: true,
              suffixIconConstraints:
                  icon! ? const BoxConstraints(maxWidth: 50) : null,
              suffixIcon: icon
                  ? SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                left: BorderSide(
                                    color: borderTextColor, width: 0.5),
                              )),
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.centerRight,
                              child: Text(label ?? "")),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: Orientations().isLandscape(context) ? 40 : 36),
              errorStyle: const TextStyle(height: 0),
              focusColor: greenCustom,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusCircular),
                  borderSide: BorderSide(width: 0.8, color: redCustom)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadiusCircular),
                  borderSide: BorderSide(
                      width: 0.8,
                      color: controller.text == ""
                          ? borderTextColor
                          : greenCustom)),
              border: const OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: greenCustom),
                borderRadius: BorderRadius.circular(borderRadiusCircular),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.8, color: greenCustom),
                borderRadius: BorderRadius.circular(borderRadiusCircular),
              )),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "";
            }
            return null;
          },
        ));
  }

  /// Catatan TextField
  Form _textFieldBuild(int idx) {
    return Form(
      key: _textKeys[idx],
      child: TextField(
        controller: _remarkController[idx],
        maxLines: 5,
        cursorWidth: 1.2,
        cursorColor: greenCustom,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          _remarkController[idx].text = value.toString();
        },
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            focusColor: greenCustom,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadiusCircular),
                borderSide: BorderSide(
                    width: 0.8,
                    color: _remarkController[idx].text == ""
                        ? borderTextColor
                        : greenCustom)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greenCustom),
              borderRadius: BorderRadius.circular(borderRadiusCircular),
            ),
            labelText: 'Catatan',
            alignLabelWithHint: true,
            labelStyle: TextStyle(color: grey400, fontSize: 14)),
      ),
    );
  }

  /// Radio Button in Card 4 ~ Card 15
  TableRow _tableRowBuild(String title, int idx,
      [String? label = "", String? has = "", String? dont = ""]) {
    return TableRow(children: [
      Text(title,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: blackCustom)),
      SizedBox(
          height: 42,
          child: empty
              ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _buttonVal[idx],
                        onChanged: (value) {
                          setState(() {
                            _buttonVal[idx] = value as int;
                          });
                        },
                        activeColor: green,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _buttonVal[idx] = 1;
                          });
                        },
                        child: Text(has!),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: Orientations().isTabletPortrait(context) ? 0 : 30),
                  Row(children: [
                    Radio(
                        value: 2,
                        groupValue: _buttonVal[idx],
                        onChanged: (value) {
                          setState(() {
                            _buttonVal[idx] = value as int;
                          });
                        },
                        activeColor: green),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _buttonVal[idx] = 2;
                        });
                      },
                      child: Text(dont!),
                    )
                  ]),
                  SizedBox(
                      width: Orientations().isTabletPortrait(context) ? 10 : 0)
                ])
              : _buildInactiveRadio(label!, has!, dont!, MainAxisAlignment.end))
    ]);
  }

  /// Disabled Catatan TextField
  Form _inactiveTextFieldBuild(int idx) {
    return Form(
      key: _textKeys[idx],
      child: TextField(
        controller: _remarkController[idx],
        maxLines: 5,
        readOnly: true,
        enabled: false,
        cursorWidth: 1.2,
        cursorColor: greenCustom,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          _remarkController[idx].text = value.toString();
        },
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: borderTextColor,
              ),
              borderRadius: BorderRadius.circular(borderRadiusCircular),
              //gapPadding: 6.0,
            ),
            labelText: 'Catatan',
            alignLabelWithHint: true,
            labelStyle: TextStyle(color: grey400, fontSize: 14)),
      ),
    );
  }

  /// Disabled TextField for value in Card 2 & Card 3 input
  TextFormField _buildInactiveTextField(TextEditingController controller,
      [String? label = "", bool? icon = true]) {
    return TextFormField(
        controller: controller,
        readOnly: true,
        enabled: false,
        style: TextStyle(color: blackCustom, fontSize: 15),
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            hintText: '0',
            hintStyle: TextStyle(
                color: borderTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            //isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            isDense: true,
            suffixIconConstraints:
                icon! ? const BoxConstraints(maxWidth: 50) : null,
            suffixIcon: icon
                ? SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(
                                  color: borderTextColor, width: 0.5),
                            )),
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.centerRight,
                            child: Text(label ?? "")),
                      ],
                    ),
                  )
                : SizedBox(
                    height: Orientations().isLandscape(context) ? 40 : 36),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: borderTextColor,
              ),
              borderRadius: BorderRadius.circular(borderRadiusCircular),
              //gapPadding: 6.0,
            )));
  }

  _loadRadioButtonStrVal() {
    for (var a = 0; a < _buttonVal.length; a++) {
      if (a == 0 || a == 1 || a == 2) {
        _buttonVal[a] == 1
            ? _buttonStrVal[a] = "Ya"
            : _buttonVal[a] == 2
                ? _buttonStrVal[a] = "Tidak"
                : _buttonStrVal[a] = "-";
      } else {
        _buttonVal[a] == 1
            ? _buttonStrVal[a] = "Ada"
            : _buttonVal[a] == 2
                ? _buttonStrVal[a] = "Tiada"
                : _buttonStrVal[a] = "-";
      }
    }
  }

  _loadRadioButton() {
    _incompleteRadioButton = false;
    int data = 0;
    int n = 0;
    // List<int> _groupButtonVal_0 = List.generate(3, (index) => index = _buttonVal[index]);

    List<int> groupButtonVal_1 =
        List.generate(3, (index) => index = _buttonVal[index + 3]);
    List<int> groupButtonVal_2 =
        List.generate(3, (index) => index = _buttonVal[index + 6]);
    List<int> groupButtonVal_3 =
        List.generate(5, (index) => index = _buttonVal[index + 9]);
    List<int> groupButtonVal_4 =
        List.generate(6, (index) => index = _buttonVal[index + 14]);
    List<int> groupButtonVal_5 =
        List.generate(16, (index) => index = _buttonVal[index + 20]);
    List<int> groupButtonVal_6 =
        List.generate(2, (index) => index = _buttonVal[index + 36]);
    List<int> groupButtonVal_7 =
        List.generate(3, (index) => index = _buttonVal[index + 38]);
    List<int> groupButtonVal_8 =
        List.generate(2, (index) => index = _buttonVal[index + 41]);
    List<int> groupButtonVal_9 =
        List.generate(1, (index) => index = _buttonVal[index + 43]);
    List<int> groupButtonVal_10 =
        List.generate(2, (index) => index = _buttonVal[index + 44]);
    List<int> groupButtonVal_11 =
        List.generate(2, (index) => index = _buttonVal[index + 46]);
    List allGroup = [
      groupButtonVal_1,
      groupButtonVal_2,
      groupButtonVal_3,
      groupButtonVal_4,
      groupButtonVal_5,
      groupButtonVal_6,
      groupButtonVal_7,
      groupButtonVal_8,
      groupButtonVal_9,
      groupButtonVal_10,
      groupButtonVal_11
    ];

    for (var a = 0; a < allGroup.length; a++) {
      // print("data [$a]: ${allGroup[a]}");
      // print("length [$a]: ${allGroup[a].length}");
      for (var b = 0; b < allGroup[a].length; b++) {
        data = allGroup[a][b];
        if (data == -1) {
          n++;
          _incompleteRadioButton = true;
          _colorResult[a] = const Color(0x96FF2E2E);
        } else {
          _colorResult[a] = const Color(0x8E349813);
        }
      }
      int totalLength = allGroup[a].length;
      int filled = totalLength - n;
      _totalEntered[a] = filled.toString();
      n = 0;
    }
  }

  _handleSubmittedData(context) {
    _loadRadioButtonStrVal();
    _loadRadioButton();
    for (var i = 0; i < _valueKey.length; i++) {
      final FormState? form = _valueKey[i].currentState;
      if (form!.validate() && !_incompleteRadioButton) {
        form.save();
        _valid = true;
      } else {
        _valid = false;
      }
    }

    if (_valid) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return showAlertDialog(
                context,
                confirmation,
                widget.before
                    ? Orientations().isTabletPortrait(context)
                        ? "Hantar borang semakan kenderaan sekarang (sebelum keluar) sekarang? Pastikan maklumat yang diisi adalah tepat."
                        : "Hantar borang semakan kenderaan sekarang (sebelum \nkeluar) sekarang? Pastikan maklumat yang diisi \nadalah tepat."
                    : Orientations().isTabletPortrait(context)
                        ? "Hantar borang semakan kenderaan sekarang (selepas balik) sekarang? Pastikan maklumat yang diisi adalah tepat."
                        : "Hantar borang semakan kenderaan sekarang (selepas \nbalik) sekarang? Pastikan maklumat yang diisi \nadalah tepat.",
                cancel,
                submit);
          }).then((actionText) async {
        if (actionText == submit) {
          final vcBody = {
            "vcItem": {
              "odometer": {
                "bacaanOdo": _odoReader.text,
                "odoFungsi": _buttonStrVal[0],
                "totalKM": _totalKM.text,
                "noAkbk": "-"
              },
              "fuel": {
                "liter": _diesel.text,
                "rm": _rm.text,
                "resit": _buttonStrVal[1],
                "fleetCard": _buttonStrVal[2],
                "noFleetCard": _kad.text,
                "fuelLevel": _fuelValue.toString()
              },
              "document": {
                "puspakomDisc": _buttonStrVal[3],
                "cukaiJalan": _buttonStrVal[4],
                "lesen": _buttonStrVal[5],
                "remarks": _remarkController[0].text
              },
              "tyre": {
                "bungaTayar": _buttonStrVal[6],
                "nutTayar": _buttonStrVal[7],
                "tekananTayar": _buttonStrVal[8],
                "remarks": _remarkController[1].text
              },
              "mampatan": {
                "sistemHidraulik": _buttonStrVal[9],
                "ptd/pam": _buttonStrVal[10],
                "allPenutup": _buttonStrVal[11],
                "buangAir": _buttonStrVal[12],
                "leachate": _buttonStrVal[13],
                "remarks": _remarkController[2].text
              },
              "light": {
                "lampuUtama": _buttonStrVal[14],
                "lampuHenti": _buttonStrVal[15],
                "lampuIsyarat": _buttonStrVal[16],
                "lampuKecemasan": _buttonStrVal[17],
                "lampuBeacon": _buttonStrVal[18],
                "lampuPlet": _buttonStrVal[19],
                "remarks": _remarkController[3].text
              },
              "engine": {
                "dipstikMinyakEnjin": _buttonStrVal[20],
                "parasMinyak": _buttonStrVal[21],
                "penutupMinyak": _buttonStrVal[22],
                "parasAirRadiator": _buttonStrVal[23],
                "parasExpansion": _buttonStrVal[24],
                "dipstikMintakTransmission": _buttonStrVal[25],
                "parasMinyakTransmission": _buttonStrVal[26],
                "parasMinyakSteering": _buttonStrVal[27],
                "parasMinyakBrek": _buttonStrVal[28],
                "sistemCengkamanSistemBrek": _buttonStrVal[29],
                "parasMinyakClutch": _buttonStrVal[30],
                "sistemClutch": _buttonStrVal[31],
                "parasAirWiper": _buttonStrVal[32],
                "keadaanWiper": _buttonStrVal[33],
                "parasAirBateri": _buttonStrVal[34],
                "asapEkzos": _buttonStrVal[35],
                "remarks": _remarkController[4].text
              },
              "outside": {
                "cermin": _buttonStrVal[36],
                "hon": _buttonStrVal[37],
                "remarks": _remarkController[5].text
              },
              "safetyThings": {
                "penandaKecemasan": _buttonStrVal[38],
                "pemadamApi": _buttonStrVal[39],
                "kotakKecemasan": _buttonStrVal[40],
                "remarks": _remarkController[6].text
              },
              "cleanliness": {
                "dalamKokpit": _buttonStrVal[41],
                "luarBadanTrak": _buttonStrVal[42],
                "remarks": _remarkController[7].text
              },
              "binLifterCleanliness": {
                "binDicuci": _buttonStrVal[43],
                "remarks": _remarkController[8].text
              },
              "accident": {
                "terlibatKemalangan": _buttonStrVal[44],
                "noKenderaanPartiKetiga": _buttonStrVal[45],
                "remarks": _remarkController[9].text
              },
              "vehiclePhysical": {
                "sampah": _buttonStrVal[46],
                "kecacatan": _buttonStrVal[47],
                "remarks": _remarkController[10].text
              }
            }
          };

          setState(() {
            isLoading = true;
          });

          String result = await VehicleChecklistApi.uploadVehicleChecklistData(
              widget.before ? '1' : '0',
              widget.before
                  ? null
                  : widget.compactorData!.data!.vehicleChecklistId!.id,
              vcBody);
          setState(() {
            isLoading = false;
          });
          if (result == 'ok') {
            if (completedFirstVc && !completedSecondVc) {
              completedSecondVc = true;
            }
            completedFirstVc = true;
            Navigator.pop(context, true);
            setState(() {
              //scheduleVcStatus.value = 1;
              vcStatus = 1;
              refresh.value = !refresh.value;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showLottieAlertDialog(
                    context,
                    _textBuilder(),
                    "",
                    null,
                    null,
                  );
                });
          } else {
            showErrorToast(context,
                "Penghantaran borang semakan kenderaan tidak berjaya. Sila cuba semula!");
          }
        }
      });
    } else {
      // _valid = false;
      showErrorToast(
          context, "Sila isikan borang semakan kenderaan sebelum dihantar");
    }
  }

  Text _textBuilder() {
    return Text(
        widget.before
            ? "Borang semakan kenderaan (sebelum keluar) telah berjaya \n dihantar kepada Penyelia untuk disemak."
            : "Borang semakan kenderaan (selepas balik) telah berjaya \n dihantar kepada Penyelia untuk disemak.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: greyCustom,
            height: 1.5));
  }
}
