import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../widgets/buttons/ganti_pekerja_button.dart';
import '../employee_list/employee_list.dart';
import '../list_of_employees/list_of_employee_details.dart';

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
    if (data != null) {
      if (mounted) {
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
              color: Colors.green,
            ),
          ),
        assignedEmployeeSection(),
        // if (dataEmployee2 != null) displayButton()!,
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
                    assignedEmployee: getAssignedEmployeeDetails,
                    buttonText: "Ganti Pekerja",
                  ),
                ),
        ),
      ),
    );
  }

  // Widget? displayButton() {
  //   showBottomSheet(
  //       context: context,
  //       builder: (builder) {
  //         return const SahkanGantiPekerjaButton();
  //       });
  //   return null;
  // }
}
