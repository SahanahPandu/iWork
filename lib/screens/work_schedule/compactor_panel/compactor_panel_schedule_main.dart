import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/buttons/report_button.dart';
import '../../../widgets/cards/cards.dart';
import '../../street_search/street_search.dart';
import 'compactor_panel_schedule_details.dart';

class CompactorPanelScheduleMain extends StatefulWidget {
  final Laluan? data;

  const CompactorPanelScheduleMain({Key? key, required this.data})
      : super(key: key);

  @override
  State<CompactorPanelScheduleMain> createState() =>
      _CompactorPanelScheduleMainState();
}

class _CompactorPanelScheduleMainState
    extends State<CompactorPanelScheduleMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                          icon: Icon(CustomIcon.arrowBack,
                              color: blackCustom, size: 22),
                        ),
                        title: Center(
                            child: Text("Perincian Laluan",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: blackCustom,
                                  fontWeight: FontWeight.w400,
                                ))),
                        actions: const [
                          SizedBox(
                            width: 50,
                          )
                        ]))),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xff3298F8),
                  Color(0xff4A39BE),
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
              )),
              child: Orientations().isLandscape(context)
                  ? landscapeLayoutBuild()
                  : portraitLayoutBuild(),
            ),
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(right: 50, bottom: 20),
                child: ReportButton(
                  dataLaluan: widget.data,
                ))));
  }

  Widget landscapeLayoutBuild() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          width: Sizes().screenWidth(context) * 0.42,
          child: CompactorPanelScheduleDetails(
            data: widget.data,
          )),
      Container(
          color: Colors.white,
          child: Stack(alignment: Alignment.topCenter, children: [
            const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text("Perincian Sub-Laluan",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                    constraints: BoxConstraints(
                        minHeight: Sizes().screenHeight(context) * 0.81),
                    width: Sizes().screenWidth(context) * 0.58,
                    child: ScrollConfiguration(
                        behavior: const MaterialScrollBehavior()
                            .copyWith(overscroll: false),
                        child: const SingleChildScrollView(
                            child: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: StreetSearch(height: 0.2),
                        )))))
          ]))
    ]);
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
