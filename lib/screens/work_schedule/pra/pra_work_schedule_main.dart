import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/schedule/schedule_details.dart';
// import '../../../models/laluan.dart';
import '../../../providers/jadual_api.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../street_search/street_search.dart';
import 'pra_work_schedule_details.dart';

class PraWorkScheduleMain extends StatefulWidget {
  final dynamic data;

  const PraWorkScheduleMain({Key? key, required this.data}) : super(key: key);

  @override
  State<PraWorkScheduleMain> createState() => _PraWorkScheduleMainState();
}

class _PraWorkScheduleMainState extends State<PraWorkScheduleMain> {
  final tamanKey = GlobalKey<ListOfParksState>();
  Color collapseBgColor = const Color(0xff2b7fe8);
  ScheduleDetails? scheduleList;

  @override
  void initState() {
    getTheData();
    super.initState();
  }

  void getTheData() {
    Future<ScheduleDetails?>? list = JadualApi.getDataJadual(widget.data!.id);

    list!.then((data) {
      setState(() {
        scheduleList = data;
      });
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
        fixedTitleHeight: 60,
        backgroundColor: transparent,
        appBarColor: collapseBgColor,
        collapseButton: true);
  }

  SafeArea _scrollBody() {
    return SafeArea(

        /// 0.438 = headerExpandedHeight + 0.038
        child: StreetSearch(height: 0.438, scMainId: widget.data?.id));
  }

  Row _collapseTitle() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            scheduleList?.mainRoute != null
                ? scheduleList!.mainRoute
                : "Sub Laluan",
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
          status: scheduleList?.statusCode?.name != null
              ? scheduleList!.statusCode!.name
              : "Sedang Bertugas",
          statusId: scheduleList?.statusCode != null
              ? scheduleList!.statusCode
              : "SBT",
          fontWeight: statusFontWeight,
          roundedCorner: true,
        )
      ],
    );
  }

  Widget _header(BuildContext context) {
    return SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            //height: Sizes().screenHeight(context) * 0.3,
            child: PraWorkScheduleDetails(data: scheduleList),
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
