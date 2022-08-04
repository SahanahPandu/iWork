import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../screens/list_of_employees/list_of_employees.dart';
import '../my_task/supervisor/supervisor_my_task_list_details.dart';
import '../../listview/card_list_view.dart';
import '../../../screens/work_schedule/supervisor/supervisor_schedule_details.dart';

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
        listTitle = "Senarai Pekerja";
        break;
      case "laporan":
        listTitle = "Senarai Laporan";
        break;
      case "belum":
        listTitle = "Senarai Pekerja";
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
          padding: const EdgeInsets.all(10.0),
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
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: _loadLaluanDetails(),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Text(
            listTitle,
            style: TextStyle(
                color: grey500, fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        _showBottomList(),
      ],
    );
  }

  _showBottomList() {
    switch (widget.getIssue) {
      case "kehadiran":
        return ListOfEmployees(
          idPekerja: const ["Emp07"],
        );
      case "laporan":
        return CardListView(type: "Laporan");
      case "belum":
        return ListOfEmployees();
    }
  }
}