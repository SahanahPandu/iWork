// ignore_for_file: must_be_immutable

import 'package:eswm/config/palette.dart';
import 'package:flutter/material.dart';

import '../../screens/employee_list/employee_list.dart';

class GantiPekerjaButton extends StatefulWidget {
  Function(dynamic)? assignedEmployee;
  GantiPekerjaButton({
    Key? key,
    this.assignedEmployee,
  }) : super(key: key);

  @override
  State<GantiPekerjaButton> createState() => _GantiPekerjaButtonState();
}

class _GantiPekerjaButtonState extends State<GantiPekerjaButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          primary: Colors.white,
          shadowColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          )),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmployeeList(
                      assignedEmployee: widget.assignedEmployee,
                    )));
      },
      child: const Text(
        "Ganti Pekerja",
        style: TextStyle(
          color: Colors.red,
          fontSize: 15,
        ),
      ),
    );
  }
}
