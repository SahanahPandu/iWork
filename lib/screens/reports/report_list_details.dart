import 'package:eswm/models/report/report_details/report_details_info.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../utils/calendar/date.dart';
import '../../utils/device/orientations.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/container/status_container.dart';

class ReportListDetails extends StatefulWidget {
  final ReportDetailsInfo data;
  final int index;

  const ReportListDetails({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  State<ReportListDetails> createState() => _ReportListDetailsState();
}

class _ReportListDetailsState extends State<ReportListDetails> {
  double horizontalPadding = userRole == 100 ? 34 : 20;
  Color iconColor = const Color(0xff3269F8);
  Color labelColor = greyCustom;
  Color inputColor = blackCustom;
  double gapHeight = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Orientations().isTabletPortrait(context)
          ? const EdgeInsets.only(top: 15)
          : const EdgeInsets.only(top: 15, bottom: 10),
      child: Column(
        children: [
          //laluan and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  widget.data.schCollectionMain!.mainRoute,
                  style: TextStyle(
                    fontSize: userRole == 100 ? 18 : 16,
                    color: inputColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              StatusContainer(
                type: "Laporan",
                status: widget.data.status!.statusName,
                statusId: widget.data.status!.statusCode,
                fontWeight: statusFontWeight,
              ),
            ],
          ),
          SizedBox(
            height: userRole == 200 ? 32 : 20,
          ),
          //Tarikh & Masa
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          CustomIcon.timerFill,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Tarikh & Masa",
                          style: TextStyle(
                            fontSize: userRole == 100 ? 16 : 15,
                            color: labelColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Date.getTheDate(widget.data.createdAt,
                          'yyyy-MM-dd HH:mm:ss', "dd/MM/yyyy HH:mm a", null),
                      // "${widget.data.tarikh},${widget.data.masa}",
                      style: TextStyle(
                        fontSize: userRole == 100 ? 16 : 15,
                        color: inputColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: gapHeight,
          ),
          //Taman
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          CustomIcon.tamanFill,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Taman",
                          style: TextStyle(
                            fontSize: userRole == 100 ? 16 : 15,
                            color: labelColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.data.park!.parkName,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: userRole == 100 ? 16 : 15,
                        color: inputColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: gapHeight,
          ),
          //Jalan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ClipRRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          CustomIcon.roadFill,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Jalan",
                          style: TextStyle(
                            fontSize: userRole == 100 ? 16 : 15,
                            color: labelColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.data.street != null
                          ? widget.data.street!.streetName
                          : "-",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: userRole == 100 ? 16 : 15,
                        color: inputColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: gapHeight,
          ),
          //Jenis Halangan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.exclamation,
                      size: 16,
                      color: iconColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Jenis Halangan",
                      style: TextStyle(
                        fontSize: userRole == 100 ? 16 : 15,
                        color: labelColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    widget.data.obstacleType!.obsTypeName,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: userRole == 100 ? 16 : 15,
                      color: inputColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
