// ignore_for_file: must_be_immutable

import 'package:eswm/config/config.dart';
import 'package:eswm/screens/list_of_park/list_of_parks.dart';
import 'package:eswm/screens/list_of_road/list_of_road.dart';
import 'package:eswm/screens/list_of_sub_routes/list_of_sub_routes.dart';
import 'package:eswm/widgets/cards/cards.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';

class WorkSchedule extends StatefulWidget {
  dynamic data;

  WorkSchedule({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  // ignore: unused_field
  bool _showSenaraiJalan = false;
  int idTaman = 0;
  int iconCondition = 1;

  updateShowSenaraiJalan(id, [name]) {
    setState(() {
      _showSenaraiJalan = true;
      idTaman = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        elevation: 1,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:
              Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
        ),
        title: Center(
          child: Text(
            "Tugasan",
            style: TextStyle(
              fontSize: 15,
              color: blackCustom,
              fontWeight: FontWeight.w400,
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
        physics: userRole == 200
            ? const ScrollPhysics()
            : const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                top: 20,
                right: 15,
                bottom: 10,
              ),
              child: userRole == 200
                  ? Cards(
                      type: "PRA Laluan Details",
                      data: widget.data,
                    )
                  : Cards(
                      type: "SV Laluan Details",
                      data: widget.data,
                    ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: userRole == 200 ? 10 : 5,
              ),
              child: Card(
                elevation: userRole == 200 ? 5 : 2,
                shadowColor: userRole == 200
                    ? Colors.grey.shade50
                    : Colors.grey.shade200,
                child: ListOfSubRoutes(
                  hintText: 'Senarai Sub Laluan',
                  fontSize: userRole == 200 ? 18 : 15,
                  borderCondition: userRole == 200 ? 0 : 1,
                  //no border
                  fillColor: textFormFieldFillColor,
                  iconCondition: iconCondition,
                  data: "",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: userRole == 200 ? 10 : 5,
              ),
              child: Card(
                elevation: userRole == 200 ? 5 : 2,
                shadowColor: userRole == 200
                    ? Colors.grey.shade50
                    : Colors.grey.shade200,
                child: ListOfParks(
                  showSenaraiJalan: updateShowSenaraiJalan,
                  hintText: 'Senarai Taman',
                  fontSize: userRole == 200 ? 18 : 15,
                  borderCondition: userRole == 200 ? 0 : 1,
                  //no border
                  fillColor: textFormFieldFillColor,
                  iconCondition: iconCondition,
                  data: "",
                ),
              ),
            ),
            if (_showSenaraiJalan) ListOfRoad(idTaman: idTaman),
          ],
        ),
      ),
    );
  }
}
