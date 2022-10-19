import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/cards/cards.dart';
import '../../street_search/street_search.dart';

class CompactorPanelSchedule extends StatefulWidget {
  final dynamic data;

  const CompactorPanelSchedule({Key? key, required this.data})
      : super(key: key);

  @override
  State<CompactorPanelSchedule> createState() => _CompactorPanelScheduleState();
}

class _CompactorPanelScheduleState extends State<CompactorPanelSchedule> {
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
                "Perincian Laluan",
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
      body: Orientations().isLandscape(context)
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
            child: Column(children: const [
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: StreetSearch(),
          )
        ]))
      ],
    );
  }

  SingleChildScrollView portraitLayoutBuild() {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Column(children: [
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
              const StreetSearch(height: 0.438)
            ])));
  }
}
