import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../widgets/buttons/ganti_pekerja_button.dart';
// import '../../widgets/buttons/sahkan_ganti_pekerja.dart';
import '../employee_list/employee_list.dart';
import '../list_of_employees/list_of_employee_details.dart';
// import '../schedule_issue/schedule_issue_main.dart';

class ReassignEmployeeDetails extends StatefulWidget {
  final dynamic dataEmployee1; //absence employee

  const ReassignEmployeeDetails({
    Key? key,
    required this.dataEmployee1,
  }) : super(key: key);

  @override
  State<ReassignEmployeeDetails> createState() =>
      _ReassignEmployeeDetailsState();
}

class _ReassignEmployeeDetailsState extends State<ReassignEmployeeDetails> {
  dynamic dataEmployee2; //assigned employee

  getAssignedEmployeeDetails(dynamic data) {
    //final buttonVisibility = StateInheritedWidget.of(context);
    if (data != null) {
      // widget.visibility!();
      if (mounted) {
        // showBottomButton();
        setState(() {
          dataEmployee2 = data;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        absentEmployeeSection(),
        SizedBox(
          height: dataEmployee2 != null ? 16 : 24,
        ),
        if (dataEmployee2 != null)
          const Center(
            child: Icon(
              Icons.swap_vertical_circle_rounded,
              size: 25,
              color: Color(0xff34A853),
            ),
          ),
        assignedEmployeeSection(),
      ],
    );
  }

  Widget absentEmployeeSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListOfEmployeeDetails(
        data: widget.dataEmployee1!,
        assignedEmployee: getAssignedEmployeeDetails,
      ),
    );
  }

  Widget assignedEmployeeSection() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: EmployeeList(
                  absentEmployee: widget.dataEmployee1,
                  assignedEmployee: getAssignedEmployeeDetails,
                )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
        color: dataEmployee2 != null ? const Color(0x4DEBFFF0) : Colors.white,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          color: const Color(0xff34A853),
          strokeWidth: 0.5,
          child: (dataEmployee2 != null)
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: ListOfEmployeeDetails(
                    data: dataEmployee2,
                  ),
                )
              : Center(
                  child: GantiPekerjaButton(
                    absentEmployee: widget.dataEmployee1,
                    assignedEmployee: getAssignedEmployeeDetails,
                    buttonText: "Ganti Pekerja",
                  ),
                ),
        ),
      ),
    );
  }

  // Widget? showBottomButton() {
  //   showBottomSheet(
  //     context: context,
  //     builder: (builder) {
  //       return SizedBox(
  //         height: MediaQuery.of(context).size.height * 0.1,
  //         width: MediaQuery.of(context).size.width,
  //         child: const BottomAppBar(
  //           elevation: 40,
  //           color: Colors.white,
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 26, vertical: 17),
  //             child: SahkanGantiPekerjaButton(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //   return null;
  // }
}
