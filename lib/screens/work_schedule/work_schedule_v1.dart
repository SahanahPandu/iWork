import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';
import '../../widgets/cards/cards.dart';
import '../list_of_park/list_of_parks.dart';
import '../list_of_road/list_of_road.dart';
import '../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';
import 'package:eswm/widgets/buttons/report_button.dart';

class WorkSchedule extends StatefulWidget {
  final dynamic data;

  const WorkSchedule({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
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
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: barShadowColor,
              offset: const Offset(0, 3),
              blurRadius: 8,
            )
          ]),
          child: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
            ),
            title: Center(
              child: Text(
                "Perincian Tugasan",
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
        ),
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
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                      color: cardShadowColor,
                      offset: const Offset(0, 2),
                      blurRadius: 10,
                      spreadRadius: 0.5)
                ],
              ),
              child: Column(
                children: [
                  //Sub Laluan
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: userRole == 200 ? 10 : 5,
                    ),
                    child: Card(
                      elevation: userRole == 200 ? 5 : 0,
                      shadowColor: userRole == 200
                          ? Colors.grey.shade50
                          : Colors.grey.shade200,
                      child: ListOfSubRoutesTextFormField(
                        hintText: 'Senarai Sub Laluan',
                        fontSize: userRole == 200 ? 18 : 15,
                        fillColor: userRole == 200
                            ? textFormFieldFillColor
                            : fillColor,
                        iconCondition: iconCondition,
                        data: "",
                      ),
                    ),
                  ),

                  //Taman
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: userRole == 200 ? 10 : 5,
                    ),
                    child: Card(
                      elevation: userRole == 200 ? 5 : 0,
                      shadowColor: userRole == 200
                          ? Colors.grey.shade50
                          : Colors.grey.shade200,
                      child: ListOfParks(
                        showSenaraiJalan: updateShowSenaraiJalan,
                        hintText: 'Senarai Taman',
                        fontSize: userRole == 200 ? 18 : 15,
                        fillColor: userRole == 200
                            ? textFormFieldFillColor
                            : fillColor,
                        iconCondition: iconCondition,
                        data: "",
                      ),
                    ),
                  ),

                  //Senarai Jalan
                  if (_showSenaraiJalan)
                    ListOfRoad(
                      idTaman: idTaman,
                      namaTaman: "",
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          userRole == 200 ? ReportButton(dataLaluan: widget.data) : null,
    );
  }
}
