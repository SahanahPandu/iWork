// ignore_for_file: must_be_immutable
import 'package:eswm/screens/list_of_employees/list_of_employee_details.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/config.dart';
//import '../../screens/issues/attendance/attendance_issues_laluan_details.dart';
import '../../screens/work_schedule/compactor_panel/compactor_panel_schedule_details.dart';
import '../../screens/work_schedule/pra/pra_work_schedule_details.dart';
import '../../screens/work_schedule/supervisor/supervisor_schedule_details.dart';

class Cards extends StatefulWidget {
  String type;
  dynamic data;

  Cards({Key? key, required this.type, this.data}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  getWidget() {
    if (widget.type == "PRA Laluan Details") {
      return PraWorkScheduleDetails(data: widget.data);
    } else if (widget.type == "Comp Laluan Details") {
      return CompactorPanelScheduleDetails(data: widget.data);
    } else if (widget.type == "SV Laluan Details") {
      return SupervisorScheduleDetails(data: widget.data);
    } else if (widget.type == "Senarai Pekerja") {
      return ListOfEmployeeDetails(
        data: widget.data!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      //shadowColor: const Color.fromARGB(255, 138, 146, 166),
      shadowColor: Colors.grey.shade50,
      elevation: userRole == 200 ? 14 : 5,
      child: Container(
        margin: const EdgeInsets.all(18),
        child: getWidget(),
      ),
    );
  }
}
