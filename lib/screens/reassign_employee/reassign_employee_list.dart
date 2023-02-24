import 'package:flutter/material.dart';

//import files
import '../../models/employee/reassign_employee.dart';
import '../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/cards/cards.dart';

class ReassignEmployeeList extends StatefulWidget {
  final int? scMainId;
  final List<WorkerSchedule>? absentStaffList;
  final List<ReassignEmployee>? updateReassignList;

  const ReassignEmployeeList({
    Key? key,
    this.scMainId,
    this.absentStaffList,
    this.updateReassignList,
  }) : super(key: key);

  @override
  ReassignEmployeeListState createState() => ReassignEmployeeListState();
}

class ReassignEmployeeListState extends State<ReassignEmployeeList> {
  List<WorkerSchedule> employeeAbsentList = [];
  List<ReassignEmployee> reassignEmployeeList = [];

  @override
  void initState() {
    super.initState();
    loadAbsentEmployeeList();
  }

  loadAbsentEmployeeList() {
    print('scMainId: ${widget.scMainId}');
    List<WorkerSchedule> absentEmployeeList = widget.absentStaffList!;
    absentEmployeeList.removeWhere((status) =>
        status.userAttendanceId !=
        null); //removed list of staff that have attendance id/clock in info

    //loop and create new list to hold reassign data
    //post method purpose
    for (var employee in absentEmployeeList) {
      var theEmployeeDetail = ReassignEmployee(
        workerScId: employee.id!,
        isReassigned: 0,
        currUserId: employee.userId!.id!,
        reassignId: null,
        svId: null,
      );

      reassignEmployeeList.add(theEmployeeDetail);
    }

    setState(() {
      employeeAbsentList.addAll(absentEmployeeList);
    });
  }

  updateReassignList(absentId, isReassign, reassignId, svId) {
    //get the userIndex
    var getIndex = reassignEmployeeList.indexWhere((employee) {
      return employee.workerScId == absentId;
    });

    if (getIndex >= 0) {
      setState(() {
        reassignEmployeeList[getIndex].isReassigned = isReassign;
        reassignEmployeeList[getIndex].reassignId = reassignId;
        reassignEmployeeList[getIndex].svId = svId;

        if (widget.updateReassignList != null) {
          if (widget.updateReassignList != null &&
              widget.updateReassignList != []) {
            widget.updateReassignList!.clear();
            widget.updateReassignList!.addAll(reassignEmployeeList);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                      "absentStaff": widget.absentStaffList![index],
                      "updateReassign": updateReassignList,
                    },
                  ),
                );
              }),
        ),
        SizedBox(
          height: Sizes().screenHeight(context) * 0.1,
        ),
      ],
    );
  }
}
