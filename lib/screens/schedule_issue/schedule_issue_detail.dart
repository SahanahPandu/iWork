import 'dart:math' as math;

import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../screens/work_schedule/supervisor/supervisor_work_schedule_details.dart';
import '../../config/font.dart';
import '../../models/employee/reassign_employee.dart';
import '../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../models/schedule/supervisor/detail/sv_schedule_detail.dart';
import '../../providers/schedule/supervisor/supervisor_schedule_api.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/alert/user_profile_dialog.dart';
import '../../widgets/buttons/contact_button.dart';
import '../../widgets/buttons/sahkan_ganti_pekerja.dart';
import '../../widgets/container/staff_stack_container.dart';
import '../../widgets/container/status_container.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../reassign_employee/reassign_employee_list.dart';
import '../street_search/street_search.dart';
import 'report/report_of_schedule_approval/report_of_schedule_approval_main.dart';

class ScheduleIssueDetail extends StatefulWidget {
  final dynamic getInfo;
  final String getIssue;

  const ScheduleIssueDetail({
    Key? key,
    required this.getIssue,
    required this.getInfo,
  }) : super(key: key);

  @override
  State<ScheduleIssueDetail> createState() => _ScheduleIssueDetailState();
}

class _ScheduleIssueDetailState extends State<ScheduleIssueDetail> {
  String listTitle = "Test";
  Color collapseBgColor = const Color(0xff2b7fe8);
  final reassignEmployeeListKey = GlobalKey<ReassignEmployeeListState>();
  List<ReassignEmployee>? reassignEmployeeList = [];

  late SupervisorScheduleDetail scheduleDetail;

  @override
  void initState() {
    _loadListTile();
    super.initState();
  }

  void _loadListTile() {
    switch (widget.getIssue) {
      case "IHD":

        /// kehadiran
        listTitle = "Senarai Pekerja Tidak Hadir";
        break;
      case "ILHK":

        /// laporan halangan kerja
        listTitle = "Senarai Laporan";
        break;
      case "IBMT":

        /// Belum mula tugas
        listTitle = "Pilih Sub-Laluan & Taman:";
        break;
    }
  }

  // updateReassignList() {
  //   print(
  //       'current list: ${reassignEmployeeListKey.currentState!.reassignEmployeeList[0].toJson()}');
  //   setState(() {
  //     if (reassignEmployeeList != null && reassignEmployeeList != []) {
  //       reassignEmployeeList!.clear();
  //     }

  //     reassignEmployeeList =
  //         reassignEmployeeListKey.currentState!.reassignEmployeeList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FutureBuilder<SupervisorScheduleDetail?>(
          future: SupervisorScheduleApi.getSupervisorScheduleDetail(
              context, widget.getInfo.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text("Some error occurred"));
                } else {
                  scheduleDetail = snapshot.data!;
                  return ExpandCollapseHeader(
                      centerTitle: false,
                      title: _collapseTitle(),
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
                      collapseFade: 80,
                      backgroundColor: transparent,
                      appBarColor: collapseBgColor,
                      collapseButton: widget.getIssue == "IBMT" ? true : false);
                }
            }
          }),
      widget.getIssue == "IBMT"
          ? Positioned(
              bottom: 25,
              right: -10,
              child: ContactButton(data: widget.getInfo))
          : widget.getIssue == "IHD"
              ? Positioned(
                  bottom: 0,
                  child: Material(
                    elevation: 50,
                    child: SizedBox(
                      width: Sizes().screenWidth(context),
                      height: Sizes().screenHeight(context) * 0.1,
                      child: BottomAppBar(
                        elevation: 40,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 16),
                          child: SahkanGantiPekerjaButton(data: {
                            'scMainId': widget.getInfo.scMainId,
                            'reassignList': reassignEmployeeList,
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
    ]);
  }

  SafeArea _scrollBody(dynamic scheduleDetail) {
    return SafeArea(
      child: Container(
          constraints:
              BoxConstraints(minHeight: Sizes().screenHeight(context) * 0.36),
          color: white,
          child: Column(
            children: [_getBottomList(widget.getIssue, scheduleDetail)],
          )),
    );
  }

  Widget _getBottomList(String issue, dynamic scheduleDetail) {
    switch (issue) {
      case "IHD":

        /// Kehadiran
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ReassignEmployeeList(
            key: reassignEmployeeListKey,
            scMainId: widget.getInfo.id,
            absentStaffList: scheduleDetail.data.details.workerSchedules,
            updateReassignList: reassignEmployeeList,
          ),
        );
      case "IBMT":

        /// Belum Mula Tugas
        return const StreetSearch();
      case "ILHK":

        /// Laporan Halangan Kerja
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ReportOfScheduleApprovalMain(scMainId: widget.getInfo.id),
        );
      default:
        return Container();
    }
  }

  Row _collapseTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          widget.getInfo.mainRoute!,
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        StatusContainer(
          type: "Laluan",
          status: widget.getInfo.statusCode!.name!,
          statusId: widget.getInfo.statusCode!.code,
          fontWeight: statusFontWeight,
          roundedCorner: true,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 5),
            child: //Senarai Staf
                Align(
                    alignment: Alignment.centerRight,
                    child: buildStackedImages(scheduleDetail)))
      ],
    );
  }

  Widget buildStackedImages(SupervisorScheduleDetail? scheduleDetail) {
    const double size = 50;
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
      BuildContext context, SupervisorScheduleDetail scheduleDetail) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              child: SupervisorScheduleDetails(data: scheduleDetail),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          listTitle,
          style: TextStyle(
            color: blackCustom,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
