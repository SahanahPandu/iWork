import 'package:flutter/material.dart';

//import files
import '../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../widgets/cards/cards.dart';

class ReassignEmployeeList extends StatefulWidget {
  final int? scMainId;
  final List<WorkerSchedule>? absentStaffList;

  const ReassignEmployeeList({
    Key? key,
    this.scMainId,
    this.absentStaffList,
  }) : super(key: key);

  @override
  State<ReassignEmployeeList> createState() => _ReassignEmployeeListState();
}

class _ReassignEmployeeListState extends State<ReassignEmployeeList> {
  List<WorkerSchedule> employeeAbsentList = [];

  @override
  void initState() {
    super.initState();
    loadAbsentEmployeeList();
  }

  loadAbsentEmployeeList() {
    List<WorkerSchedule> absentEmployeeList = widget.absentStaffList!;
    absentEmployeeList.removeWhere((status) =>
        status.userAttendanceId !=
        null); //removed list of staff that have attendance id/clock in info

    setState(() {
      employeeAbsentList.addAll(absentEmployeeList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: employeeAbsentList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Cards(
                type: "Reassign Pekerja",
                data: {
                  "sMainId": widget.scMainId,
                  "absentStaff": widget.absentStaffList![index]
                },
              ),
            );
          }),
    );
  }
}
