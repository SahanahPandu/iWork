///Unused file
import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../screens/list_of_employees/list_of_employees.dart';
import '../../../screens/reassign_employee/reassign_employee_list.dart';
import '../my_task/supervisor/supervisor_my_task_list_details.dart';
import '../../listview/card_list_view.dart';
import '../../../screens/work_schedule/supervisor/supervisor_work_schedule_details.dart';

class ScheduleIssuedCard extends StatefulWidget {
  final Laluan getInfo;
  final String getIssue;

  const ScheduleIssuedCard({
    Key? key,
    required this.getIssue,
    required this.getInfo,
  }) : super(key: key);

  @override
  State<ScheduleIssuedCard> createState() => _ScheduleIssuedCardState();
}

class _ScheduleIssuedCardState extends State<ScheduleIssuedCard> {
  String listTitle = "";

  @override
  void initState() {
    super.initState();
    _loadListTile();
  }

  void _loadListTile() {
    switch (widget.getIssue) {
      case "kehadiran":
        listTitle = "Senarai Pekerja :";
        break;
      case "laporan":
        listTitle = "Senarai Laporan :";
        break;
      case "belum":
        listTitle = "Senarai Pekerja :";
        break;
    }
  }

  _loadLaluanDetails() {
    switch (widget.getIssue) {
      case "kehadiran":
        return SupervisorMyTaskListDetails(data: widget.getInfo, button: false);
      case "laporan":
        return SupervisorMyTaskListDetails(data: widget.getInfo, button: false);
      case "belum":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SupervisorScheduleDetails(data: widget.getInfo, button: true),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 15,
            top: 20,
            right: 15,
            bottom: 10,
          ),
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
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: _loadLaluanDetails())),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            listTitle,
            style: TextStyle(
                color: blackCustom, fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        _showBottomList(),
      ],
    );
  }

  _showBottomList() {
    switch (widget.getIssue) {
      case "kehadiran":
        return ReassignEmployeeList(namaLaluan: widget.getInfo.namaLaluan);
      case "laporan":
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: const CardListView(type: "Laporan", screens: "isu"),
        );
      case "belum":
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: const ListOfEmployees(),
        );
    }
  }
}
