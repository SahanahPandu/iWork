import 'package:flutter/material.dart';

//import files
import '../../../config/layout.dart';
import '../../../widgets/app_bar/app_bar_widget.dart';
import '../../../widgets/cards/cards.dart';
import '../../list_of_employees/list_of_employees.dart';

class AttendanceIssues extends StatefulWidget {
  const AttendanceIssues({Key? key}) : super(key: key);

  @override
  State<AttendanceIssues> createState() => _AttendanceIssuesState();
}

class _AttendanceIssuesState extends State<AttendanceIssues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Kehadiran",
        listOfWidget: [
          SizedBox(
            width: 50,
          )
        ],
      ),
      body: Container(
        margin: pagesMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Cards(
              type: "Laluan Details",
              data: null,
            ),
            SizedBox(
              height: 25,
            ),
            ListOfEmployees(),
          ],
        ),
      ),
    );
  }
}
