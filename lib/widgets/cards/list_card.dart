import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../screens/e_cuti/e_cuti.dart';
import '../../screens/e_cuti/pra/pra_e_cuti_list_details.dart';
import '../../screens/e_cuti/supervisor/supervisor_leave_list_details.dart';
import '../../screens/list_of_road/list_of_road_details.dart';
import '../../screens/reports/report_list_details.dart';
import '../../screens/reports/reports.dart';
import '../../screens/schedule_issue/report/report_approval/report_approval_main.dart';
import '../../screens/schedule_verification/ecuti/ecuti_approval/ecuti_approval_main.dart';
import '../../screens/work_schedule/work_schedule.dart';
import './my_task/pra/pra_my_task_list_details.dart';
import 'my_task/ba/ba_my_task_list_details.dart';
import 'my_task/eo/eo_my_task_list_details.dart';
import 'my_task/supervisor/supervisor_my_task_list_details.dart';

class ListCard extends StatefulWidget {
  final dynamic data;
  final String type;
  final int listIndex;

  const ListCard(
      {Key? key,
      required this.data,
      required this.type,
      required this.listIndex})
      : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  Widget? getWidget() {
    if (widget.type == "Cuti") {
      if (userRole == 100 || userRole == 200) {
        //comp || pra
        return PraECutiListDetails(data: widget.data);
      } else if (userRole == 300) {
        //sv
        return SupervisorLeaveListDetails(data: widget.data);
      } else {
        //others add later
        return SupervisorLeaveListDetails(data: widget.data);
      }
    } else if (widget.type == "Laluan") {
      if (userRole == 200) {
        //pra
        return PraMyTaskListDetails(data: widget.data);
      } else if (userRole == 300) {
        //sv
        return SupervisorMyTaskListDetails(data: widget.data);
      } else if (userRole == 400) {
        //eo
        return EOMyTaskListDetails(data: widget.data);
      } else if (userRole == 500) {
        //BA
        return BAMyTaskListDetails(data: widget.data);
      }
    } else if (widget.type == "Senarai Jalan") {
      return ListOfRoadDetails(data: widget.data, index: widget.listIndex);
    } else if (widget.type == "Laporan") {
      return ReportListDetails(data: widget.data, index: widget.listIndex);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: _redirect(), type: PageTransitionType.fade));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                //color: Color(0xff0D2E61),
                blurRadius: 5,
                offset: const Offset(0, 4),
                spreadRadius: 1,
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(userRole == 200 ? 14 : 10),
            ),
            // shadowColor: userRole == 200 ? const Color(0xff0D2E61) : grey200,
            // elevation: userRole == 200 ? 4 : 3,
            elevation: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 16, bottom: 24),
              child: getWidget(),
            ),
          ),
        ),
      ),
    );
  }

  _redirect() {
    if (widget.type == "Cuti") {
      if (userRole == 100 || userRole == 200) {
        //comp || pra
        return ECuti(screen: "2", data: widget.data);
      } else if (userRole == 300) {
        //sv
        return EcutiApprovalMain(data: widget.data);
      } else {
        //others add later
        return EcutiApprovalMain(data: widget.data);
      }
    } else if (widget.type == "Laluan") {
      return WorkSchedule(data: widget.data);
    } else if (widget.type == "Laporan") {
      if (userRole == 100 || userRole == 200) {
        // comp || pra
        return ReportsPage(screen: "4", data: widget.data, dataLaluan: null);
      } else if (userRole == 300) {
        // sv
        return ReportApprovalMain(data: widget.data);
      } else {
        //others add later
        return ReportApprovalMain(data: widget.data);
      }
    } else {
      return Container();
    }
  }
}
