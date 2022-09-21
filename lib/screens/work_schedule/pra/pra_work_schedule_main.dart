import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../list_of_road/list_of_road.dart';
import '../../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';
import 'pra_work_schedule_details.dart';

class PraWorkScheduleMain extends StatefulWidget {
  final Laluan? data;

  const PraWorkScheduleMain({Key? key, required this.data}) : super(key: key);

  @override
  State<PraWorkScheduleMain> createState() => _PraWorkScheduleMainState();
}

class _PraWorkScheduleMainState extends State<PraWorkScheduleMain> {
  final tamanKey = GlobalKey<ListOfParksState>();
  bool _showSenaraiTaman = false;
  bool _showSenaraiJalan = false;
  int idTaman = 0;
  int iconCondition = 1;
  int idSubLaluan = 0;
  String namaTaman = "";
  Color collapseBgColor = const Color(0xff2b7fe8);

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
    return ExpandCollapseHeader(
        centerTitle: false,
        title: _collapseTitle(),
        headerExpandedHeight: 0.4,
        alwaysShowLeadingAndAction: false,
        headerWidget: _header(context),
        fullyStretchable: true,
        body: [
          _scrollBody(),
        ],
        curvedBodyRadius: 24,
        fixedTitle: _fixedTitle(context),
        backgroundColor: transparent,
        appBarColor: collapseBgColor);
  }

  SafeArea _scrollBody() {
    return SafeArea(
        child: Container(
            height: 600,
            color: white,
            child: Column(
              children: [
                //Sub Laluan
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 10, 17, 16),
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
            )));
  }

  Row _collapseTitle() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.data!.namaLaluan,
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(width: 10),
        StatusContainer(
          type: "Laluan",
          status: widget.data!.status,
          statusId: widget.data!.idStatus,
          fontWeight: statusFontWeight,
          roundedCorner: true,
        )
      ],
    );
  }

  Widget _header(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              //height: Devices().screenHeight(context) * 0.3,
              child: PraWorkScheduleDetails(data: widget.data!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          "Perincian Sub-Laluan ",
          style: TextStyle(
            color: blackCustom,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
