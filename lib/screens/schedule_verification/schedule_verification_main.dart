import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device.dart';
import '../e_cuti/supervisor/supervisor_leave_list.dart';
import 'attendance/attendance_detail/attendance_verification_list.dart';
import 'attendance/attendance_verification.dart';
import 'ecuti/ecuti_verification.dart';
import 'reschedule/reschedule_verification.dart';

class ScheduleVerificationMain extends StatefulWidget {
  const ScheduleVerificationMain({Key? key}) : super(key: key);

  @override
  State<ScheduleVerificationMain> createState() =>
      _ScheduleVerificationMainState();
}

class _ScheduleVerificationMainState extends State<ScheduleVerificationMain> {
  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        _buildVerifyCard(
            context,
            attendanceMainCard,
            "Kehadiran",
            "Sahkan Kehadiran",
            const AttendanceVerification(),
            const AttendanceVerificationList()),
        _buildVerifyCard(context, eCutiMainCard, "E-Cuti", "Sahkan E-Cuti",
            const EcutiVerification(), const SupervisorLeaveList()),
        _buildVerifyCard(
            context,
            rescheduleMainCard,
            "Penjadualan Semula",
            "Luluskan",
            const RescheduleVerification(),
            const AttendanceVerificationList()),
      ],
    );
  }

  ValueListenableBuilder _buildVerifyCard(
      BuildContext context,
      ValueNotifier<bool> isCardExist,
      String? cardTitle,
      String? buttonTitle,
      redirect,
      detailRedirect) {
    return ValueListenableBuilder(
        valueListenable: isCardExist,
        builder: (BuildContext context, value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: value == true
                ? SizedBox(
                    width: _device.screenWidth(context),
                    child: Card(
                      //Tugasan Card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: white54,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cardTitle!,
                                  style: TextStyle(
                                      color: black87,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    child: redirect),
                              ],
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: _device.screenWidth(context) * 0.7,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => green800),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(_device.screenWidth(context), 42)),
                                    backgroundColor:
                                        MaterialStateProperty.all(green)),
                                child: Text(buttonTitle!,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: white)),
                                onPressed: () {
                                  _navigatePage(context, detailRedirect);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : null,
          );
        });
  }

  Future<void> _navigatePage(BuildContext context, detailRedirect) async {
    String refresh = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => detailRedirect));
    if (!mounted) return;
    switch (refresh) {
      case "refreshAttendance":
        _verifiedTask(attendanceMainCard);
        break;
      case "refreshEcuti":
        _verifiedTask(eCutiMainCard);
        break;
      case "refreshReschedule":
        _verifiedTask(rescheduleMainCard);
        break;
    }
  }

  void _verifiedTask(ValueNotifier<bool> isMainCard) {
    isMainCard.value = false;
  }
}
