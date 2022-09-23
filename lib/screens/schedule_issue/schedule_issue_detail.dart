import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../screens/work_schedule/supervisor/supervisor_schedule_details.dart';
import '../../config/font.dart';
import '../../widgets/container/status_container.dart';
import '../../widgets/listview/card_list_view.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../reassign_employee/reassign_employee_list.dart';
import '../street_search/street_search.dart';

class ScheduleIssueDetail extends StatefulWidget {
  final Laluan getInfo;
  final String getIssue;

  const ScheduleIssueDetail({
    Key? key,
    required this.getIssue,
    required this.getInfo,
  }) : super(key: key);

  @override
  State<ScheduleIssueDetail> createState() => _ScheduleIssueDetailState();
}

class _ScheduleIssueDetailState extends State<ScheduleIssueDetail> {
  String listTitle = "Test";
  Color collapseBgColor = const Color(0xff2b7fe8);

  @override
  void initState() {
    _loadListTile();
    super.initState();
  }

  void _loadListTile() {
    switch (widget.getIssue) {
      case "kehadiran":
        listTitle = "Senarai Pekerja Tidak Hadir";
        break;
      case "laporan":
        listTitle = "Senarai Laporan";
        break;
      case "belum":
        listTitle = "Pilih Sub-Laluan & Taman:";
        break;
    }
  }

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

  SafeArea _scrollBody() {
    return SafeArea(
      child: Container(
          color: white,
          child: Column(
            children: [_getBottomList(widget.getIssue)],
          )),
    );
  }

  Widget _getBottomList(String issue) {
    switch (issue) {
      case "kehadiran":
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ReassignEmployeeList(namaLaluan: widget.getInfo.namaLaluan),
        );
      case "belum":
        return const StreetSearch();
      case "laporan":
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: CardListView(type: "Laporan"),
        );
      default:
        return Container();
    }
  }

  Row _collapseTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.getInfo.namaLaluan,
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        const SizedBox(width: 10),
        StatusContainer(
          type: "Laluan",
          status: widget.getInfo.status,
          statusId: widget.getInfo.idStatus,
          fontWeight: statusFontWeight,
          roundedCorner: true,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
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
                      left: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CircleAvatar(
                          backgroundColor: collapseBgColor,
                          radius: 20,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.getInfo.senaraiStaf.staf_3_img,
                            ),
                            //NetworkImage
                            radius: 18,
                          ), //CircleAvatar
                        ),
                      ),
                    ),
                    Positioned(
                      left: 35,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CircleAvatar(
                          backgroundColor: collapseBgColor,
                          radius: 20,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                widget.getInfo.senaraiStaf.staf_2_img),
                            radius: 18,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CircleAvatar(
                        backgroundColor: collapseBgColor,
                        radius: 20,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.getInfo.senaraiStaf.staf_1_img),
                          //NetworkImage
                          radius: 18,
                        ), //CircleAvatar
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              child: SupervisorScheduleDetails(data: widget.getInfo),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          listTitle,
          style: TextStyle(
            color: blackCustom,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
