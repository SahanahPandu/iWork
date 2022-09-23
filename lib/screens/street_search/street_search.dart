import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/device.dart';
import '../list_of_park/list_of_parks.dart';
import '../list_of_road/list_of_road.dart';
import '../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';

class StreetSearch extends StatefulWidget {
  final double? height;
  const StreetSearch({Key? key, this.height = 0.555}) : super(key: key);

  @override
  State<StreetSearch> createState() => _StreetSearchState();
}

class _StreetSearchState extends State<StreetSearch> {
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
    return Container(

        /// 0.555 = headerExpandedHeight + 0.05
        height: _showSenaraiTaman && _showSenaraiJalan
            ? null
            : (Devices().screenHeight(context) -
                (Devices().screenHeight(context) * widget.height!) -
                kToolbarHeight),
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
        ));
  }
}
