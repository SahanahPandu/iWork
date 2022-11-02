import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/dimen.dart';
import '../../screens/employee_list/employee_list.dart';

class GantiPekerjaButton extends StatefulWidget {
  final Function(dynamic)? assignedEmployee;
  final String buttonText;

  const GantiPekerjaButton({
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
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          )),
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: EmployeeList(
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
