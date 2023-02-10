import 'dart:math' as math;

import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/schedule/compactor/detail/cp_schedule_detail.dart';
import '../../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../../utils/calendar/time.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/alert/user_profile_dialog.dart';
import '../../../widgets/container/staff_stack_container.dart';
import '../../../widgets/container/status_container.dart';

class CompactorPanelScheduleDetails extends StatefulWidget {
  final CScheduleDetail? data;

  const CompactorPanelScheduleDetails({Key? key, this.data}) : super(key: key);

  @override
  State<CompactorPanelScheduleDetails> createState() =>
      _CompactorPanelScheduleDetailsState();
}

class _CompactorPanelScheduleDetailsState
    extends State<CompactorPanelScheduleDetails> {
  Color expandBgColor = const Color(0xea4a39be);
  Color portraitExpandBgColor = const Color(0xea3e62be);
  Color beforeVC = white;
  Color afterVC = white;
  String startTime = "--:--";
  String stopTime = "--:--";

  @override
  void initState() {
    if (widget.data!.data!.details!.vehicleChecklistId == null) {
      startTime = "--:--";
      stopTime = "--:--";
      beforeVC = white;
      afterVC = white;
    } else {
      if (widget.data!.data!.details!.startWorkAt == "--:--" ||
          widget.data!.data!.details!.startWorkAt == null) {
        startTime = "--:--";
      } else {
        startTime = Time.convertToHM(widget.data!.data!.details!.startWorkAt!);
      }
      if (widget.data!.data!.details!.stopWorkAt == "--:--" ||
          widget.data!.data!.details!.stopWorkAt == null) {
        stopTime = "--:--";
      } else {
        stopTime = Time.convertToHM(widget.data!.data!.details!.stopWorkAt!);
      }
      if (widget.data!.data!.details!.vehicleChecklistId!.statusCode!.code ==
          "VC1") {
        beforeVC = okTextColor;
        afterVC = white;
      } else if (widget
                  .data!.data!.details!.vehicleChecklistId!.statusCode!.code ==
              "VC2" ||
          widget.data!.data!.details!.vehicleChecklistId!.statusCode!.code ==
              "VC3") {
        beforeVC = okTextColor;
        afterVC = okTextColor;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
          //Nama Laluan & Status
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(widget.data!.data!.details!.mainRoute!,
                    style: TextStyle(
                      fontSize: 18,
                      color: white,
                      fontWeight: FontWeight.w700,
                    ))),
            StatusContainer(
              type: "Laluan",
              status: widget.data!.data!.details!.statusCode!.name!,
              statusId: widget.data!.data!.details!.statusCode!.code!,
              fontWeight: statusFontWeight,
              roundedCorner: true,
            )
          ]),

      //No. Kenderaan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.truckFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("No. Kenderaan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text(widget.data!.data!.details!.vehicleNo!,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Jumlah Sub Laluan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.roadFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Jumlah Sub Laluan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text("${widget.data!.data!.details!.totalSubRoute}",
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Jumlah Taman dan Jalan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.tamanFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Jumlah Taman/Jalan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text(
              "${widget.data!.data!.details!.totalPark}/${widget.data!.data!.details!.totalStreet}",
              style: TextStyle(
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.w600,
              ),
            )
          ])),
      //Jenis Kutipan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.recycle,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Jenis Kutipan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text(
              widget.data!.data!.details!.activityCode!.activityName!,
              style: TextStyle(
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.w600,
              ),
            )
          ])),
      //Jadual Mula/Tamat Kerja
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(CustomIcon.scheduleFill, size: 16, color: white),
              const SizedBox(
                width: 15,
              ),
              Text("Jadual Mula/Tamat",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text(
                '${Time.convertToHM(widget.data!.data!.details!.startScheduleAt!)} / ${Time.convertToHM(widget.data!.data!.details!.stopScheduleAt!)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Masuk Kerja/Keluar Kerja
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(CustomIcon.timerFill, size: 16, color: white),
              const SizedBox(
                width: 15,
              ),
              Text("Masuk/Keluar Kerja",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text('$startTime / $stopTime',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Semakan Kenderaan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.manualFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Semakan Kenderaan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            RichText(
                text: TextSpan(
                    text: "Sebelum",
                    style: TextStyle(
                      fontSize: 16,
                      color: beforeVC,
                      fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                  TextSpan(
                      text: "/",
                      style: TextStyle(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.w600,
                      )),
                  TextSpan(
                      text: "Selepas",
                      style: TextStyle(
                        fontSize: 16,
                        color: afterVC,
                        fontWeight: FontWeight.w600,
                      )),
                ])),
          ])),
      //Senarai Staf
      Align(
          alignment: Alignment.centerRight,
          child: Container(child: buildStackedImages())),
    ]);
  }

  Widget buildStackedImages() {
    const double size = 65;
    const double xShift = 10;
    List userData = [];
    if (widget.data!.data!.details!.workerSchedules!.isNotEmpty) {
      for (int i = 0;
          i < widget.data!.data!.details!.workerSchedules!.length;
          i++) {
        userData.add(widget.data!.data!.details!.workerSchedules![i]);
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

  Widget buildImage(WorkerSchedule? userData) {
    const double borderSize = 3;

    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(borderSize),
        color: Orientations().isTabletPortrait(context)
            ? portraitExpandBgColor
            : expandBgColor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showUserProfileDialog(
                      context,
                      userData!.userId!.userDetail!.profilePic! !=
                              "http://ems.swmsb.com/uploads/profile/blue.png"
                          ? userData.userId!.userDetail!.profilePic!
                          : "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352062-stock-illustration-default-placeholder-profile-icon.jpg",
                      userData.userId!.userDetail!.name,
                      "PRA",
                      userData.userAttendanceId != null
                          ? userData.userAttendanceId!.clockInAt ?? "--:--"
                          : "--:--",
                      userData.userAttendanceId != null
                          ? userData.userAttendanceId!.clockOutAt ?? "--:--"
                          : "--:--",
                      userData.userId!.userDetail!.loginId!);
                });
          },
          child: ClipOval(
            child: userData!.userId!.userDetail!.profilePic! !=
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
}
