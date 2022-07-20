// ignore_for_file: must_be_immutable

import 'package:eswm/screens/list_of_park/list_of_parks.dart';
import 'package:eswm/screens/list_of_road/list_of_road.dart';
import 'package:eswm/widgets/cards/cards.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';

class WorkSchedule extends StatefulWidget {
  dynamic data;

  WorkSchedule({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  bool _showSenaraiJalan = false;

  updateShowSenaraiJalan() {
    setState(() {
      _showSenaraiJalan = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        elevation: 4,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey.shade900,
          ),
        ),
        title: Center(
          child: Text(
            "Tugasan",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                top: 20,
                right: 15,
                bottom: 25,
              ),
              child: Cards(
                type: "PRA Laluan Details",
                data: widget.data,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: ListOfParks(showSenaraiJalan: updateShowSenaraiJalan),
            ),
            const SizedBox(
              height: 1000,
              child: ListOfRoad(),
            ),
          ],
        ),
      ),
    );
  }
}
