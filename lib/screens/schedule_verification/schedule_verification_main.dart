import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/tabs/ecuti_approval_tab/ecuti_approval_tab.dart';
import '../vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_main.dart';
import 'attendance/attendance_detail/attendance_verification_list.dart';
import 'attendance/attendance_verification.dart';
import 'ecuti/ecuti_verification.dart';
import 'reschedule/reschedule_verification.dart';
import 'vehicle_checklist/vehicle_checklist_verification.dart';

class ScheduleVerificationMain extends StatefulWidget {
  const ScheduleVerificationMain({Key? key}) : super(key: key);

  @override
  State<ScheduleVerificationMain> createState() =>
      _ScheduleVerificationMainState();
}

class _ScheduleVerificationMainState extends State<ScheduleVerificationMain> {
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
        _buildVerifyCard(
            context,
            attendanceMainCard,
            "Semakan Kenderaan",
            "Sahkan Semakan Kenderaan",
            const VehicleChecklistVerification(),
            const VehicleChecklistApprovalMain()),
        _buildVerifyCard(context, eCutiMainCard, "E-Cuti", "Sahkan E-Cuti",
            const EcutiVerification(), const EcutiApprovalTab()),
        _buildVerifyCard(
            context,
            rescheduleMainCard,
            "Permohonan Pinjam Pekerja",
            "Sahkan",
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: value == true
                ? SizedBox(
                    width: Sizes().screenWidth(context),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                color: cardShadowColor,
                                offset: const Offset(0, 2),
                                blurRadius: 10,
                                spreadRadius: 0.5)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      cardTitle!,
                                      style: TextStyle(
                                          color: blackCustom,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
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
                                width: Sizes().screenWidth(context),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => green800),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          Size(Sizes().screenWidth(context),
                                              42)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              greenCustom)),
                                  child: Text(buttonTitle!,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: white)),
                                  onPressed: () {
                                    _navigatePage(context, detailRedirect);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )))
                : null,
          );
        });
  }

  Future<void> _navigatePage(BuildContext context, detailRedirect) async {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: detailRedirect));

    ///Once completed api integration, will enable this method
    /*  String refresh = await Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: detailRedirect));
    if (!mounted) return;
    switch (refresh) {
      case "refreshAttendance":
        _verifiedTask(attendanceMainCard);
        break;
      case "refreshVc":
        _verifiedTask(vcMainCard);
        break;
      case "refreshEcuti":
        _verifiedTask(eCutiMainCard);
        break;
      case "refreshReschedule":
        _verifiedTask(rescheduleMainCard);
        break;
    }*/
  }

  ///Once completed api integration, will enable this method
/*
  void _verifiedTask(ValueNotifier<bool> isMainCard) {
    isMainCard.value = false;
  }
  */
}
