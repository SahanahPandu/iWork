import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';
import '../../widgets/buttons/report_button.dart';
import '../../widgets/cards/cards.dart';
import '../list_of_park/list_of_parks.dart';
import '../list_of_road/list_of_road.dart';
import '../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';

class WorkSchedule extends StatefulWidget {
  final dynamic data;

  const WorkSchedule({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  final tamanKey = GlobalKey<ListOfParksState>();
  bool _showSenaraiTaman = false;
  bool _showSenaraiJalan = false;
  int idTaman = 0;
  int iconCondition = 1;
  int idSubLaluan = 0;
  String namaTaman = "";

  updateSenaraiTaman(id) {
    setState(() {
      tamanKey.currentState?.namaTaman.clear();
      _showSenaraiTaman = true;
      idSubLaluan = id;
    });
  }

  updateShowSenaraiJalan(id, [name]) {
    setState(() {
      _showSenaraiJalan = true;
      idTaman = id;
      namaTaman = name;
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
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 16,
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
                      color: grey100,
                      offset: const Offset(0, -5),
                      blurRadius: 5,
                      spreadRadius: 0.5)
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 24,
                    ),
                    child: Text(
                      "Perincian Sub-Laluan ",
                      style: TextStyle(
                        color: blackCustom,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  //Sub Laluan
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 17, 16),
                    child: ListOfSubRoutesTextFormField(
                      hintText: 'Sub-Laluan',
                      fontSize: 15,
                      fillColor: Colors.white,
                      iconCondition: iconCondition,
                      data: "",
                      screen: "Work Schedule",
                      getSubLaluanId: updateSenaraiTaman,
                    ),
                  ),

                  //Taman
                  if (_showSenaraiTaman)
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                        right: 17,
                      ),
                      child: ListOfParks(
                        key: tamanKey,
                        subRoutesId: idSubLaluan,
                        showSenaraiJalan: updateShowSenaraiJalan,
                        hintText: 'Senarai Taman',
                        fontSize: 15,
                        fillColor: Colors.white,
                        iconCondition: iconCondition,
                        data: "",
                        screen: "Work Schedule",
                      ),
                    ),

                  //Senarai Jalan
                  if (_showSenaraiJalan)
                    ListOfRoad(
                      idTaman: idTaman,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: userRole == 200
          ? Container(
              margin: _showSenaraiJalan
                  ? const EdgeInsets.only(right: 45, bottom: 10)
                  : const EdgeInsets.all(0),
              child: ReportButton(dataLaluan: widget.data))
          : null,
    );
  }
}
