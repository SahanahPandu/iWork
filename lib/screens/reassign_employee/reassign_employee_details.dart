// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../widgets/buttons/ganti_pekerja_button.dart';
import '../list_of_employees/list_of_employee_details.dart';

class ReassignEmployeeDetails extends StatefulWidget {
  dynamic dataEmployee1; //absence employee

  ReassignEmployeeDetails({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfEmployeeDetails(
          data: widget.dataEmployee1!,
          assignedEmployee: getAssignedEmployeeDetails,
        ),
        if (dataEmployee2 == null)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GantiPekerjaButton(
              assignedEmployee: getAssignedEmployeeDetails,
              buttonText: "Ganti Pekerja",
            ),
          ),

        if (dataEmployee2 != null)
          const SizedBox(
            height: 10,
          ),
        if (dataEmployee2 != null)
          const Center(
            child: Icon(
              Icons.swap_vertical_circle_rounded,
              size: 25,
              color: Colors.green,
            ),
          ),
        if (dataEmployee2 != null)
          const SizedBox(
            height: 10,
          ),
        if (dataEmployee2 != null)
          ListOfEmployeeDetails(
            data: dataEmployee2,
          ),
        // if (dataEmployee2 != null)
        //   const SizedBox(
        //     height: 15,
        //   ),
        if (dataEmployee2 != null)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GantiPekerjaButton(
              assignedEmployee: getAssignedEmployeeDetails,
              buttonText: "Tukar Pilihan",
            ),
          ),
      ],
    );
  }
}
