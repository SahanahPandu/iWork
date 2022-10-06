import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../street_search/street_search.dart';
import 'pra_work_schedule_details.dart';

class PraWorkScheduleMain extends StatefulWidget {
  final Laluan? data;

  const PraWorkScheduleMain({Key? key, required this.data}) : super(key: key);

  @override
  State<PraWorkScheduleMain> createState() => _PraWorkScheduleMainState();
}

class _PraWorkScheduleMainState extends State<PraWorkScheduleMain> {
  final tamanKey = GlobalKey<ListOfParksState>();
  Color collapseBgColor = const Color(0xff2b7fe8);

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
    return const SafeArea(

        /// 0.438 = headerExpandedHeight + 0.038
        child: StreetSearch(height: 0.438));
  }

  Row _collapseTitle() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.data!.namaLaluan,
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
          status: widget.data!.status,
          statusId: widget.data!.idStatus,
          fontWeight: statusFontWeight,
          roundedCorner: true,
        )
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
              //height: Sizes().screenHeight(context) * 0.3,
              child: PraWorkScheduleDetails(data: widget.data!),
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
          "Perincian Sub-Laluan",
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
