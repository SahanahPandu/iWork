import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/buttons/report_button.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
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
  Color collapseBgColor = const Color(0xff3597f8);
  Color appbarColor = const Color(0xf93597f8);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor:
                Orientations().isLandscape(context) ? white : appbarColor,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Container(
                    decoration: Orientations().isLandscape(context)
                        ? BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: barShadowColor,
                              offset: const Offset(0, 3),
                              blurRadius: 8,
                            )
                          ])
                        : null,
                    child: AppBar(
                        backgroundColor: Orientations().isLandscape(context)
                            ? white
                            : transparent,
                        elevation: 0,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(CustomIcon.arrowBack,
                              color: Orientations().isLandscape(context)
                                  ? blackCustom
                                  : white,
                              size: 22),
                        ),
                        title: Center(
                            child: Text("Perincian Laluan",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Orientations().isLandscape(context)
                                      ? blackCustom
                                      : white,
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
                padding: Orientations().isLandscape(context)
                    ? const EdgeInsets.only(right: 50, bottom: 20)
                    : const EdgeInsets.only(right: 80, bottom: 20),
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
          color: white,
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

  Widget portraitLayoutBuild() {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
      child: ExpandCollapseHeader(
          centerTitle: false,
          title: _collapseTitle(),
          headerExpandedHeight: 0.4,
          alwaysShowLeadingAndAction: false,
          headerWidget: _header(context),
          fullyStretchable: true,
          body: [_scrollBody()],
          curvedBodyRadius: 24,
          fixedTitle: _fixedTitle(context),
          fixedTitleHeight: 80,
          backgroundColor: transparent,
          appBarColor: collapseBgColor,
          collapseHeight: 150,
          collapseFade: 100,
          collapseButton: true),
    );
  }

  Widget _scrollBody() {
    return SafeArea(
        child:
            Container(color: white, child: const StreetSearch(height: 0.421)));
  }

  Widget _collapseTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        widget.data!.namaLaluan,
        style: TextStyle(
          color: white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      const SizedBox(width: 20),
      StatusContainer(
        type: "Laluan",
        status: widget.data!.status,
        statusId: widget.data!.idStatus,
        fontWeight: statusFontWeight,
        roundedCorner: true,
      ),
      Padding(
          padding: const EdgeInsets.only(top: 15, left: 130),
          child: //Senarai Staf
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 140,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                          child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.passthrough,
                              children: [
                                Positioned(
                                    left: 90,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: CircleAvatar(
                                            backgroundColor: collapseBgColor,
                                            radius: 28,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                widget
                                                    .data!.senaraiStaf.staf3Img,
                                              ),
                                              //NetworkImage
                                              radius: 26,
                                            )))),
                                Positioned(
                                    left: 45,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: CircleAvatar(
                                            backgroundColor: collapseBgColor,
                                            radius: 28,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  widget.data!.senaraiStaf
                                                      .staf2Img),
                                              //NetworkImage
                                              radius: 26,
                                            )))),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CircleAvatar(
                                        backgroundColor: collapseBgColor,
                                        radius: 28,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(widget
                                              .data!.senaraiStaf.staf1Img),
                                          //NetworkImage
                                          radius: 26,
                                        )))
                              ])))))
    ]);
  }

  Widget _header(BuildContext context) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
          child: SizedBox(
              //height: Sizes().screenHeight(context) * 0.3,
              child: CompactorPanelScheduleDetails(
            data: widget.data,
          )))
    ]));
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Text("Perincian Sub-Laluan",
                style: TextStyle(
                  color: blackCustom,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ))));
  }
}
