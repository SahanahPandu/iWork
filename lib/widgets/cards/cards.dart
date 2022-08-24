import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../screens/list_of_employees/list_of_employee_details.dart';
import '../../screens/reassign_employee/reassign_employee_details.dart';
import '../../screens/work_schedule/compactor_panel/compactor_panel_schedule_details.dart';
import '../../screens/work_schedule/pra/pra_work_schedule_details.dart';
import '../../screens/work_schedule/supervisor/supervisor_schedule_details.dart';

class Cards extends StatefulWidget {
  final String type;
  final dynamic data;
  final Function(dynamic)? assignedEmployee;

  const Cards({
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
      child: userRole == 200
          ? Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadowColor: Colors.grey.shade50,
              elevation: 14,
              child: Container(
                child: getWidget(),
                margin: _isScheduleDetailCard
                    ? const EdgeInsets.symmetric(vertical: 18)
                    : const EdgeInsets.all(18),
              ),
            )
          : (widget.type == "SV Laluan Details" ||
                  widget.type == "Comp Laluan Details"
              ? Container(
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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: getWidget()))
              : Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.grey.shade50,
                  elevation: 14,
                  child: Container(
                    child: getWidget(),
                    margin: _isScheduleDetailCard
                        ? const EdgeInsets.symmetric(vertical: 18)
                        : const EdgeInsets.all(18),
                  ),
                )),
    );
  }
}
