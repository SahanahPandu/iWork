import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
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
  String namaSublaluan = "";

  updateSenaraiTaman(id, [name]) {
    setState(() {
      tamanKey.currentState?.namaTaman.clear();
      _showSenaraiTaman = true;
      idSubLaluan = id;
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

        /// 0.555 = headerExpandedHeight + 0.05
        height: _showSenaraiTaman && _showSenaraiJalan
            ? null
            : (Sizes().screenHeight(context) -
                (Sizes().screenHeight(context) * widget.height!) -
                kToolbarHeight),
        color: white,
        child: userRole == 100 && !Orientations().isTabletPortrait(context)
            ? Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Sub Laluan
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 10, left: 20),
                        child: ListOfSubRoutesTextFormField(
                          hintText: 'Sub-Laluan',
                          fontSize: 15,
                          fillColor: Colors.white,
                          iconCondition: iconCondition,
                          data: namaSublaluan,
                          screen: "Work Schedule",
                          getSubLaluanId: updateSenaraiTaman,
                        ),
                      ),

                      //Taman
                      //if (_showSenaraiTaman)
                      /// Display disabled Taman TextField if empty sublaluan ID
                      namaSublaluan != ""
                          ? Container(
                              margin: const EdgeInsets.only(top: 10, right: 20),
                              width: 300,
                              child: ListOfParks(
                                key: tamanKey,
                                subRoutesId: idSubLaluan,
                                showSenaraiJalan: updateShowSenaraiJalan,
                                hintText: 'Senarai Taman',
                                fontSize: 15,
                                fillColor: Colors.white,
                                iconCondition: iconCondition,
                                data: namaTaman,
                                screen: "Work Schedule",
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 10, right: 20),
                              width: 300,
                              child: ListOfParks(
                                key: tamanKey,
                                subRoutesId: idSubLaluan,
                                showSenaraiJalan: updateShowSenaraiJalan,
                                hintText: 'Senarai Taman',
                                fontSize: 15,
                                fillColor: grey100,
                                iconCondition: iconCondition,
                                data: namaTaman,
                                screen: "Work Schedule",
                              ),
                            ),
                    ],
                  ),

                  //Senarai Jalan
                  if (_showSenaraiJalan)
                    ListOfRoad(
                      idTaman: idTaman,
                    ),
                ],
              )
            : Column(
                children: [
                  //Sub Laluan
                  Container(
                    margin: userRole == 100 &&
                            Orientations().isTabletPortrait(context)
                        ? const EdgeInsets.fromLTRB(60, 15, 60, 25)
                        : const EdgeInsets.fromLTRB(17, 10, 17, 16),
                    child: ListOfSubRoutesTextFormField(
                      hintText: 'Sub-Laluan',
                      fontSize: 15,
                      fillColor: Colors.white,
                      iconCondition: iconCondition,
                      data: namaSublaluan,
                      screen: "Work Schedule",
                      getSubLaluanId: updateSenaraiTaman,
                    ),
                  ),

                  //Taman
                  //if (_showSenaraiTaman)
                  /// Display disabled Taman TextField if empty sublaluan ID
                  namaSublaluan != ""
                      ? Container(
                          margin: userRole == 100 &&
                                  Orientations().isTabletPortrait(context)
                              ? const EdgeInsets.only(
                                  left: 60, right: 60, bottom: 10)
                              : const EdgeInsets.only(
                                  left: 17,
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
                            data: namaTaman,
                            screen: "Work Schedule",
                          ),
                        )
                      : Container(
                          margin: userRole == 100 &&
                                  Orientations().isTabletPortrait(context)
                              ? const EdgeInsets.only(
                                  left: 60, right: 60, bottom: 10)
                              : const EdgeInsets.only(
                                  left: 17,
                                  right: 17,
                                ),
                          child: ListOfParks(
                            key: tamanKey,
                            subRoutesId: idSubLaluan,
                            showSenaraiJalan: updateShowSenaraiJalan,
                            hintText: 'Senarai Taman',
                            fontSize: 15,
                            fillColor: const Color(0xfff8f7f7),
                            iconCondition: iconCondition,
                            data: namaTaman,
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
