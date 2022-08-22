import 'dart:async';
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

class _ListCardState extends State<ListCard> with TickerProviderStateMixin {
  double squareScaleA = 1;
  late AnimationController _controllerCard;

  @override
  void initState() {
    _controllerCard = AnimationController(
      vsync: this,
      lowerBound: 0.99,
      upperBound: 1,
      value: 1,
      duration: const Duration(milliseconds: 10),
    );
    _controllerCard.addListener(() {
      setState(() {
        squareScaleA = _controllerCard.value;
      });
    });
    super.initState();
  }

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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _controllerCard.reverse();
              Navigator.push(
                  context,
                  PageTransition(
                      child: _redirect(), type: PageTransitionType.fade));
            },
            onTapDown: (dp) {
              _controllerCard.reverse();
            },
            onTapUp: (dp) {
              Timer(const Duration(milliseconds: 150), () {
                _controllerCard.fling();
              });
            },
            onTapCancel: () {
              _controllerCard.fling();
            },
            child: Transform.scale(
              scale: squareScaleA,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, 4),
                      spreadRadius: 1,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                  child: Container(
                    margin: userRole == 200
                        ? const EdgeInsets.symmetric(vertical: 18)
                        : const EdgeInsets.symmetric(vertical: 5),
                    child: getWidget(),
                  ),
                ),
              ),
            )));
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
