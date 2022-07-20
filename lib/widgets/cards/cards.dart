// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files

import '../../screens/work_schedule/pra/pra_work_schedule_details.dart';

class Cards extends StatefulWidget {
  String type;
  dynamic data;

  Cards({Key? key, required this.type, required this.data}) : super(key: key);

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  getWidget() {
    if (widget.type == "PRA Laluan Details") {
      return PraWorkScheduleDetails(data: widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      //shadowColor: const Color.fromARGB(255, 138, 146, 166),
      shadowColor: Colors.grey.shade50,
      elevation: 14,
      child: Container(
        margin: const EdgeInsets.all(18),
        child: getWidget(),
      ),
    );
  }
}
