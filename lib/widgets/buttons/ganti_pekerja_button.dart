// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/palette.dart';
import '../../screens/employee_list/employee_list.dart';

class GantiPekerjaButton extends StatefulWidget {
  Function(dynamic)? assignedEmployee;
  String buttonText;

  GantiPekerjaButton({
    Key? key,
    this.assignedEmployee,
    required this.buttonText,
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
      child: Text(
        widget.buttonText,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 15,
        ),
      ),
    );
  }
}
