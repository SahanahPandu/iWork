import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../models/task/supervisor/supervisor_task.dart';
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_main.dart';
import 'attendance/attendance_detail/attendance_verification_list.dart';
import 'attendance/attendance_verification.dart';
import 'request_worker/request_worker_detail/request_worker_list.dart';
import 'request_worker/request_worker_verification.dart';
import 'vehicle_checklist/vehicle_checklist_verification.dart';

class ScheduleVerificationMain extends StatefulWidget {
  final Sah? sahData;

  const ScheduleVerificationMain({Key? key, this.sahData}) : super(key: key);

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
        widget.sahData!.attendance!.isNotEmpty
            ? _buildVerifyCard(
                context,
                attendanceMainCard,
                "Kehadiran",
                "Sahkan Kehadiran",
                AttendanceVerification(
                    attendanceData: widget.sahData!.attendance!),
                const AttendanceVerificationList())
            : const SizedBox(),
        widget.sahData!.checklist!.isNotEmpty
            ? _buildVerifyCard(
                context,
                vcMainCard,
                "Semakan Kenderaan",
                "Sahkan Semakan Kenderaan",
                VehicleChecklistVerification(
                    checklistData: widget.sahData!.checklist!),
                const VehicleChecklistApprovalMain())
            : const SizedBox(),

        /// Disable ecuti verification function
        // _buildVerifyCard(context, eCutiMainCard, "E-Cuti", "Sahkan E-Cuti",
        //    const EcutiVerification(), const EcutiApprovalTab()),
        widget.sahData!.workerRequest!.isNotEmpty
            ? _buildVerifyCard(
                context,
                rescheduleMainCard,
                "Permohonan Pinjam Pekerja",
                "Sahkan",
                RequestWorkerVerification(
                    requestData: widget.sahData!.workerRequest),
                const RequestWorkerList())
            : const SizedBox(),
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
