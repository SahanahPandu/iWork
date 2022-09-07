import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../utils/custom_icon.dart';
import '../../../utils/device.dart';
import '../../../widgets/cards/cards.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../list_of_road/compactor_panel/comp_list_of_road.dart';

class CompactorPanelSchedule extends StatefulWidget {
  final dynamic data;

  const CompactorPanelSchedule({Key? key, required this.data})
      : super(key: key);

  @override
  State<CompactorPanelSchedule> createState() => _CompactorPanelScheduleState();
}

class _CompactorPanelScheduleState extends State<CompactorPanelSchedule> {
  final Devices _device = Devices();
  bool _showSenaraiJalan = false;
  int idTaman = 0;
  int iconCondition = 1;
  String getTaman = "";

  updateShowSenaraiJalan(id, name) {
    setState(() {
      _showSenaraiJalan = true;
      idTaman = id;
      getTaman = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        elevation: 4,
        shadowColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
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
      body: _device.isLandscape(context)
          ? landscapeLayoutBuild()
          : portraitLayoutBuild(),
    );
  }

  Row landscapeLayoutBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: 15,
              top: 20,
              right: 15,
              bottom: 240,
            ),
            height: 320,
            child: Cards(
              type: "Comp Laluan Details",
              data: widget.data,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: white54,
                  child: ListOfParks(
                    showSenaraiJalan: updateShowSenaraiJalan,
                    hintText: 'Senarai Taman',
                    fontSize: 16,
                    fillColor: textFormFieldFillColor,
                    iconCondition: iconCondition,
                    data: "",
                  ),
                ),
              ),
              if (_showSenaraiJalan)
                CompListOfRoad(idTaman: idTaman, nameTaman: getTaman),
            ],
          ),
        )
      ],
    );
  }

  SingleChildScrollView portraitLayoutBuild() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                top: 20,
                right: 15,
                bottom: 10,
              ),
              child: Cards(
                type: "Comp Laluan Details",
                data: widget.data,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: white54,
                  child: ListOfParks(
                    showSenaraiJalan: updateShowSenaraiJalan,
                    hintText: 'Senarai Taman',
                    fontSize: 16,
                    fillColor: textFormFieldFillColor,
                    iconCondition: iconCondition,
                    data: "",
                  ),
                )),
            if (_showSenaraiJalan)
              CompListOfRoad(idTaman: idTaman, nameTaman: getTaman),
          ],
        ),
      ),
    );
  }
}
