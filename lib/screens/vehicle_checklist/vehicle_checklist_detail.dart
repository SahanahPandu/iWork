import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../models/vc/vc.dart';
import '../../utils/date.dart';
import '../../utils/device.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/toast.dart';

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
  late ScrollController _scrollController;
  final Devices _device = Devices();
  bool _showBackToTopButton = false;
  bool _valid = false;
  String _todayDate = "0";
  double _value = 20;
  int _val = -1;
  int _vals = -2;
  int _valss = -3;

  @override
  void initState() {
    _todayDate = Date.getTodayDate();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 200) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey100,
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        elevation: 4,
        shadowColor: white,
        leading: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showAlertDialog(
                      context, reminder, confirmBack, yes, cancel);
                }).then((actionText) {
              if (actionText == yes) {
                Navigator.pop(context);
              }
            });
          },
          icon: Icon(
            Icons.arrow_back,
            color: grey900,
          ),
        ),
        title: Center(
          child: Text(
            vc,
            style: TextStyle(
              fontSize: 18,
              color: grey800,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.history,
              color: grey800,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, bottom: 10.0, left: 22.0),
                child: Text(
                  fillUpVC,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              //CONTAINER #1
              Container(
                  width: double.infinity,
                  height: _device.isLandscape(context)
                      ? (_device.screenHeight(context) * 0.19)
                      : (_device.screenHeight(context) * 0.13),
                  padding: _device.isLandscape(context)
                      ? const EdgeInsets.symmetric(horizontal: 20.0)
                      : const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                      //CARD #1
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: _device.isPortrait(context)
                                  ? const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(1.9),
                                      2: FlexColumnWidth(0.4),
                                      3: FlexColumnWidth(2),
                                      4: FlexColumnWidth(2),
                                      5: FlexColumnWidth(0.4),
                                      6: FlexColumnWidth(1.9),
                                      7: FlexColumnWidth(1.9),
                                    }
                                  : null,
                              border: TableBorder.all(color: transparent),
                              children: [
                                TableRow(children: [
                                  Text(date,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: blueGrey)),
                                  Text(_todayDate,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: black)),
                                  const Text(' '),
                                  Text(
                                    streetNo,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16, color: blueGrey),
                                  ),
                                  Text(widget.data.noLaluan,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: black)),
                                  const Text(' '),
                                  Text(compactorID,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: blueGrey)),
                                  Text(widget.data.noKenderaan,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: black)),
                                ]),
                                TableRow(children: [
                                  SizedBox(height: tableSpace(context)),
                                  //SizeBox Widget
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
                                          fontSize: 16, color: blueGrey)),
                                  Text('--:--',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: black)),
                                  const Text(' '),
                                  Text(inTime,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: blueGrey,
                                      )),
                                  Text('--:--',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: black)),
                                  const Text(' '),
                                  Text(status,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: blueGrey)),
                                  const Text('-')
                                ]),
                              ])))),
              const SizedBox(height: 10),
              // #CONTAINER 2
              Container(
                  width: double.infinity,
                  height: containerVC2Height(context),
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #2
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: columnVC2Width(context),
                              border: TableBorder.all(color: transparent),
                              children: [
                                TableRow(children: [
                                  Text(odometerLvl,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: fontSizeVc(context),
                                          color: blueGrey)),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                            height: _device.isLandscape(context)
                                                ? 35
                                                : 32,
                                            width: _device.isLandscape(context)
                                                ? 130
                                                : 100,
                                            child: _valueTextFormBuild(
                                                0,
                                                TextInputType.number,
                                                odometer)),
                                        SizedBox(width: columnSpaceVc(context)),
                                        Text(
                                          km,
                                          style: TextStyle(
                                              color: black, fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Text(' '),
                                  Text(
                                    odometerFunc,
                                    style: TextStyle(
                                        fontSize: fontSizeVc(context),
                                        color: blueGrey),
                                  ),
                                  SizedBox(
                                    height: 25,
                                    child: Padding(
                                      padding: _device.isLandscape(context)
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 7.0)
                                          : const EdgeInsets.symmetric(
                                              horizontal: 0),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: _val,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _val = value as int;
                                                  });
                                                },
                                                activeColor: green,
                                              ),
                                              Text(yes)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                  value: 2,
                                                  groupValue: _val,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _val = value as int;
                                                    });
                                                  },
                                                  activeColor: green),
                                              Text(no)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                                TableRow(children: [
                                  SizedBox(height: columnSpacing(context)),
                                  //SizeBox Widget
                                  SizedBox(height: columnSpacing(context)),
                                  SizedBox(height: columnSpacing(context)),
                                  SizedBox(height: columnSpacing(context)),
                                  SizedBox(height: columnSpacing(context)),
                                ]),
                                TableRow(children: [
                                  Text(totalKM,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: fontSizeVc(context),
                                          color: blueGrey)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                          height: _device.isLandscape(context)
                                              ? 35
                                              : 32,
                                          width: _device.isLandscape(context)
                                              ? 130
                                              : 100,
                                          child: _valueTextFormBuild(1,
                                              TextInputType.number, odometer)),
                                      SizedBox(width: columnSpaceVc(context)),
                                      Text(
                                        km,
                                        style: TextStyle(
                                            color: black, fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Text(' ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: _device.isLandscape(context)
                                              ? 16
                                              : 14,
                                          color: blueGrey)),
                                  Text(akbkNo,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: _device.isLandscape(context)
                                            ? 16
                                            : 14,
                                        color: blueGrey,
                                      )),
                                  Container(
                                      padding: _device.isLandscape(context)
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 20.0)
                                          : const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                      height: _device.isLandscape(context)
                                          ? 35
                                          : 32,
                                      width: _device.isLandscape(context)
                                          ? 400
                                          : 0,
                                      child: _valueTextFormBuild(
                                          2, TextInputType.number)),
                                ]),
                              ])))),
              const SizedBox(height: 10),
              // #CONTAINER 3
              Container(
                  width: double.infinity,
                  height: _device.isLandscape(context)
                      ? (_device.screenHeight(context) * 0.46)
                      : (_device.screenHeight(context) * 0.3),
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #3
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: _device.isLandscape(context)
                                  ? const {
                                      0: FlexColumnWidth(1.62),
                                      1: FlexColumnWidth(4),
                                    }
                                  : const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(3)
                                    },
                              border: TableBorder.all(color: transparent),
                              children: [
                                TableRow(children: [
                                  Text(dieselFill,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: blueGrey)),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: 35,
                                            width: 130,
                                            child: _valueTextFormBuild(3,
                                                TextInputType.number, litre)),
                                        const SizedBox(width: 10),
                                        Text(
                                          litre,
                                          style: TextStyle(color: black),
                                        ),
                                        const SizedBox(width: 35),
                                        SizedBox(
                                            height: 35,
                                            width: 130,
                                            child: _valueTextFormBuild(
                                                4, TextInputType.number, rm))
                                      ],
                                    ),
                                  ),
                                ]),
                                TableRow(children: [
                                  SizedBox(height: columnSpaceVc(context)),
                                  //SizeBox Widget
                                  SizedBox(
                                      height:
                                          _device.isLandscape(context) ? 6 : 0),
                                ]),
                                TableRow(children: [
                                  Text(passReceipt,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: blueGrey)),
                                  Container(
                                    height: 45,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: _vals,
                                              onChanged: (value) {
                                                setState(() {
                                                  _vals = value as int;
                                                });
                                              },
                                              activeColor: green,
                                            ),
                                            Text(yes)
                                          ],
                                        ),
                                        const SizedBox(width: 5),
                                        Row(
                                          children: [
                                            Radio(
                                                value: 2,
                                                groupValue: _vals,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _vals = value as int;
                                                  });
                                                },
                                                activeColor: green),
                                            Text(no)
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                                TableRow(children: [
                                  Text(fleetCard,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: blueGrey)),
                                  SizedBox(
                                    height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.0),
                                      child: Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                value: 1,
                                                groupValue: _valss,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _valss = value as int;
                                                  });
                                                },
                                                activeColor: green,
                                              ),
                                              Text(yes)
                                            ],
                                          ),
                                          const SizedBox(width: 5),
                                          Row(
                                            children: [
                                              Radio(
                                                  value: 2,
                                                  groupValue: _valss,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _valss = value as int;
                                                    });
                                                  },
                                                  activeColor: green),
                                              Text(no)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                                TableRow(children: [
                                  Text(cardNo,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16, color: blueGrey)),
                                  SizedBox(
                                    width: 400,
                                    height: 60,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: 130,
                                          child: _valueTextFormBuild(
                                              5, TextInputType.number),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                                TableRow(children: [
                                  Text(fuelLvl,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: blueGrey,
                                          height: 1.3)),
                                  SizedBox(
                                    height: 60,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: _device.isLandscape(context)
                                              ? (_device.screenWidth(context) *
                                                  0.55)
                                              : (_device.screenWidth(context) *
                                                  0.5),
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular((10)),
                                            ),
                                            gradient: LinearGradient(
                                                colors: [
                                                  lightPink,
                                                  lightGreen,
                                                ],
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    1.0, 1.00),
                                                stops: const [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 10),
                                              Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(math.pi),
                                                child: Icon(
                                                  Icons.local_gas_station,
                                                  color: red,
                                                  size: 30,
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
                                                    trackHeight: 5.0,
                                                    thumbShape:
                                                        const RoundSliderThumbShape(
                                                            enabledThumbRadius:
                                                                12.0),
                                                    thumbColor: white,
                                                    overlayColor:
                                                        green.withAlpha(32),
                                                    overlayShape:
                                                        const RoundSliderOverlayShape(
                                                            overlayRadius:
                                                                28.0),
                                                    tickMarkShape:
                                                        const RoundSliderTickMarkShape(),
                                                    activeTickMarkColor: white,
                                                    inactiveTickMarkColor:
                                                        greenGrey,
                                                    valueIndicatorShape:
                                                        const PaddleSliderValueIndicatorShape(),
                                                    valueIndicatorColor:
                                                        green600,
                                                    valueIndicatorTextStyle:
                                                        TextStyle(
                                                      color: white,
                                                    ),
                                                  ),
                                                  child: Slider(
                                                    min: 0.0,
                                                    max: 100.0,
                                                    value: _value,
                                                    divisions: 4,
                                                    label: '${_value.round()}%',
                                                    semanticFormatterCallback:
                                                        (double newValue) {
                                                      return '${_value.round()}';
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _value = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.local_gas_station,
                                                  color: green800,
                                                  size: 30,
                                                ),
                                              ),
                                              Text('${_value.round()}%',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w900)),
                                              const SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ])))),
              // #CONTAINER 4
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #3
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              "1. Dokumen Perjalanan",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild('1.1. Puspakom Disc'),
                                        _tableRowBuild('1.2. Cukai Jalan'),
                                        _tableRowBuild(
                                            '1.3. Lesen pembawa A/Permit'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 5
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #5
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              "2. Pemeriksaan Tayar",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '2.1. Bahagian bunga tayar diperiksa'),
                                        _tableRowBuild(
                                            '2.2. Nut tayar diperiksa'),
                                        _tableRowBuild(
                                            '2.3. Tekanan angin diperiksa'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 6
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #6
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              "3. Sistem Mampatan",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '3.1. Sistem Hidraulik & Minyak'),
                                        _tableRowBuild('3.2. PTD/PAM'),
                                        _tableRowBuild(
                                            '3.3. Semua penutup diperiksa'),
                                        _tableRowBuild(
                                            '3.4. Buang air dalam tabung angin'),
                                        _tableRowBuild(
                                            '3.5. Sistem LEACHATE diperiksa'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 7
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #7
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              "4. Sistem Lampu",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '4.1. Lampu utama dan belakang diperiksa'),
                                        _tableRowBuild(
                                            '4.2. Lampu berhenti diperiksa'),
                                        _tableRowBuild(
                                            '4.3. Lampu isyarat diperiksa'),
                                        _tableRowBuild(
                                            '4.4. Lampu kecemasan diperiksa (Hazard Light)'),
                                        _tableRowBuild(
                                            '4.5. Lampu isyarat sedang bekerja diperiksa (Beacon Light)'),
                                        _tableRowBuild(
                                            '4.6. Lampu nombor plet diperiksa'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 8
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #8
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              '5. Sistem Enjin dan Driveline*',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '5.1. Periksa dipstik minyak enjin'),
                                        _tableRowBuild(
                                            '5.2. Periksa paras minyak enjin'),
                                        _tableRowBuild(
                                            '5.3. Periksa penutup minyak enjin'),
                                        _tableRowBuild(
                                            '5.4. Periksa paras air radiator'),
                                        _tableRowBuild(
                                            '5.5. Periksa paras expansion tank'),
                                        _tableRowBuild(
                                            '5.6. Periksa dipstik minyak Auto Transmission'),
                                        _tableRowBuild(
                                            '5.7. Periksa paras minyak Auto Transmission'),
                                        _tableRowBuild(
                                            '5.8. Periksa paras minyak power steering'),
                                        _tableRowBuild(
                                            '5.9. Periksa paras minyak brek'),
                                        _tableRowBuild(
                                            '5.10. Nyatakan sistem cengkaman sistem brek'),
                                        _tableRowBuild(
                                            '5.11. Periksa paras minyak sistem clutch'),
                                        _tableRowBuild(
                                            '5.12. Adakah sistem clutch berfungsi dengan baik'),
                                        _tableRowBuild(
                                            '5.13. Periksa paras air wiper tank'),
                                        _tableRowBuild(
                                            '5.14. Periksa keadaan wiper (Kiri & Kanan)'),
                                        _tableRowBuild(
                                            '5.15. Periksa paras air bateri No. 1 & No. 2'),
                                        _tableRowBuild(
                                            '5.16. Periksa keadaan asap ekzos'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 9
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #9
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              '6. Bahagian Luaran',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '6.1. Cermin pandang belakang dan sisi'),
                                        _tableRowBuild('6.2. Hon diperiksa'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 10
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #10
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              '7. Peralatan Keselamatan',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '7.1. Penanda amaran kecemasan (Triangle Reflector)'),
                                        _tableRowBuild('7.2. Alat pemadam api'),
                                        _tableRowBuild(
                                            '7.3. Kotak kecemasan (First Aid Kit)'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 11
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #11
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              '8. Kebersihan Kenderaan',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '8.1. Kebersihan dalam kokpit (kabin)'),
                                        _tableRowBuild(
                                            '8.2. Kebersihan sekitar luaran badan trak'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 12
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #12
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              '9. Kebersihan Bin Lifter',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '9.1. Bin lifter dicuci oleh pemandu'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 13
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #13
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              '10. Kemalangan',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border:
                                          TableBorder.all(color: transparent),
                                      children: [
                                        _tableRowBuild(
                                            '10.1. Adakah anda terlibat dengan mana-mana kemalangan'),
                                        _tableRowBuild(
                                            '10.2. Nombor kenderaan pihak ketiga'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
              // #CONTAINER 14
              Container(
                  width: double.infinity,
                  padding: paddingVcTable(context),
                  child: Card(
                      //CARD #14
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: grey500,
                      elevation: 5,
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: const Text(
                              '11. Fizikal Kenderaan',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            textColor: Colors.blue.shade700,
                            children: <Widget>[
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      30.0, 0.0, 30.0, 10.0),
                                  child: Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1.62),
                                      },
                                      border: TableBorder.all(
                                          color: Colors.transparent),
                                      children: [
                                        _tableRowBuild(
                                            '11.1. Sampah dalam kompaktor'),
                                        _tableRowBuild(
                                            '11.2. Keadaan fizikal/kecatatan pada trak'),
                                      ])),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    30.0, 5.0, 30.0, 30.0),
                                height: 130,
                                width: double.infinity,
                                child: _textFieldBuild(),
                              )
                            ],
                          ),
                        ],
                      ))),
            ]),
          )),
      bottomNavigationBar: Padding(
        padding: _device.isPortrait(context)
            ? const EdgeInsets.symmetric(horizontal: 220, vertical: 15)
            : const EdgeInsets.symmetric(horizontal: 400, vertical: 10),
        child: SizedBox(
          height: 40,
          width: 150,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: green)),
                ),
                minimumSize: MaterialStateProperty.all(
                    Size(_device.screenWidth(context), 40)),
                backgroundColor: MaterialStateProperty.all(green)),
            child: Text('Hantar',
                style: TextStyle(
                    color: white, fontSize: 16, fontWeight: FontWeight.w700)),
            onPressed: () {
              _handleSubmittedData(context);
            },
          ),
        ),
      ),
      floatingActionButton:
          _showBackToTopButton == false ? null : _goUpButtonBuild(),
    );
  }

  Form _valueTextFormBuild(int idx, TextInputType type, [String? label]) {
    return Form(
        key: _key[idx],
        child: TextFormField(
          cursorColor: green,
          keyboardType: type,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              focusColor: green,
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(width: 1, color: grey300)),
              border: const OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: green),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: green),
                borderRadius: BorderRadius.circular(5),
              ),
              labelText: label ?? "",
              labelStyle: TextStyle(color: grey400, fontSize: 14)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "";
            }
            return null;
          },
        ));
  }

  FloatingActionButton _goUpButtonBuild() {
    return FloatingActionButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      onPressed: _scrollToTop,
      elevation: 5,
      backgroundColor: Colors.green,
      child: const Icon(Icons.keyboard_double_arrow_up_rounded,
          color: Color(0xffeefdea), size: 25),
    );
  }

  TextField _textFieldBuild() {
    return TextField(
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

  TableRow _tableRowBuild(String title) {
    return TableRow(children: [
      Text(title,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: black87)),
      SizedBox(
        height: 35,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0),
          child: Row(
            children: [
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _valss,
                    onChanged: (value) {
                      setState(() {
                        _valss = value as int;
                      });
                    },
                    activeColor: green,
                  ),
                  Text(yes)
                ],
              ),
              const SizedBox(width: 5),
              Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: _valss,
                      onChanged: (value) {
                        setState(() {
                          _valss = value as int;
                        });
                      },
                      activeColor: green),
                  Text(no)
                ],
              ),
            ],
          ),
        ),
      )
    ]);
  }

  _handleSubmittedData(context) {
    for (var i = 0; i < _key.length; i++) {
      final FormState? form = _key[i].currentState;
      if (form!.validate()) {
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
