import 'package:flutter/material.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/task/compactor/compactor_task.dart';
import '../../../../utils/calendar/time.dart';
import '../../../../utils/device/orientations.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../widgets/slide_bar/start_end_work_slide_bar.dart';
import '../../../container/status_container.dart';

class CompactorPanelMyTaskListDetails extends StatefulWidget {
  final dynamic data;
  final CompactorTask? compactorData;
  final bool button;
  final int? idx;

  const CompactorPanelMyTaskListDetails(
      {Key? key,
      required this.data,
      this.compactorData,
      required this.button,
      this.idx})
      : super(key: key);

  @override
  State<CompactorPanelMyTaskListDetails> createState() =>
      CompactorPanelMyTaskListDetailsState();
}

class CompactorPanelMyTaskListDetailsState
    extends State<CompactorPanelMyTaskListDetails> {
  String startTime = "--:--";
  String stopTime = "--:--";

  @override
  void initState() {
    if (widget.data.vehicleChecklistId == null) {
      startTime = "--:--";
      stopTime = "--:--";
    } else {
      if (widget.data.startWorkAt == "--:--" || widget.data.startWorkAt == "") {
        startTime = "--:--";
      } else {
        startTime = Time.convertToHM(widget.data.startWorkAt!);
      }
      if (widget.data.stopWorkAt == "--:--" || widget.data.stopWorkAt == "") {
        stopTime = "--:--";
      } else {
        stopTime = Time.convertToHM(widget.data.stopWorkAt!);
      }
      /* if (widget.data.vehicleChecklistId!.statusCode!.code == "VC1") {
      } else if (widget.data.vehicleChecklistId!.statusCode!.code == "VC2" ||
          widget.data.vehicleChecklistId!.statusCode!.code == "VC3") {}*/
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            //Nama Laluan & Status
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: Orientations().isTabletPortrait(context)
                    ? const EdgeInsets.fromLTRB(22, 20, 0, 20)
                    : const EdgeInsets.fromLTRB(40, 30, 0, 22),
                child: Text(
                  widget.data.mainRoute!,
                  style: TextStyle(
                      fontSize: 18,
                      color: blackCustom,
                      fontWeight: FontWeight.w500),
                ),
              ),
              StatusContainer(
                  type: "Laluan",
                  status: widget.data.statusCode!.name!,
                  statusId: widget.data.statusCode!.code,
                  fontWeight: statusFontWeight)
            ],
          ),
          //No Kenderaan
          Padding(
            padding: Orientations().isTabletPortrait(context)
                ? const EdgeInsets.fromLTRB(22, 0, 22, 10)
                : const EdgeInsets.fromLTRB(40, 0, 40, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.truckFill,
                      size: 18,
                      color: blue,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "No. Kenderaan",
                      style: TextStyle(
                        fontSize: Orientations().isLandscape(context) ? 16 : 14,
                        color: greyCustom,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data.vehicleNo!,
                  style: TextStyle(
                    fontSize: Orientations().isLandscape(context) ? 16 : 14,
                    color: blackCustom,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          //Jumlah sub laluan
          Padding(
            padding: Orientations().isTabletPortrait(context)
                ? const EdgeInsets.fromLTRB(22, 0, 22, 10)
                : const EdgeInsets.fromLTRB(40, 0, 40, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.roadFill,
                      size: 18,
                      color: blue,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Jumlah Sub Laluan",
                      style: TextStyle(
                        fontSize: Orientations().isLandscape(context) ? 16 : 14,
                        color: greyCustom,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.totalSubRoute}",
                  style: TextStyle(
                    fontSize: Orientations().isLandscape(context) ? 16 : 14,
                    color: blackCustom,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          //Jumlah Taman/Jalan
          Padding(
            padding: Orientations().isTabletPortrait(context)
                ? const EdgeInsets.fromLTRB(22, 0, 22, 10)
                : const EdgeInsets.fromLTRB(40, 0, 40, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.tamanFill,
                      size: 18,
                      color: blue,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Jumlah Taman/Jalan",
                      style: TextStyle(
                        fontSize: Orientations().isLandscape(context) ? 16 : 14,
                        color: greyCustom,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.totalPark}/${widget.data.totalStreet}",
                  style: TextStyle(
                    fontSize: Orientations().isLandscape(context) ? 16 : 14,
                    color: blackCustom,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          //Mula Kerja/ Tamat Kerja
          Padding(
              padding: Orientations().isTabletPortrait(context)
                  ? const EdgeInsets.symmetric(horizontal: 22)
                  : const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CustomIcon.timerFill,
                          size: 18,
                          color: blue,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Jadual Mula/Tamat",
                          style: TextStyle(
                            fontSize:
                                Orientations().isLandscape(context) ? 16 : 14,
                            color: greyCustom,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: _textSize().width,
                      height: _textSize().height,
                      child: Text(
                          '${Time.convertToHM(widget.data.startScheduleAt!)} / ${Time.convertToHM(widget.data.stopScheduleAt!)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle),
                    )
                  ]))
        ]),
        widget.button == true
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 20),
                child: Center(
                    child: StartEndWorkSlideBar(
                        data: widget.data,
                        compactorData: widget.compactorData,
                        idx: widget.idx)))
            : const SizedBox()
      ],
    );
  }

  final TextStyle textStyle = TextStyle(
    fontSize: 14,
    color: blackCustom,
    fontWeight: FontWeight.w500,
  );

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text:
                '${Time.convertToHM(widget.data.startScheduleAt!)} / ${Time.convertToHM(widget.data.stopScheduleAt!)}',
            style: textStyle),
        maxLines: 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl)
      ..layout(
          minWidth: 0,
          maxWidth: Orientations().isTabletPortrait(context) ? 90 : 300);
    return textPainter.size;
  }
}
