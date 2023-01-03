import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../models/task/compactor/compactor_task.dart';
import '../../providers/task/compactor_panel/compactor_task_api.dart';
import '../../utils/calendar/date.dart';
import '../../utils/calendar/time.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/gridview/compactor_panel/compactor_task_list.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';

class CompactorPanel extends StatefulWidget {
  const CompactorPanel({Key? key}) : super(key: key);

  @override
  State<CompactorPanel> createState() => _CompactorPanelState();
}

class _CompactorPanelState extends State<CompactorPanel> {
  late CompactorTask? scheduleData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CompactorTask?>(
        future: CompactorTaskApi.getCompactorScheduleData(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some error occurred here!"),
                );
              } else {
                if (snapshot.hasData) {
                  scheduleData = snapshot.data!;
                }
                if (scheduleData!.data!.schedules!.length == 1) {
                  /// *** No any actions ***
                  /// VC Before NULL (ENABLED TO FILL) * VC After NULL (DISABLED TO FILL) * Start Work (DISABLED) * Stop Work (DISABLED)
                  if (scheduleData!.data!.schedules![0].vehicleChecklistId ==
                      null) {
                    scheduleVcStatus.value = 0;
                  }

                  /// *** VC Before DONE (VC1) ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After NULL (DISABLED TO FILL) * Start Work (ENABLED) * Stop Work (DISABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC1" &&
                      (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut ==
                              "--:--" &&
                          scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeIn ==
                              "--:--")) {
                    scheduleVcStatus.value = 1;
                  }

                  /// *** VC Before DONE (VC1) && Start Work DONE ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After NULL (DISABLED TO FILL) * Start Work DONE (DISABLED) * Stop Work (ENABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC1" &&
                      (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut !=
                              "--:--" &&
                          scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeIn ==
                              "--:--")) {
                    scheduleVcStatus.value = 2;
                  }

                  /// *** VC Before DONE (VC1) && First Start Work DONE && First Stop Work DONE && Last Stop Work DONE ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After NULL (ENABLED TO FILL) * Start Work DONE (DISABLED) * Stop Work DONE (DISABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC1" &&
                      (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut !=
                              "--:--" &&
                          (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                      .timeIn !=
                                  "--:--" &&
                              scheduleData!.data!.schedules!.last
                                      .vehicleChecklistId!.timeIn !=
                                  "--:--"))) {
                    scheduleVcStatus.value = 3;
                  }

                  /// *** VC Before DONE && VC After DONE (VC2) && First Start Work DONE && First Stop Work DONE && Last Stop Work DONE ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After DONE (ENABLED TO VIEW) * Start Work DONE (DISABLED) * Stop Work DONE (DISABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC2" &&
                      ((scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut !=
                              "--:--" &&
                          (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                      .timeIn !=
                                  "--:--" &&
                              scheduleData!.data!.schedules!.last
                                      .vehicleChecklistId!.timeIn !=
                                  "--:--")))) {
                    scheduleVcStatus.value = 4;
                  } else {
                    //print(
                    //    "Status Code -> ${scheduleData!.data!.schedules![0].vehicleChecklistId!.statusCode!.code}, Time Out -> ${scheduleData!.data!.schedules![0].vehicleChecklistId!.timeOut}, Time In -> ${scheduleData!.data!.schedules![0].vehicleChecklistId!.timeIn}");
                  }
                }

                /// Multiple Schedule cards per vehicle
                else {
                  /// *** No any actions ***
                  /// VC Before NULL (ENABLED TO FILL) * VC After NULL (DISABLED TO FILL) * Start Work (DISABLED) * Stop Work (DISABLED)
                  if (scheduleData!.data!.schedules!.first.vehicleChecklistId ==
                      null) {
                    scheduleVcStatus.value = 0;
                  }

                  /// *** VC Before DONE (VC1) ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After NULL (DISABLED TO FILL) * Start Work (ENABLED) * Stop Work (DISABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC1" &&
                      (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut ==
                              "--:--" &&
                          scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeIn ==
                              "--:--")) {
                    scheduleVcStatus.value = 1;
                  }

                  /// *** VC Before DONE (VC1) && Start Work DONE ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After NULL (DISABLED TO FILL) * Start Work DONE (DISABLED) * Stop Work (ENABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC1" &&
                      (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut !=
                              "--:--" &&
                          scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeIn ==
                              "--:--")) {
                    scheduleVcStatus.value = 2;
                  }

                  /// *** VC Before DONE (VC1) && First Start Work DONE && First Stop Work DONE && Last Stop Work DONE ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After NULL (ENABLED TO FILL) * Start Work DONE (DISABLED) * Stop Work DONE (DISABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC1" &&
                      (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut !=
                              "--:--" &&
                          (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                      .timeIn !=
                                  "--:--" &&
                              scheduleData!.data!.schedules!.last
                                      .vehicleChecklistId!.timeIn !=
                                  "--:--"))) {
                    scheduleVcStatus.value = 3;
                  }

                  /// *** VC Before DONE && VC After DONE (VC2) && First Start Work DONE && First Stop Work DONE && Last Stop Work DONE ***
                  /// VC Before DONE (ENABLED TO VIEW) * VC After DONE (ENABLED TO VIEW) * Start Work DONE (DISABLED) * Stop Work DONE (DISABLED)
                  else if (scheduleData!.data!.schedules![0].vehicleChecklistId!
                              .statusCode!.code ==
                          "VC2" &&
                      ((scheduleData!.data!.schedules![0].vehicleChecklistId!
                                  .timeOut !=
                              "--:--" &&
                          (scheduleData!.data!.schedules![0].vehicleChecklistId!
                                      .timeIn !=
                                  "--:--" &&
                              scheduleData!.data!.schedules!.last
                                      .vehicleChecklistId!.timeIn !=
                                  "--:--")))) {
                    scheduleVcStatus.value = 4;
                  } else {
                    //print(
                    //    "Status Code -> ${scheduleData!.data!.schedules![0].vehicleChecklistId!.statusCode!.code}, Time Out -> ${scheduleData!.data!.schedules![0].vehicleChecklistId!.timeOut}, Time In -> ${scheduleData!.data!.schedules![0].vehicleChecklistId!.timeIn}");
                  }
                }
                return ExpandCollapseHeader(
                    centerTitle: false,
                    title: _collapseTitle(scheduleData),
                    alwaysShowLeadingAndAction: false,
                    headerWidget: _header(context, scheduleData),
                    fullyStretchable: true,
                    body: [
                      _scrollBody(scheduleData),
                    ],
                    headerExpandedHeight:
                        Orientations().isTabletPortrait(context) ? 0.35 : 0.405,
                    fixedTitle: _fixedTitle(context),
                    fixedTitleHeight:
                        Orientations().isTabletPortrait(context) ? 68 : 70,
                    collapseHeight:
                        Orientations().isTabletPortrait(context) ? 160 : 148,
                    collapseFade:
                        Orientations().isTabletPortrait(context) ? 120 : 95,
                    backgroundColor: transparent,
                    appBarColor: Orientations().isTabletPortrait(context)
                        ? const Color(0xff358af5)
                        : const Color(0xff2d80e8));
              }
          }
        });
  }

  SafeArea _scrollBody(CompactorTask? scheduleData) {
    return SafeArea(
        child: Container(
            constraints: Orientations().isTabletPortrait(context)
                ? const BoxConstraints(minHeight: 630) //555
                : const BoxConstraints(minHeight: 285),
            color: white,
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: CompactorTaskList(main: true, data: scheduleData)));
  }

  Row _collapseTitle(CompactorTask? scheduleData) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        const SizedBox(width: 10),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
                height: 55,
                width: 100,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  userInfo[2],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.w600, fontSize: 18),
                )))),
        const SizedBox(
          height: 20,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Tugasan Hari Ini (${DateFormat("hh:mm").format(DateTime.parse('20222312 ${scheduleData!.data!.schedules!.first.startWorkAt!}'))} ${Time.convertAMPMToMs(scheduleData.data!.schedules!.first.startWorkAt!)} - ${DateFormat("hh:mm").format(DateTime.parse('20222312 ${scheduleData.data!.schedules!.last.stopWorkAt!}'))} ${Time.convertAMPMToMs(scheduleData.data!.schedules!.last.stopWorkAt!)})",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            Date.getTheDate(DateTime.now().toString(), "dd/MM/yyyy", 'ms'),
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: white,
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ])
      ]),
      //Senarai Staf
      Align(
          alignment: Alignment.centerRight,
          child: Container(
              alignment: Alignment.centerLeft,
              width: 200,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 25, 30, 20),
                  child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
                      children: [
                        Positioned(
                            left: 96,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Orientations().isTabletPortrait(context)
                                            ? const Color(0xff358af5)
                                            : const Color(0xff2d80e8),
                                    radius: 28,
                                    child: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D"),
                                      radius: 26,
                                    )))),
                        Positioned(
                            left: 48,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Orientations().isTabletPortrait(context)
                                            ? const Color(0xff358af5)
                                            : const Color(0xff2d80e8),
                                    radius: 28,
                                    child: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://www.jurispro.com/files/photos/user_4473.jpg?m=1605811497"),
                                        radius: 26)))),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: CircleAvatar(
                              backgroundColor:
                                  Orientations().isTabletPortrait(context)
                                      ? const Color(0xff358af5)
                                      : const Color(0xff2d80e8),
                              radius: 28,
                              child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://miro.medium.com/max/800/1*7hkI-ZKsglnbjxCRV1bMZA.png"),
                                  radius: 26),
                            ))
                      ]))))
    ]);
  }

  Widget _header(BuildContext context, CompactorTask? scheduleData) {
    return SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Padding(
            padding: const EdgeInsets.only(left: 48, top: 10, bottom: 5),
            child: Text(
              userInfo[2],
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: TodayTaskCard(
                workTime: "",
                timeIn: "",
                timeOut: "",
                scheduleData: scheduleData),
          )
        ]));
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Text("Tugasan",
                style: TextStyle(
                  color: blackCustom,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ))));
  }
}
