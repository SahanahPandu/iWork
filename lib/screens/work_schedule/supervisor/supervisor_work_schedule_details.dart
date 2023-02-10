import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//import files
import '../../../../config/palette.dart';
import '../../../config/font.dart';
import '../../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../../models/schedule/supervisor/detail/sv_schedule_detail.dart';
import '../../../utils/calendar/time.dart';
import '../../../utils/device/sizes.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/alert/user_profile_dialog.dart';
import '../../../widgets/container/staff_stack_container.dart';
import '../../../widgets/container/status_container.dart';

class SupervisorScheduleDetails extends StatefulWidget {
  final SupervisorScheduleDetail? data;
  final bool? button;

  const SupervisorScheduleDetails({Key? key, this.data, this.button = false})
      : super(key: key);

  @override
  State<SupervisorScheduleDetails> createState() =>
      _SupervisorScheduleDetailsState();
}

class _SupervisorScheduleDetailsState extends State<SupervisorScheduleDetails> {
  Color expandBgColor = const Color(0xea4a39be);
  Color beforeVC = white;
  Color afterVC = white;
  String startTime = "--:--";
  String stopTime = "--:--";

  @override
  void initState() {
    if (widget.data!.data!.details.startWorkAt == "--:--" ||
        widget.data!.data!.details.startWorkAt == null) {
      startTime = "--:--";
    } else {
      startTime = Time.convertToHM(widget.data!.data!.details.startWorkAt!);
    }
    if (widget.data!.data!.details.stopWorkAt == "--:--" ||
        widget.data!.data!.details.stopWorkAt == null) {
      stopTime = "--:--";
    } else {
      stopTime = Time.convertToHM(widget.data!.data!.details.stopWorkAt!);
    }
    if (widget.data!.data!.details.vehicleChecklistId == null) {
      beforeVC = white;
      afterVC = white;
    } else {
      if (widget.data!.data!.details.vehicleChecklistId!.statusCode!.code ==
          "VC1") {
        beforeVC = okTextColor;
        afterVC = white;
      } else if (widget
                  .data!.data!.details.vehicleChecklistId!.statusCode!.code ==
              "VC2" ||
          widget.data!.data!.details.vehicleChecklistId!.statusCode!.code ==
              "VC3") {
        beforeVC = okTextColor;
        afterVC = okTextColor;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          //Nama Laluan & Status
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.data!.data!.details.mainRoute!,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            StatusContainer(
              type: "Laluan",
              status: widget.data!.data!.details.statusCode!.name!,
              statusId: widget.data!.data!.details.statusCode!.code!,
              fontWeight: statusFontWeight,
              roundedCorner: true,
            ),
          ],
        ),

        //No. Kenderaan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.truckFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data!.data!.details.vehicleNo!,
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jumlah Sub Laluan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.roadFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Sub Laluan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data!.data!.details.totalSubRoute}",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jumlah Taman dan Jalan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.tamanFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data!.data!.details.totalPark}/${widget.data!.data!.details.totalStreet}",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jenis Kutipan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.recycle,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jenis Kutipan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data!.data!.details.activityCode!.activityName!,
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Masuk Kerja/Keluar Kerja
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CustomIcon.scheduleFill, size: 16, color: white),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Masuk/Keluar Kerja",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "$startTime/$stopTime",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Semakan Kenderaan
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.manualFill,
                    size: 16,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Semakan Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
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
            ],
          ),
        ),
        //Senarai Staf
        Align(
            alignment: Alignment.centerRight,
            child: SizedBox(child: buildStackedImages(widget.data))),

        widget.button == true
            ? Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  width: Sizes().screenWidth(context) * 0.75,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        overlayColor:
                            MaterialStateColor.resolveWith((states) => red),
                        foregroundColor:
                            MaterialStateColor.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return white;
                          }
                          return red;
                        }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: red)),
                        ),
                        minimumSize: MaterialStateProperty.all(
                            Size(Sizes().screenWidth(context), 42)),
                        backgroundColor: MaterialStateProperty.all(white)),
                    child: const Text("Hubungi Pemandu",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                    onPressed: () {
                      _callNumber("widget.data.leaderContact");
                    },
                  ),
                ),
              )
            : const SizedBox(height: 4),
      ],
    );
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
        color: expandBgColor,
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
                          : "--:--",
                      userData.userId!.userDetail!.loginId);
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

  _callNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
