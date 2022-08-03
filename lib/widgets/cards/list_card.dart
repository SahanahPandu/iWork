// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../screens/e_cuti/e_cuti.dart';
import '../../screens/e_cuti/pra/pra_e_cuti_list_details.dart';
import '../../screens/list_of_road/list_of_road_details.dart';
import '../../screens/reports/report_list_details.dart';
import '../../screens/reports/reports.dart';
import '../../screens/work_schedule/work_schedule.dart';
import './my_task/pra/pra_my_task_list_details.dart';
import 'my_task/ba/ba_my_task_list_details.dart';
import 'my_task/eo/eo_my_task_list_details.dart';
import 'my_task/supervisor/supervisor_my_task_list_details.dart';

class ListCard extends StatefulWidget {
  dynamic data;
  String type;
  int listIndex;

  ListCard(
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
      return PraECutiListDetails(data: widget.data);
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
      padding: const EdgeInsets.only(bottom: 3),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              if (widget.type == "Cuti") {
                return ECuti(screen: "2", data: widget.data);
              } else if (widget.type == "Laluan") {
                return WorkSchedule(data: widget.data);
              } else if (widget.type == "Laporan") {
                return ReportsPage(
                  screen: "4",
                  data: widget.data,
                  dataLaluan: null,
                );
              } else {
                return Container();
              }
            }),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(userRole == 200 ? 15 : 10),
          ),
          shadowColor: userRole == 200 ? Colors.white : grey200,
          elevation: userRole == 200 ? 14 : 5,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: getWidget(),
          ),
        ),
      ),
    );
  }
}
