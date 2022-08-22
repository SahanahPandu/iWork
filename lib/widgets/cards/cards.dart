// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/config.dart';
import '../../screens/reassign_employee/reassign_employee_details.dart';
import '../../screens/work_schedule/compactor_panel/compactor_panel_schedule_details.dart';
import '../../screens/work_schedule/pra/pra_work_schedule_details.dart';
import '../../screens/work_schedule/supervisor/supervisor_schedule_details.dart';
import 'package:eswm/screens/list_of_employees/list_of_employee_details.dart';

class Cards extends StatefulWidget {
  String type;
  dynamic data;
  Function(dynamic)? assignedEmployee;

  Cards({
    Key? key,
    required this.type,
    this.data,
    this.assignedEmployee,
  }) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  bool _isScheduleDetailCard = false;

  getWidget() {
    if (widget.type == "PRA Laluan Details") {
      _isScheduleDetailCard = true;
      return PraWorkScheduleDetails(data: widget.data);
    } else if (widget.type == "Comp Laluan Details") {
      _isScheduleDetailCard = true;
      return CompactorPanelScheduleDetails(data: widget.data);
    } else if (widget.type == "SV Laluan Details") {
      _isScheduleDetailCard = true;
      return SupervisorScheduleDetails(data: widget.data);
    } else if (widget.type == "Senarai Pekerja") {
      return ListOfEmployeeDetails(
        data: widget.data!,
      );
    } else if (widget.type == "Reassign Pekerja") {
      return ReassignEmployeeDetails(
        dataEmployee1: widget.data!,
      );
    }
    _isScheduleDetailCard;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.type == "Senarai Pekerja") {
          if (widget.assignedEmployee != null) {
            widget.assignedEmployee!(widget.data!);
            Navigator.pop(context);
          }
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //shadowColor: const Color.fromARGB(255, 138, 146, 166),
        shadowColor: Colors.grey.shade50,
        elevation: userRole == 200 ? 14 : 5,
        child: Container(
          child: getWidget(),
          margin: _isScheduleDetailCard
              ? const EdgeInsets.symmetric(vertical: 18)
              : const EdgeInsets.all(18),
        ),
      ),
    );
  }
}
