/// ONLY MOBILE USERS REFERS TO THIS FILE
import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../list_of_park/list_of_parks.dart';
import '../list_of_road/list_of_road.dart';
import '../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';

class StreetSearch extends StatefulWidget {
  final double? height;
  final int? scMainId;

  const StreetSearch({Key? key, this.height = 0.555, this.scMainId})
      : super(key: key);

  @override
  State<StreetSearch> createState() => _StreetSearchState();
}

class _StreetSearchState extends State<StreetSearch> {
  final tamanKey = GlobalKey<ListOfParksState>();
  bool _showSenaraiTaman = false;
  bool _showSenaraiJalan = false;
  int idTaman = 0;
  int iconCondition = 1;

  // int idSubLaluan = 0;
  String namaTaman = "";
  String namaSublaluan = "";

  updateSenaraiTaman([name]) {
    setState(() {
      tamanKey.currentState?.namaTaman.clear();
      _showSenaraiTaman = true;
      // idSubLaluan = id;
      namaSublaluan = name;
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
        constraints: BoxConstraints(
            minHeight: Sizes().screenHeight(context) * 0.5 - kToolbarHeight),

        /// 0.555 = headerExpandedHeight + 0.05
        height: _showSenaraiTaman && _showSenaraiJalan
            ? null
            : (Sizes().screenHeight(context) -
                (Sizes().screenHeight(context) * widget.height!) -
                kToolbarHeight),
        color: white,
        child: Column(
          children: [
            //Sub Laluan
            Container(
              margin: const EdgeInsets.fromLTRB(17, 10, 17, 16),
              child: ListOfSubRoutesTextFormField(
                hintText: 'Sub-Laluan',
                fontSize: 15,
                fillColor: Colors.white,
                iconCondition: iconCondition,
                data: namaSublaluan,
                screen: "Work Schedule",
                scMainId: widget.scMainId,
                getSubLaluanName: updateSenaraiTaman,
              ),
            ),

            //Taman
            //if (_showSenaraiTaman)
            /// Display disabled Taman TextField if empty sublaluan ID
            namaSublaluan != ""
                ? Container(
                    margin: const EdgeInsets.only(
                      left: 17,
                      right: 17,
                    ),
                    child: ListOfParks(
                      key: tamanKey,
                      hintText: 'Senarai Taman',
                      fontSize: 15,
                      fillColor: Colors.white,
                      iconCondition: iconCondition,
                      data: namaTaman,
                      screen: "Work Schedule",
                      scMainId: widget.scMainId,
                      subRoutesName: namaSublaluan,
                      updateSenaraiJalan: updateShowSenaraiJalan,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(
                      left: 17,
                      right: 17,
                    ),
                    child: ListOfParks(
                      key: tamanKey,
                      hintText: 'Senarai Taman',
                      fontSize: 15,
                      fillColor: const Color(0xfff8f7f7),
                      iconCondition: iconCondition,
                      data: namaTaman,
                      screen: "Work Schedule",
                      scMainId: widget.scMainId,
                      subRoutesName: namaSublaluan,
                      updateSenaraiJalan: updateShowSenaraiJalan,
                    ),
                  ),

            //Senarai Jalan
            if (_showSenaraiJalan)
              ListOfRoad(
                idTaman: idTaman,
                scMainId: widget.scMainId,
              ),
          ],
        ));
  }
}
