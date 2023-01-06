import 'package:flutter/material.dart';

//import files
import '../../../config/config.dart';
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/schedule/schedule_details.dart';
import '../../../models/task/compactor/data/schedule/schedule.dart';
import '../../../providers/jadual_api.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/device/sizes.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/buttons/report_button.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../list_of_road/list_of_road.dart';
import '../../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';
import 'compactor_panel_schedule_details.dart';

class CompactorPanelScheduleMain extends StatefulWidget {
  final Schedule? data;
  final int? idx;

  const CompactorPanelScheduleMain({Key? key, required this.data, this.idx})
      : super(key: key);

  @override
  State<CompactorPanelScheduleMain> createState() =>
      _CompactorPanelScheduleMainState();
}

class _CompactorPanelScheduleMainState
    extends State<CompactorPanelScheduleMain> {
  ScheduleDetails? scheduleList;
  Color collapseBgColor = const Color(0xff3597f8);
  Color appbarColor = const Color(0xf93597f8);
  final tamanKey = GlobalKey<ListOfParksState>();
  bool _showSenaraiTaman = false;
  bool _showSenaraiJalan = false;
  int idTaman = 0;
  int iconCondition = 1;
  String namaTaman = "";
  String namaSublaluan = "";

  @override
  void initState() {
    getTheData();
    super.initState();
  }

  void getTheData() {
    Future<ScheduleDetails?>? list = JadualApi.getDataJadual(widget.data!.id!);
    scheduleId = widget.data!.id.toString();
    list!.then((value) {
      setState(() {
        scheduleList = value;
      });
    });
  }

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
                child: otherDate && selectedDate != ''
                    ? null
                    : ReportButton(
                        passData: widget.data,
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
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: _streetSearch(context),
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
          headerExpandedHeight: 0.41,
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
        child: Container(color: white, child: _streetSearch(context)));
  }

  Widget _collapseTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        widget.data!.mainRoute!,
        style: TextStyle(
          color: white,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      const SizedBox(width: 20),
      StatusContainer(
        type: "Laluan",
        status: widget.data!.statusCode!.name!,
        statusId: widget.data!.statusCode,
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
                                            child: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://i0.wp.com/i-panic.com/wp-content/uploads/2021/09/portrait-square-05.jpg?resize=400%2C400&ssl=1'),
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
                                            child: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://focusforensics.com/wp-content/uploads/staff-clayton_mccall-square.jpg'),
                                              //NetworkImage
                                              radius: 26,
                                            )))),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: CircleAvatar(
                                        backgroundColor: collapseBgColor,
                                        radius: 28,
                                        child: const CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              'https://automateonline.com.au/wp-content/uploads/2019/02/portrait-square-04.jpg'),
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
                      scMainId: widget.data!.id,
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
                            scMainId: widget.data!.id,
                            updateSenaraiJalan: updateShowSenaraiJalan,
                          ),
                        )
                      : Container(
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
                            scMainId: widget.data!.id,
                            updateSenaraiJalan: updateShowSenaraiJalan,
                          ),
                        ),

                  //Senarai Jalan
                  if (_showSenaraiJalan)
                    ListOfRoad(
                      idTaman: idTaman,
                      scMainId: widget.data!.id,
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
                          scMainId: widget.data!.id,
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
                                scMainId: widget.data!.id,
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
                                scMainId: widget.data!.id,
                                updateSenaraiJalan: updateShowSenaraiJalan,
                              ),
                            ),
                    ],
                  ),

                  //Senarai Jalan
                  if (_showSenaraiJalan)
                    ListOfRoad(
                      idTaman: idTaman,
                      scMainId: widget.data!.id,
                    ),
                ],
              ));
  }
}
