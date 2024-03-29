import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../street_search/street_search.dart';
import 'supervisor_work_schedule_details.dart';

class SupervisorWorkScheduleMain extends StatefulWidget {
  final Laluan? data;

  const SupervisorWorkScheduleMain({Key? key, required this.data})
      : super(key: key);

  @override
  State<SupervisorWorkScheduleMain> createState() =>
      _SupervisorWorkScheduleMainState();
}

class _SupervisorWorkScheduleMainState
    extends State<SupervisorWorkScheduleMain> {
  Color collapseBgColor = const Color(0xff2b7fe8);

  @override
  Widget build(BuildContext context) {
    return ExpandCollapseHeader(
        centerTitle: false,
        title: _collapseTitle(),
        headerExpandedHeight: 0.52,
        alwaysShowLeadingAndAction: false,
        headerWidget: _header(context),
        fullyStretchable: true,
        body: [
          _scrollBody(),
        ],
        curvedBodyRadius: 24,
        fixedTitle: _fixedTitle(context),
        fixedTitleHeight: 60,
        collapseFade: 70,
        backgroundColor: transparent,
        appBarColor: collapseBgColor);
  }

  Widget _scrollBody() {
    return const SafeArea(child: StreetSearch());
  }

  Widget _collapseTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        widget.data!.namaLaluan,
        style: TextStyle(
          color: white,
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
      ),
      const SizedBox(width: 10),
      StatusContainer(
        type: "Laluan",
        status: widget.data!.status,
        statusId: widget.data!.idStatus,
        fontWeight: statusFontWeight,
        roundedCorner: true,
      ),
      Padding(
          padding: const EdgeInsets.only(top: 20),
          child: //Senarai Staf
              Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                      width: 140,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                          child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.passthrough,
                              children: [
                                Positioned(
                                    left: 70,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: CircleAvatar(
                                            backgroundColor: collapseBgColor,
                                            radius: 20,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                widget
                                                    .data!.senaraiStaf.staf3Img,
                                              ),
                                              //NetworkImage
                                              radius: 18,
                                            )))),
                                Positioned(
                                    left: 35,
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: CircleAvatar(
                                            backgroundColor: collapseBgColor,
                                            radius: 20,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  widget.data!.senaraiStaf
                                                      .staf2Img),
                                              //NetworkImage
                                              radius: 18,
                                            )))),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CircleAvatar(
                                        backgroundColor: collapseBgColor,
                                        radius: 20,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(widget
                                              .data!.senaraiStaf.staf1Img),
                                          //NetworkImage
                                          radius: 18,
                                        )))
                              ])))))
    ]);
  }

  Widget _header(BuildContext context) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            //height: Sizes().screenHeight(context) * 0.3,
            child: SupervisorScheduleDetails(data: widget.data!),
          ))
    ]));
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Text("Perincian Sub-Laluan",
                style: TextStyle(
                  color: blackCustom,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ))));
  }
}
