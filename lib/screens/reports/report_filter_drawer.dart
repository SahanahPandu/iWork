import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/report/report_status.dart';
import '../../providers/halangan_api.dart';
import '../../providers/report/reports_api.dart';
import '../../utils/calendar/date.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/app_bar/app_bar_widget.dart';
import '../schedule_filter/schedule_filter_list.dart';
import '../../models/report/obstacle_types.dart';

class ReportFilterDrawer extends StatefulWidget {
  final Map<String, dynamic>? passData;
  final Function(Map<String, dynamic>)? updateState;

  const ReportFilterDrawer({
    Key? key,
    this.passData,
    this.updateState,
  }) : super(key: key);

  @override
  ReportFilterDrawerState createState() => ReportFilterDrawerState();
}

class ReportFilterDrawerState extends State<ReportFilterDrawer> {
  final scheduleFilterListKey = GlobalKey<ScheduleFilterListState>();

  final TextEditingController filteredDateTextFormField =
      TextEditingController(); //controller for date textformfield
  DateTime filteredDate = DateTime.now(); //default for datePicker
  String selectedDate = "";
  List<ReportStatus> preSelectStatus = [];
  List<ReportStatus> selectedStatus = [];
  List<ObstacleTypes> preSelectObstacles = [];
  List<ObstacleTypes> selectedObstacles = [];
  bool changeIcon = false;

  double spaceBetweenItem = 24;
  double spaceBetweenLabel = 16;

  // text form field config
  Color textFieldFillColor = Colors.white;
  TextStyle textLabelStyle = TextStyle(
    color: blackCustom,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  TextStyle textFormFieldStyle = const TextStyle(
    fontSize: 15,
    color: Color(0xff2B2B2B),
    fontWeight: FontWeight.w400,
  );
  TextStyle hintTextStyle = TextStyle(
    fontSize: 15,
    color: labelTextColor,
    fontWeight: textFormFieldLabelFontWeight,
  );

  bool clickable = true;
  TextStyle textFormFieldLabelStyle = TextStyle(
    fontSize: 15,
    color: labelTextColor,
    fontWeight: textFormFieldLabelFontWeight,
  );

  InputBorder errorBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(width: borderSideWidth, color: Colors.red),
    borderRadius: BorderRadius.circular(borderRadiusCircular),
  );

  InputBorder disableBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      width: borderSideWidth,
      color: enabledBorderWithoutText,
    ),
    borderRadius: BorderRadius.circular(
      borderRadiusCircular,
    ),
  );

  // end of text form field config

  loadData() {
    //load data from page filter
    if (widget.passData != null) {
      Map<String, dynamic> passingData = widget.passData!;

      setState(() {
        if (passingData['date'] != null) {
          filteredDateTextFormField.text = passingData['date'];
        }

        if (passingData['obstacle'] != null) {
          preSelectObstacles.clear();
          preSelectObstacles =
              List<ObstacleTypes>.from(passingData['obstacle']);
        }
        if (passingData['status'] != null) {
          preSelectStatus.clear();
          preSelectStatus = List<ReportStatus>.from(passingData['status']);
        }
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              const AppBarWidget(
                bgColor: Colors.white,
                leadingIcon: CustomIcon.cross,
                title: "Tapisan",
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: ListView(
                    children: [
                      Text(
                        'Tarikh',
                        style: textLabelStyle,
                      ),
                      SizedBox(
                        height: spaceBetweenLabel,
                      ),
                      TextFormField(
                        onTap: () {
                          displayCupertinoDatePicker(context);
                        },
                        controller: filteredDateTextFormField,
                        style: TextStyle(
                          color: blackCustom,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        readOnly: true,
                        // enabled: false,
                        decoration: InputDecoration(
                          enabled: true,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: borderSideWidth,
                              color: enabledBorderWithoutText,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadiusCircular,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: borderSideWidth,
                              color: enabledBorderWithoutText,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadiusCircular,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: borderSideWidth,
                              color: enabledBorderWithoutText,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadiusCircular,
                            ),
                          ),
                          hintText: 'dd/mm/yyyy',
                          hintStyle: TextStyle(
                            color: greyCustom,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: changeIcon
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      changeIcon = false;
                                      filteredDateTextFormField.text = "";
                                      filteredDate = DateTime.now();
                                    });
                                  },
                                  child: Icon(
                                    CustomIcon.cross,
                                    size: 16,
                                    color: blackCustom,
                                  ),
                                )
                              : Icon(
                                  CustomIcon.scheduleOutline,
                                  size: 16,
                                  color: blackCustom,
                                ),
                        ),
                      ),
                      //============== end of Tarikh ===========================

                      SizedBox(
                        height: spaceBetweenItem,
                      ),

                      //============= dropdown related to laluan section =======
                      ScheduleFilterList(
                        key: scheduleFilterListKey,
                        passData: widget.passData,
                      ),
                      //============= dropdown section =========================

                      SizedBox(
                        height: spaceBetweenItem,
                      ),

                      //================ Jenis Halangan ========================
                      dropdownObstacles(),
                      //================ end of JEnis Halangan =================

                      SizedBox(
                        height: spaceBetweenItem,
                      ),

                      //================ Status ================================
                      dropdownStatus(),
                      //================ end of Status =========================

                      SizedBox(
                        height: Sizes().screenHeight(context) * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: Sizes().screenHeight(context) * 0.1,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    offset: Offset(10, 20),
                  )
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: userRole == 100
                          ? Orientations().isTabletPortrait(context)
                              ? Sizes().screenWidth(context) * 0.18
                              : Sizes().screenWidth(context) * 0.12
                          : Sizes().screenWidth(context) * 0.4,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shadowColor: MaterialStateProperty.all(transparent),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xffE5E5E5),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Batal',
                            style: TextStyle(
                              color: greyCustom,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: userRole == 100
                        ? Orientations().isTabletPortrait(context)
                            ? Sizes().screenWidth(context) * 0.18
                            : Sizes().screenWidth(context) * 0.115
                        : Sizes().screenWidth(context) * 0.4,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);

                        if (widget.updateState != null) {
                          widget.updateState!({
                            "date": filteredDateTextFormField.text,
                            "mainRoute": scheduleFilterListKey
                                .currentState?.namaLaluan.text,
                            "subRoute": scheduleFilterListKey
                                .currentState?.namaSubLaluan.text,
                            "park": {
                              "id": scheduleFilterListKey.currentState?.idTaman,
                              "name": scheduleFilterListKey
                                  .currentState?.namaTaman.text
                            },
                            "road": {
                              "id": scheduleFilterListKey.currentState?.idJalan,
                              "name": scheduleFilterListKey
                                  .currentState?.namaJalan.text
                            },
                            "obstacle": preSelectObstacles,
                            "status": preSelectStatus,
                          });
                        }
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shadowColor: MaterialStateProperty.all(transparent),
                        backgroundColor: MaterialStateProperty.all(greenCustom),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Pasti',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterButtonSection() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: Sizes().screenWidth(context) * 0.4,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shadowColor: MaterialStateProperty.all(transparent),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xffE5E5E5),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: greyCustom,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: SizedBox(
            width: Sizes().screenWidth(context) * 0.4,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // setState(() {
                //   selectedDate = _filteredDate.text;
                //   selectedStatus = preSelectStatus;
                //   displayFilterSection = true;
                // });
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shadowColor: MaterialStateProperty.all(transparent),
                backgroundColor: MaterialStateProperty.all(greenCustom),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  'Pasti',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget dropdownStatus() {
    return FutureBuilder<List<ReportStatus?>?>(
        future: ReportsApi.getStatusLaporan(),
        builder: ((context, snapshot) {
          final statusData = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (statusData!.isEmpty) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CustomIcon.exclamation,
                            color: Colors.orange, size: 14),
                        const SizedBox(width: 10),
                        Text("Tiada rekod dijumpai",
                            style: TextStyle(color: grey500)),
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: textLabelStyle,
                    ),
                    SizedBox(
                      height: spaceBetweenLabel,
                    ),
                    StatefulBuilder(builder:
                        (BuildContext context, StateSetter setStatusState) {
                      return Wrap(
                        runSpacing: 8,
                        spacing: 16,
                        children: statusData
                            .map(
                              (status) => FilterChip(
                                label: Text(
                                  status!.name,
                                ),
                                labelStyle: TextStyle(
                                  color: preSelectStatus
                                          .where((theStatus) => theStatus.code
                                              .contains(status.code))
                                          .isNotEmpty
                                      ? const Color(0xff005B9E)
                                      : const Color(0xff969696),
                                  // Color(0xff969696),
                                ),
                                backgroundColor: const Color(0xffEFEFEF),
                                showCheckmark: false,
                                selected: preSelectStatus
                                        .where((theStatus) => theStatus.code
                                            .contains(status.code))
                                        .isNotEmpty
                                    ? true
                                    : false,
                                selectedColor: const Color(0xffC0E4FF),
                                onSelected: (clicked) {
                                  setStatusState(() {
                                    if (clicked) {
                                      var data = preSelectStatus.where(
                                          (theStatus) => theStatus.code
                                              .contains(status.code));

                                      if (data.isEmpty) {
                                        //if not exist then add
                                        preSelectStatus.add(status);
                                      } else {
                                        preSelectStatus.remove(status);
                                      }
                                    } else {
                                      preSelectStatus.removeWhere((theStatus) =>
                                          theStatus.code == status.code);
                                    }
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    }),
                  ],
                );
              }
          }
        }));
  }

  Widget dropdownObstacles() {
    return FutureBuilder<List<ObstacleTypes?>?>(
        future: HalanganApi.getDataJenisHalangan(),
        builder: ((context, snapshot) {
          final obstaclesData = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (obstaclesData!.isEmpty) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CustomIcon.exclamation,
                            color: Colors.orange, size: 14),
                        const SizedBox(width: 10),
                        Text("Tiada rekod dijumpai",
                            style: TextStyle(color: grey500)),
                      ],
                    ),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenis Halangan',
                      style: textLabelStyle,
                    ),
                    SizedBox(
                      height: spaceBetweenLabel,
                    ),
                    StatefulBuilder(builder:
                        (BuildContext context, StateSetter setObstacleState) {
                      return Wrap(
                        runSpacing: 8,
                        spacing: 16,
                        children: obstaclesData
                            .map(
                              (obstacle) => FilterChip(
                                label: Text(
                                  obstacle!.name,
                                ),
                                labelStyle: TextStyle(
                                  color: preSelectObstacles
                                          .where((theObstacle) =>
                                              theObstacle.id == obstacle.id)
                                          .isNotEmpty
                                      ? const Color(0xff005B9E)
                                      : const Color(0xff969696),
                                ),
                                backgroundColor: const Color(0xffEFEFEF),
                                showCheckmark: false,
                                selected: preSelectObstacles
                                        .where((theObstacle) =>
                                            theObstacle.id == obstacle.id)
                                        .isNotEmpty
                                    ? true
                                    : false,
                                selectedColor: const Color(0xffC0E4FF),
                                onSelected: (clicked) {
                                  setObstacleState(() {
                                    if (clicked) {
                                      var data = preSelectObstacles.where(
                                          (theObstacle) =>
                                              theObstacle.id == obstacle.id);

                                      if (data.isEmpty) {
                                        //if not exist then add
                                        preSelectObstacles.add(obstacle);
                                      } else {
                                        preSelectObstacles.remove(obstacle);
                                      }
                                    } else {
                                      preSelectObstacles.removeWhere(
                                          (theObstacle) =>
                                              theObstacle.id == obstacle.id);
                                    }
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    }),
                  ],
                );
              }
          }
        }));
  }

  Future<dynamic> displayCupertinoDatePicker(context) {
    DateTime getDate = DateTime.now();
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        constraints: userRole == 100
            ? (Orientations().isLandscape(context)
                ? const BoxConstraints(maxWidth: 550, maxHeight: 280)
                : const BoxConstraints(maxWidth: 550, maxHeight: 330))
            : BoxConstraints(
                maxHeight: Sizes().screenHeight(context) * 0.4,
                maxWidth: Sizes().screenWidth(context),
              ),
        context: context,
        builder: (builder) {
          return Container(
            margin: const EdgeInsets.all(28),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Kembali',
                          style: TextStyle(
                            color: Color(0xffA4A4A4),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        'Pilih Tarikh',
                        style: TextStyle(
                          color: blackCustom,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            changeIcon = true;
                          });
                          setState(() {
                            filteredDateTextFormField.text = Date.getTheDate(
                                getDate, '', 'dd/MM/yyyy', 'ms');

                            filteredDate = getDate;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Pasti',
                          style: TextStyle(
                            color: greenCustom,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: greyCustom,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: userRole == 100
                      ? (Orientations().isLandscape(context)
                          ? Sizes().screenHeight(context) * 0.23
                          : Sizes().screenHeight(context) * 0.18)
                      : Sizes().screenHeight(context) * 0.2,
                  child: Localizations.override(
                    delegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      DefaultWidgetsLocalizations.delegate,
                    ],
                    context: context,
                    locale: const Locale('ms'),
                    child: CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      dateOrder: DatePickerDateOrder.dmy,
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: filteredDate,
                      maximumYear: 2024,
                      minimumYear: 2022,
                      onDateTimeChanged: (theDate) {
                        getDate = theDate;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
