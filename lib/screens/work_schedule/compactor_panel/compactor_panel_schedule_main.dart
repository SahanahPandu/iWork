import 'dart:math' as math;

import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../config/resource.dart';
import '../../../models/schedule/compactor/detail/cp_schedule_detail.dart';
import '../../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../../providers/schedule/compactor_panel/compactor_schedule_api.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/alert/user_profile_dialog.dart';
import '../../../widgets/buttons/report_button.dart';
import '../../../widgets/container/staff_stack_container.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../list_of_road/list_of_road.dart';
import '../../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';
import 'compactor_panel_schedule_details.dart';

class CompactorPanelScheduleMain extends StatefulWidget {
  ///CompactorTaskList -> Schedule
  ///App Drawer -> CscheduleData
  final dynamic data;
  final int? idx;

  const CompactorPanelScheduleMain({Key? key, required this.data, this.idx})
      : super(key: key);

  @override
  State<CompactorPanelScheduleMain> createState() =>
      _CompactorPanelScheduleMainState();
}

class _CompactorPanelScheduleMainState
    extends State<CompactorPanelScheduleMain> {
  Color collapseBgColor = const Color(0xff3597f8);
  Color appbarColor = const Color(0xf93597f8);
  final tamanKey = GlobalKey<ListOfParksState>();
  bool _showSenaraiTaman = false;
  bool _showSenaraiJalan = false;
  int idTaman = 0;
  int iconCondition = 1;
  String namaTaman = "";
  String namaSublaluan = "";
  CScheduleDetail? cScheduleDetail;

  updateSenaraiTaman([name]) {
    setState(() {
      tamanKey.currentState?.namaTaman.clear();
      _showSenaraiTaman = true;
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
                            child: Text(
                                "Perincian Laluan - ${Date.getTheDate(widget.data.scheduleDate, "yyyy-MM-dd", "dd/MM/yyyy", "ms")}",
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
                child: FutureBuilder<CScheduleDetail?>(
                    future: CompactorScheduleApi.getCompactorScheduleDetail(
                        context, widget.data.id!),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 78,
                                      width: 78,
                                      child: Image.asset(opsImg)),
                                  SizedBox(
                                    height: 60,
                                    width: 200,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          overlayColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) =>
                                                      const Color(0x0f0c057a)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  transparent)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Sila Muat Semula",
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(width: 10),
                                          Icon(Icons.refresh,
                                              size: 20, color: white),
                                        ],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          refresh.value = !refresh.value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            if (snapshot.hasData) {
                              cScheduleDetail = snapshot.data!;
                              return Orientations().isLandscape(context)
                                  ? landscapeLayoutBuild(cScheduleDetail)
                                  : portraitLayoutBuild(cScheduleDetail);
                            }
                          }
                      }
                      return Container();
                    })),
            floatingActionButton: Padding(
                padding: Orientations().isLandscape(context)
                    ? const EdgeInsets.only(right: 50, bottom: 20)
                    : const EdgeInsets.only(right: 80, bottom: 20),
                child: otherDate && selectedNewDate != ''
                    ? null
                    : ReportButton(
                        passData: widget.data,
                      ))));
  }

  Widget landscapeLayoutBuild(CScheduleDetail? cScheduleDetail) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          width: Sizes().screenWidth(context) * 0.42,
          child: CompactorPanelScheduleDetails(
            data: cScheduleDetail,
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
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: _streetSearch(context),
                        )))))
          ]))
    ]);
  }

  Widget portraitLayoutBuild(CScheduleDetail? cScheduleDetail) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
      child: ExpandCollapseHeader(
          centerTitle: false,
          title: _collapseTitle(cScheduleDetail),
          headerExpandedHeight: 0.43,
          alwaysShowLeadingAndAction: false,
          headerWidget: _header(context, cScheduleDetail),
          fullyStretchable: true,
          body: [_scrollBody()],
          curvedBodyRadius: 24,
          fixedTitle: _fixedTitle(context),
          fixedTitleHeight: 80,
          backgroundColor: transparent,
          appBarColor: collapseBgColor,
          collapseHeight: 155,
          collapseFade: 102,
          collapseButton: true),
    );
  }

  Widget _scrollBody() {
    return SafeArea(
        child: Container(color: white, child: _streetSearch(context)));
  }

  Widget _collapseTitle(CScheduleDetail? cScheduleDetail) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Padding(
        padding: const EdgeInsets.only(left: 60),
        child: Text(
          widget.data.mainRoute!,
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      const SizedBox(width: 20),
      StatusContainer(
        type: "Laluan",
        status: widget.data.statusCode!.name!,
        statusId: widget.data.statusCode!.code!,
        fontWeight: statusFontWeight,
        roundedCorner: true,
      ),
      Padding(
          padding: const EdgeInsets.only(left: 120),
          child: //Senarai Staf
              SizedBox(width: 180, child: buildStackedImages(cScheduleDetail)))
    ]);
  }

  Widget buildStackedImages(CScheduleDetail? cScheduleDetail) {
    const double size = 62;
    const double xShift = 8;
    List userData = [];
    if (cScheduleDetail!.data!.details!.workerSchedules!.isNotEmpty) {
      for (int i = 0;
          i < cScheduleDetail.data!.details!.workerSchedules!.length;
          i++) {
        userData.add(cScheduleDetail.data!.details!.workerSchedules![i]);
      }
      final items = userData.map((userData) => buildImage(userData)).toList();

      return StaffStackContainer(
        items: items,
        size: size,
        xShift: xShift,
      );
    }
    return Container();
  }

  Widget buildImage(WorkerSchedule userData) {
    const double borderSize = 3;

    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(borderSize),
        color: collapseBgColor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showUserProfileDialog(
                      context,
                      userData.userId!.userDetail!.profilePic! !=
                              "http://ems.swmsb.com/uploads/profile/blue.png"
                          ? userData.userId!.userDetail!.profilePic!
                          : "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352062-stock-illustration-default-placeholder-profile-icon.jpg",
                      userData.userId!.userDetail!.name,
                      "PRA",
                      userData.userAttendanceId != null
                          ? userData.userAttendanceId!.clockInAt ?? "--:--"
                          : "--:--",
                      userData.userAttendanceId != null
                          ? userData.userAttendanceId!.clockOutAt ?? "--:--"
                          : "--:--",
                      userData.userId!.userDetail!.loginId);
                });
          },
          child: ClipOval(
            child: userData.userId!.userDetail!.profilePic! !=
                    "http://ems.swmsb.com/uploads/profile/blue.png"
                ? Image.network(
                    userData.userId!.userDetail!.profilePic!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.5),
                    child: Center(
                      child: Text(
                        userData.userId!.userDetail!.name!.substring(0, 2),
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context, cScheduleDetail) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
          child: SizedBox(
              child: CompactorPanelScheduleDetails(
            data: cScheduleDetail,
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

  /// Street search referred as widget for Tab users
  /// To avoid reinitializing street search data when device orientation changed
  Widget _streetSearch(BuildContext context) {
    return Container(
        height: _showSenaraiTaman && _showSenaraiJalan
            ? null
            : Orientations().isTabletPortrait(context)
                ? (Sizes().screenHeight(context) -
                    (Sizes().screenHeight(context) * 0.432) -
                    kToolbarHeight)
                : (Sizes().screenHeight(context) -
                    (Sizes().screenHeight(context) * 0.2) -
                    kToolbarHeight),
        color: white,

        /// Set min height of container to fill screen when search result is empty
        constraints: Orientations().isTabletPortrait(context) &&
                _showSenaraiTaman &&
                _showSenaraiJalan
            ? const BoxConstraints(minHeight: 563)
            : null,
        child: Orientations().isTabletPortrait(context)
            ? Column(
                children: [
                  //Sub Laluan
                  Container(
                    margin: Orientations().isTabletPortrait(context)
                        ? const EdgeInsets.fromLTRB(60, 15, 60, 25)
                        : const EdgeInsets.fromLTRB(17, 10, 17, 16),
                    child: ListOfSubRoutesTextFormField(
                      hintText: 'Sub-Laluan',
                      fontSize: 15,
                      fillColor: Colors.white,
                      iconCondition: iconCondition,
                      data: namaSublaluan,
                      screen: "Work Schedule",
                      scMainId: widget.data.id,
                      getSubLaluanName: updateSenaraiTaman,
                    ),
                  ),

                  //Taman
                  //if (_showSenaraiTaman)
                  /// Display disabled Taman TextField if empty sublaluan ID
                  namaSublaluan != ""
                      ? Container(
                          margin: const EdgeInsets.only(
                              left: 60, right: 60, bottom: 10),
                          child: ListOfParks(
                            key: tamanKey,
                            hintText: 'Senarai Taman',
                            fontSize: 15,
                            fillColor: Colors.white,
                            iconCondition: iconCondition,
                            data: namaTaman,
                            screen: "Work Schedule",
                            subRoutesName: namaSublaluan,
                            scMainId: widget.data.id,
                            updateSenaraiJalan: updateShowSenaraiJalan,
                          ),
                        )
                      :

                      /// Disabled when no sub-laluan data
                      Container(
                          margin: const EdgeInsets.only(
                              left: 60, right: 60, bottom: 10),
                          child: ListOfParks(
                            key: tamanKey,
                            hintText: 'Senarai Taman',
                            fontSize: 15,
                            fillColor: const Color(0xfff8f7f7),
                            iconCondition: iconCondition,
                            data: namaTaman,
                            screen: "Work Schedule",
                            subRoutesName: namaSublaluan,
                            scMainId: widget.data.id,
                            updateSenaraiJalan: updateShowSenaraiJalan,
                          ),
                        ),

                  //Senarai Jalan
                  if (_showSenaraiJalan)
                    ListOfRoad(
                      idTaman: idTaman,
                      scMainId: widget.data.id,
                    ),
                ],
              )
            : Column(
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
                          scMainId: widget.data.id,
                          getSubLaluanName: updateSenaraiTaman,
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
                                hintText: 'Senarai Taman',
                                fontSize: 15,
                                fillColor: Colors.white,
                                iconCondition: iconCondition,
                                data: namaTaman,
                                screen: "Work Schedule",
                                subRoutesName: namaSublaluan,
                                scMainId: widget.data.id,
                                updateSenaraiJalan: updateShowSenaraiJalan,
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 10, right: 20),
                              width: 300,
                              child: ListOfParks(
                                key: tamanKey,
                                hintText: 'Senarai Taman',
                                fontSize: 15,
                                fillColor: grey100,
                                iconCondition: iconCondition,
                                data: namaTaman,
                                screen: "Work Schedule",
                                subRoutesName: namaSublaluan,
                                scMainId: widget.data.id,
                                updateSenaraiJalan: updateShowSenaraiJalan,
                              ),
                            ),
                    ],
                  ),

                  //Senarai Jalan
                  if (_showSenaraiJalan)
                    ListOfRoad(
                      idTaman: idTaman,
                      scMainId: widget.data.id,
                    ),
                ],
              ));
  }
}
