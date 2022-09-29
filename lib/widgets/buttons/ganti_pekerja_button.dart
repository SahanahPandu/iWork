import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../screens/employee_list/employee_list.dart';

class GantiPekerjaButton extends StatefulWidget {
  final dynamic absentEmployee;
  final Function(dynamic)? assignedEmployee;
  final String buttonText;

  const GantiPekerjaButton({
    Key? key,
    this.absentEmployee,
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
        elevation: 0,
      ),
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: EmployeeList(
                  absentEmployee: widget.absentEmployee,
                  assignedEmployee: widget.assignedEmployee,
                )));
      },
      child: Text(
        widget.buttonText,
        style: const TextStyle(
          color: Color(0xff34A853),
          fontSize: 13,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
