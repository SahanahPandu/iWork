import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../screens/e_cuti/leave_form.dart';
import '../../screens/e_cuti/pra/pra_e_cuti_list_details.dart';
import '../../screens/e_cuti/supervisor/supervisor_leave_list_details.dart';
import '../../screens/list_of_road/list_of_road_details.dart';
import '../../screens/reports/report_form.dart';
import '../../screens/reports/report_list_details.dart';
import '../../screens/schedule_issue/report/report_approval/report_approval_main.dart';
import '../../screens/schedule_verification/ecuti/ecuti_approval/ecuti_approval_main.dart';
import '../../screens/work_schedule/work_schedule.dart';
import '../app_bar/app_bar_widget.dart';
import 'my_task/ba/ba_my_task_list_details.dart';
import 'my_task/eo/eo_my_task_list_details.dart';
import './my_task/pra/pra_my_task_list_details.dart';
import 'my_task/supervisor/supervisor_my_task_list_details.dart';

class ListCard extends StatefulWidget {
  final dynamic data;
  final String type;
  final int listIndex;
  final dynamic passData;

  const ListCard({
    Key? key,
    required this.data,
    required this.type,
    required this.listIndex,
    this.passData,
  }) : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> with TickerProviderStateMixin {
  double _scaleCard = 1;
  late AnimationController _controllerCard;

  @override
  void initState() {
    _controllerCard = AnimationController(
      vsync: this,
      lowerBound: 0.97,
      upperBound: 1,
      value: 1,
      duration: const Duration(milliseconds: 250),
    );
    _controllerCard.addListener(() {
      setState(() {
        _scaleCard = _controllerCard.value;
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
      } else if (userRole == 500 || userRole == 600 || userRole == 700) {
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
        padding: userRole == 200 &&
                (widget.type == "Laluan" || widget.type == "Laporan")
            ? const EdgeInsets.only(bottom: 16)
            : userRole == 200 && widget.type == "Cuti"
                ? const EdgeInsets.only(bottom: 24)
                : const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              _controllerCard.reverse();
              if (_controllerCard.isCompleted) {
                _controllerCard.reverse();
              } else {
                _controllerCard.forward(from: 0);
              }
              Navigator.push(
                  context,
                  PageTransition(
                      child: _redirect(), type: PageTransitionType.fade));
            },
            onTapDown: (dp) {
              _controllerCard.reverse();
            },
            onTapUp: (dp) {
              Timer(const Duration(milliseconds: 250), () {
                _controllerCard.fling();
              });
            },
            onTapCancel: () {
              _controllerCard.fling();
            },
            child: Transform.scale(
              scale: _scaleCard,
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
                child: userRole != 200
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: getWidget())
                    : getWidget(),
              ),
            )));
  }

  _redirect() {
    if (widget.type == "Cuti") {
      if (userRole == 100 || userRole == 200) {
        //comp || pra

        return Scaffold(
          backgroundColor: white,
          appBar: const AppBarWidget(title: "E-Cuti"),
          body: LeaveForm(screen: "2", data: widget.data),
        );
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
        //return ReportsPage(screen: "4", data: widget.data, dataLaluan: null);
        return Scaffold(
          backgroundColor: white,
          appBar: AppBarWidget(title: "${widget.data.id}"),
          body: ReportForm(
            screen: "4",
            passData: widget.passData,
            data: widget.data,
          ),
        );
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
