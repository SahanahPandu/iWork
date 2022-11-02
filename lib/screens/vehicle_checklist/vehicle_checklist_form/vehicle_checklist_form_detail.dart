import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../../config/config.dart';
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../config/string.dart';
import '../../../models/vc/vc.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import '../../../widgets/alert/alert_dialog.dart';
import '../../../widgets/alert/toast.dart';
import '../../../widgets/custom_scroll/custom_scroll.dart';

class VehicleChecklistDetail extends StatefulWidget {
  final VehicleChecklist data;

  const VehicleChecklistDetail({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistDetail> createState() => _VehicleChecklistDetailState();
}

class _VehicleChecklistDetailState extends State<VehicleChecklistDetail>
    with TickerProviderStateMixin {
  final List<GlobalKey<FormState>> _key = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  static final List<GlobalKey<FormState>> _textKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  bool _valid = false;
  bool _incompleteRadioButton = false;
  bool formOpenFlag = true;
  bool formOpenFlag2 = false;
  bool formOpenFlag3 = false;
  bool formOpenFlag4 = false;
  bool formOpenFlag5 = false;
  bool formOpenFlag6 = false;
  bool formOpenFlag7 = false;
  bool formOpenFlag8 = false;
  bool formOpenFlag9 = false;
  bool formOpenFlag10 = false;
  bool formOpenFlag11 = false;
  String _todayDate = "0";
  double _fuelValue = 20;
  final _buttonVal = List.generate(50, (index) => index = -1);
  final _keyIn = List<String>.generate(11, (index) => "0");
  final _colorResult = List<Color>.generate(11, (index) => grey400);

  @override
  void initState() {
    _todayDate = Date.getTodayDate();
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
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(1.9),
                                2: FlexColumnWidth(0.3),
                                3: FlexColumnWidth(2.4),
                                4: FlexColumnWidth(2.1),
                                5: FlexColumnWidth(0.3),
                                6: FlexColumnWidth(1.6),
                                7: FlexColumnWidth(1.8),
                              }
                            : null,
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
                            Text(widget.data.noLaluan,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackCustom,
                                    fontWeight: FontWeight.w600)),
                            const Text(' '),
                            Text(status,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Text(widget.data.status,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackCustom,
                                    fontWeight: FontWeight.w600)),
                          ]),
                          TableRow(children: [
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                            SizedBox(height: tableSpace(context)),
                          ]),
                          TableRow(children: [
                            Text(outTime,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: greyCustom,
                                    fontWeight: FontWeight.w400)),
                            Text(' --:--',
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
                            Text(widget.data.noKenderaan,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blackCustom,
                                    fontWeight: FontWeight.w600)),
                            const Text(' '),
                            const Text(' '),
                            const Text(' ')
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
                                  child: _valueTextFormBuild(
                                      0, TextInputType.number, km)),
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
                                  child: _valueTextFormBuild(
                                      1, TextInputType.number, km)),
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
                                child: Row(children: [
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
                                              _buttonVal[0] = value as int;
                                            });
                                          },
                                          activeColor: green,
                                        ),
                                        Text(yes),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: Orientations().isLandscape(context)
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
                                                _buttonVal[0] = value as int;
                                              });
                                            },
                                            activeColor: green),
                                        Text(no),
                                      ],
                                    ),
                                  )
                                ]))
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
                                          child: _valueTextFormBuild(
                                              3, TextInputType.number, litre)),
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
                                          child: _valueTextFormBuild(
                                              4, TextInputType.number, rm))
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 36,
                                          width: 220,
                                          child: _valueTextFormBuild(
                                              3, TextInputType.number, litre)),
                                      const SizedBox(height: 18),
                                      SizedBox(
                                          height: 36,
                                          width: 220,
                                          child: _valueTextFormBuild(
                                              4, TextInputType.number, rm)),
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
                              height:
                                  Orientations().isLandscape(context) ? 40 : 36,
                              child: Row(
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
                                              _buttonVal[1] = value as int;
                                            });
                                          },
                                          activeColor: green,
                                        ),
                                        Text(yes),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: Orientations().isLandscape(context)
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
                                                _buttonVal[1] = value as int;
                                              });
                                            },
                                            activeColor: green),
                                        Text(no),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                child: Row(children: [
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
                                              _buttonVal[2] = value as int;
                                            });
                                          },
                                          activeColor: green,
                                        ),
                                        Text(yes),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width: Orientations().isLandscape(context)
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
                                                _buttonVal[2] = value as int;
                                              });
                                            },
                                            activeColor: green),
                                        Text(no),
                                      ]))
                                ]))
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
                                child: _valueTextFormBuild(
                                    5, TextInputType.number, "", false),
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
                                            colors: [
                                              lightPink,
                                              lightGreen,
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
                                                color: red,
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
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _fuelValue = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(
                                                Icons.local_gas_station,
                                                color: green800,
                                                size: Orientations()
                                                        .isLandscape(context)
                                                    ? 30
                                                    : 20,
                                              ),
                                            ),
                                            Text('${_fuelValue.round()}%',
                                                style: TextStyle(
                                                    color: white,
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
                    initiallyExpanded: formOpenFlag,
                    onExpansionChanged: (d) {
                      Timer(const Duration(milliseconds: 300), () {
                        setState(() {
                          formOpenFlag2 = !d;
                          formOpenFlag = d;
                        });
                      });
                    },
                    title: Text("1. Dokumen Perjalanan (${_keyIn[0]}/3)",
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
                                  _tableRowBuild('1.1. Puspakom Disc', 3),
                                  _tableRowBuild('1.2. Cukai Jalan', 4),
                                  _tableRowBuild(
                                      '1.3. Lesen pembawa A/Permit', 5),
                                ]),
                            Container(
                              color: white,
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                              height: 100,
                              child: _textFieldBuild(0),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                    ),
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => green800),
                                    backgroundColor:
                                        MaterialStateProperty.all(greenCustom)),
                                onPressed: () {
                                  Timer(const Duration(milliseconds: 450), () {
                                    setState(() {
                                      formOpenFlag = !formOpenFlag;
                                      formOpenFlag2 = !formOpenFlag;
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
                        initiallyExpanded: formOpenFlag2,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 300), () {
                            setState(() {
                              formOpenFlag = !d;
                              formOpenFlag2 = d;
                            });
                          });
                        },
                        title: Text("2. Pemeriksaan Tayar (${_keyIn[1]}/3)",
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
                                            6),
                                        _tableRowBuild(
                                            '2.2. Nut tayar diperiksa', 7),
                                        _tableRowBuild(
                                            '2.3. Tekanan angin diperiksa', 8),
                                      ]),
                                  Container(
                                    color: white,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                    height: 100,
                                    child: _textFieldBuild(1),
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
                                                      BorderRadius.circular(
                                                          8.0),
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
                                                formOpenFlag = true;
                                                formOpenFlag2 = false;
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
                                                formOpenFlag = !formOpenFlag;
                                                formOpenFlag2 = true;
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
                        initiallyExpanded: formOpenFlag3,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag2 = !d;
                              formOpenFlag3 = d;
                            });
                          });
                        },
                        title: Text("3. Sistem Mampatan (${_keyIn[2]}/5)",
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
                                          '3.1. Sistem Hidraulik & Minyak', 9),
                                      _tableRowBuild('3.2. PTD/PAM', 10),
                                      _tableRowBuild(
                                          '3.3. Semua penutup diperiksa', 11),
                                      _tableRowBuild(
                                          '3.4. Buang air dalam tabung angin',
                                          12),
                                      _tableRowBuild(
                                          '3.5. Sistem LEACHATE diperiksa', 13),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(2),
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
                                              formOpenFlag2 = true;
                                              formOpenFlag3 = false;
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
                                              formOpenFlag2 = !formOpenFlag2;
                                              formOpenFlag3 = true;
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
                        initiallyExpanded: formOpenFlag4,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag3 = !d;
                              formOpenFlag4 = d;
                            });
                          });
                        },
                        title: Text("4. Sistem Lampu (${_keyIn[3]}/6)",
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
                                          14),
                                      _tableRowBuild(
                                          '4.2. Lampu berhenti diperiksa', 15),
                                      _tableRowBuild(
                                          '4.3. Lampu isyarat diperiksa', 16),
                                      _tableRowBuild(
                                          '4.4. Lampu kecemasan diperiksa (Hazard Light)',
                                          17),
                                      _tableRowBuild(
                                          '4.5. Lampu isyarat sedang bekerja diperiksa (Beacon Light)',
                                          18),
                                      _tableRowBuild(
                                          '4.6. Lampu nombor plet diperiksa',
                                          19),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(3),
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
                                              formOpenFlag3 = true;
                                              formOpenFlag4 = false;
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
                                              formOpenFlag3 = !formOpenFlag3;
                                              formOpenFlag4 = true;
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
                        initiallyExpanded: formOpenFlag5,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag4 = !d;
                              formOpenFlag5 = d;
                            });
                          });
                        },
                        title: Text(
                            "5. Sistem Enjin dan Driveline (${_keyIn[4]}/16)",
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
                                          20),
                                      _tableRowBuild(
                                          '5.2. Periksa paras minyak enjin',
                                          21),
                                      _tableRowBuild(
                                          '5.3. Periksa penutup minyak enjin',
                                          22),
                                      _tableRowBuild(
                                          '5.4. Periksa paras air radiator',
                                          23),
                                      _tableRowBuild(
                                          '5.5. Periksa paras expansion tank',
                                          24),
                                      _tableRowBuild(
                                          '5.6. Periksa dipstik minyak Auto Transmission',
                                          25),
                                      _tableRowBuild(
                                          '5.7. Periksa paras minyak Auto Transmission',
                                          26),
                                      _tableRowBuild(
                                          '5.8. Periksa paras minyak power steering',
                                          27),
                                      _tableRowBuild(
                                          '5.9. Periksa paras minyak brek', 28),
                                      _tableRowBuild(
                                          '5.10. Nyatakan sistem cengkaman sistem brek',
                                          29),
                                      _tableRowBuild(
                                          '5.11. Periksa paras minyak sistem clutch',
                                          30),
                                      _tableRowBuild(
                                          '5.12. Adakah sistem clutch berfungsi dengan baik',
                                          31),
                                      _tableRowBuild(
                                          '5.13. Periksa paras air wiper tank',
                                          32),
                                      _tableRowBuild(
                                          '5.14. Periksa keadaan wiper (Kiri & Kanan)',
                                          33),
                                      _tableRowBuild(
                                          '5.15. Periksa paras air bateri No. 1 & No. 2',
                                          34),
                                      _tableRowBuild(
                                          '5.16. Periksa keadaan asap ekzos',
                                          35),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(4),
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
                                              formOpenFlag4 = true;
                                              formOpenFlag5 = false;
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
                                              formOpenFlag5 = !formOpenFlag4;
                                              formOpenFlag5 = true;
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
                        initiallyExpanded: formOpenFlag6,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag5 = !d;
                              formOpenFlag6 = d;
                            });
                          });
                        },
                        title: Text("6. Bahagian Luaran (${_keyIn[5]}/2)",
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
                                          36),
                                      _tableRowBuild('6.2. Hon diperiksa', 37),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(5),
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
                                              formOpenFlag5 = true;
                                              formOpenFlag6 = false;
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
                                              formOpenFlag6 = !formOpenFlag5;
                                              formOpenFlag6 = true;
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
                        initiallyExpanded: formOpenFlag7,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag6 = !d;
                              formOpenFlag7 = d;
                            });
                          });
                        },
                        title: Text("7. Peralatan Keselamatan (${_keyIn[6]}/3)",
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
                                          38),
                                      _tableRowBuild(
                                          '7.2. Alat pemadam api', 39),
                                      _tableRowBuild(
                                          '7.3. Kotak kecemasan (First Aid Kit)',
                                          40),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(6),
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
                                              formOpenFlag6 = true;
                                              formOpenFlag7 = false;
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
                                              formOpenFlag6 = !formOpenFlag6;
                                              formOpenFlag7 = true;
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
                        initiallyExpanded: formOpenFlag8,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag7 = !d;
                              formOpenFlag8 = d;
                            });
                          });
                        },
                        title: Text("8. Kebersihan Kenderaan (${_keyIn[7]}/2)",
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
                                          41),
                                      _tableRowBuild(
                                          '8.2. Kebersihan sekitar luaran badan trak',
                                          42),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(7),
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
                                              formOpenFlag6 = true;
                                              formOpenFlag7 = false;
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
                                              formOpenFlag7 = !formOpenFlag7;
                                              formOpenFlag8 = true;
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
                        initiallyExpanded: formOpenFlag9,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag8 = !d;
                              formOpenFlag9 = d;
                            });
                          });
                        },
                        title: Text("9. Kebersihan Bin Lifter (${_keyIn[8]}/1)",
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
                                          '9.1. Bin lifter dicuci oleh pemandu',
                                          43),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(8),
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
                                              formOpenFlag8 = true;
                                              formOpenFlag9 = false;
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
                                              formOpenFlag8 = !formOpenFlag8;
                                              formOpenFlag9 = true;
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
                        initiallyExpanded: formOpenFlag10,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag9 = !d;
                              formOpenFlag10 = d;
                            });
                          });
                        },
                        title: Text("10. Kemalangan (${_keyIn[9]}/2)",
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
                                          44),
                                      _tableRowBuild(
                                          '10.2. Nombor kenderaan pihak ketiga',
                                          45),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(9),
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
                                              formOpenFlag9 = true;
                                              formOpenFlag10 = false;
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
                                              formOpenFlag9 = !formOpenFlag9;
                                              formOpenFlag10 = true;
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
                        initiallyExpanded: formOpenFlag11,
                        onExpansionChanged: (d) {
                          Timer(const Duration(milliseconds: 350), () {
                            setState(() {
                              formOpenFlag10 = !d;
                              formOpenFlag11 = d;
                            });
                          });
                        },
                        title: Text("11. Fizikal Kenderaan (${_keyIn[10]}/2)",
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
                                          '11.1. Sampah dalam kompaktor', 46),
                                      _tableRowBuild(
                                          '11.2. Keadaan fizikal/kecatatan pada trak',
                                          47),
                                    ]),
                                Container(
                                  color: white,
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 20),
                                  height: 100,
                                  child: _textFieldBuild(10),
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
                                              formOpenFlag10 = true;
                                              formOpenFlag11 = false;
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
                                          _handleSubmittedData(context);
                                        },
                                        child: const Text("Hantar"),
                                      ),
                                    ])
                              ]))
                        ]))),
            const SizedBox(height: 5)
          ]),
        )),
      ),
    );
  }

  Form _valueTextFormBuild(int idx, TextInputType type,
      [String? label = "", bool? icon = true]) {
    return Form(
        key: _key[idx],
        child: TextFormField(
          cursorColor: greenCustom,
          keyboardType: type,
          textAlignVertical: TextAlignVertical.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
              focusColor: green,
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: borderTextColor)),
              border: const OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greenCustom),
                borderRadius: BorderRadius.circular(borderRadiusCircular),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greenCustom),
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

  TextField _textFieldBuild(int idx) {
    return TextField(
      key: _textKeys[idx],
      maxLines: 5,
      cursorColor: green,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          focusColor: green,
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: grey300)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: green),
            borderRadius: BorderRadius.circular(5),
          ),
          labelText: 'Catatan',
          alignLabelWithHint: true,
          labelStyle: TextStyle(color: grey400, fontSize: 14)),
    );
  }

  TableRow _tableRowBuild(String title, int idx) {
    return TableRow(children: [
      Text(title,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: blackCustom)),
      SizedBox(
          height: 42,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                  child: Text(has),
                ),
              ],
            ),
            SizedBox(width: Orientations().isTabletPortrait(context) ? 0 : 30),
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
                child: Text(no),
              )
            ]),
            SizedBox(width: Orientations().isTabletPortrait(context) ? 10 : 0)
          ]))
    ]);
  }

  _loadRadioButton() {
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
      _keyIn[a] = filled.toString();
      n = 0;
      _incompleteRadioButton = false;
    }
  }

  _handleSubmittedData(context) {
    _loadRadioButton();
    for (var i = 0; i < _key.length; i++) {
      final FormState? form = _key[i].currentState;
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
                "Hantar semakan kenderaan sekarang? Pastikan maklumat diisi adalah betul.",
                cancel,
                yes);
          }).then((actionText) {
        if (actionText == yes) {
          if (completedFirstVc && !completedSecondVc) {
            completedSecondVc = true;
          }
          completedFirstVc = true;
          showSuccessToast(context,
              "Borang semakan kenderaan berjaya dihantar kepada penyelia anda!");
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pop(context, 'refresh');
          });
        }
      });
    } else {
      _valid = false;
      showErrorToast(
          context, "Sila isikan borang semakan kenderaan sebelum dihantar");
    }
  }
}
