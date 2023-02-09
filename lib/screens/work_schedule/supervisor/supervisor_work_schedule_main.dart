import 'dart:math' as math;

import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../config/resource.dart';
import '../../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../../models/schedule/supervisor/detail/sv_schedule_detail.dart';
import '../../../models/task/supervisor/supervisor_task.dart';
import '../../../providers/schedule/supervisor/supervisor_schedule_api.dart';
import '../../../widgets/alert/user_profile_dialog.dart';
import '../../../widgets/container/staff_stack_container.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../street_search/street_search.dart';
import 'supervisor_work_schedule_details.dart';

class SupervisorWorkScheduleMain extends StatefulWidget {
  final Isu data;

  const SupervisorWorkScheduleMain({Key? key, required this.data})
      : super(key: key);

  @override
  State<SupervisorWorkScheduleMain> createState() =>
      _SupervisorWorkScheduleMainState();
}

class _SupervisorWorkScheduleMainState
    extends State<SupervisorWorkScheduleMain> {
  Color collapseBgColor = const Color(0xff2b7fe8);
  SupervisorScheduleDetail? scheduleDetail;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SupervisorScheduleDetail?>(
        future: SupervisorScheduleApi.getSupervisorScheduleDetail(
            context, widget.data.scMainId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 78, width: 78, child: Image.asset(opsImg)),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: TextButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              overlayColor: MaterialStateColor.resolveWith(
                                  (states) => const Color(0x0f0c057a)),
                              backgroundColor:
                                  MaterialStateProperty.all(transparent)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sila Muat Semula",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 10),
                              Icon(Icons.refresh, size: 20, color: white),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              refresh.value = !refresh.value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                if (snapshot.hasData) {
                  scheduleDetail = snapshot.data!;
                  return ExpandCollapseHeader(
                      centerTitle: false,
                      title: _collapseTitle(scheduleDetail),
                      headerExpandedHeight: 0.54,
                      alwaysShowLeadingAndAction: false,
                      headerWidget: _header(context, scheduleDetail),
                      fullyStretchable: true,
                      body: [
                        _scrollBody(scheduleDetail),
                      ],
                      curvedBodyRadius: 24,
                      fixedTitle: _fixedTitle(context),
                      fixedTitleHeight: 60,
                      collapseFade: 70,
                      collapseHeight: 130,
                      backgroundColor: transparent,
                      appBarColor: collapseBgColor);
                }
              }
          }
          return Container();
        });
  }

  Widget _scrollBody(SupervisorScheduleDetail? scheduleDetail) {
    return SafeArea(
        child: StreetSearch(
            height: 0.56, scMainId: scheduleDetail!.data!.details.id));
  }

  Widget _collapseTitle(SupervisorScheduleDetail? scheduleDetail) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        widget.data.mainRoute,
        style: TextStyle(
          color: white,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
      ),
      StatusContainer(
        type: "Laluan",
        status: widget.data.statusCode.name,
        statusId: widget.data.statusCode.code,
        fontWeight: statusFontWeight,
        roundedCorner: true,
      ),
      Padding(
          padding: const EdgeInsets.only(top: 5),
          child: //Senarai Staf
              buildStackedImages(scheduleDetail))
    ]);
  }

  Widget buildStackedImages(SupervisorScheduleDetail? scheduleDetail) {
    const double size = 56;
    const double xShift = 10;
    List userData = [];
    if (scheduleDetail!.data!.details.workerSchedules!.isNotEmpty) {
      for (int i = 0;
          i < scheduleDetail.data!.details.workerSchedules!.length;
          i++) {
        userData.add(scheduleDetail.data!.details.workerSchedules![i]);
      }
      final items = userData.map((userData) => buildImage(userData)).toList();

      return StaffStackContainer(
        items: items,
        size: size,
        xShift: xShift,
      );
    }
    return Container();
  }

  Widget buildImage(WorkerSchedule userData) {
    const double borderSize = 3;

    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(borderSize),
        color: collapseBgColor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showUserProfileDialog(
                      context,
                      userData.userId!.userDetail!.profilePic! !=
                              "http://ems.swmsb.com/uploads/profile/blue.png"
                          ? userData.userId!.userDetail!.profilePic!
                          : "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352062-stock-illustration-default-placeholder-profile-icon.jpg",
                      userData.userId!.userDetail!.name,
                      "PRA",
                      userData.userAttendanceId != null
                          ? userData.userAttendanceId!.clockInAt
                          : "--:--",
                      userData.userAttendanceId != null
                          ? userData.userAttendanceId!.clockOutAt ?? "--:--"
                          : "--:--");
                });
          },
          child: ClipOval(
            child: userData.userId!.userDetail!.profilePic !=
                    "http://ems.swmsb.com/uploads/profile/blue.png"
                ? Image.network(
                    userData.userId!.userDetail!.profilePic!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.5),
                    child: Center(
                      child: Text(
                        userData.userId!.userDetail!.name!.substring(0, 2),
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _header(
      BuildContext context, SupervisorScheduleDetail? scheduleDetail) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            //height: Sizes().screenHeight(context) * 0.3,
            child: SupervisorScheduleDetails(data: scheduleDetail),
          ))
    ]));
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Text("Perincian Sub-Laluan",
                style: TextStyle(
                  color: blackCustom,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ))));
  }
}
