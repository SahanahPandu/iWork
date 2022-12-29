import 'package:flutter/material.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/task/compactor/data/schedule/schedule.dart';
import '../../../../utils/device/orientations.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../widgets/slide_bar/start_end_work_slide_bar.dart';
import '../../../container/status_container.dart';

class CompactorPanelMyTaskListDetails extends StatefulWidget {
  final Schedule data;
  final bool button;

  const CompactorPanelMyTaskListDetails(
      {Key? key, required this.data, required this.button})
      : super(key: key);

  @override
  State<CompactorPanelMyTaskListDetails> createState() =>
      CompactorPanelMyTaskListDetailsState();

  static CompactorPanelMyTaskListDetailsState? of(BuildContext context) =>
      context.findAncestorStateOfType<CompactorPanelMyTaskListDetailsState>();
}

class CompactorPanelMyTaskListDetailsState
    extends State<CompactorPanelMyTaskListDetails> {
  String _startedTime = "--:--";
  String _endedTime = "--:--";

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
                  statusId: widget.data.statusCode,
                  fontWeight: statusFontWeight)
              /*
              Container(
                decoration: BoxDecoration(
                  color: statusTask == 1
                      ? orange100
                      : (statusTask == 2 ? lightBlue : lighterGreen),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Center(
                    child: Text(
                      statusTask == 1
                          ? taskIdle
                          : (statusTask == 2 ? taskStarted : taskEnded),
                      style: TextStyle(
                          color: statusTask == 1
                              ? orange700
                              : (statusTask == 2 ? blue : darkGreen),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),*/
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
                          "Mula/Tamat Kerja",
                          style: TextStyle(
                            fontSize:
                                Orientations().isLandscape(context) ? 16 : 14,
                            color: greyCustom,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Orientations().isLandscape(context)
                        ? Text(
                            widget.data.vehicleChecklistId != null
                                ? '${widget.data.vehicleChecklistId!.timeOut}/${widget.data.vehicleChecklistId!.timeIn}'
                                : '--:--/--:--',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: blackCustom,
                              fontWeight: FontWeight.w500,
                            ))
                        : SizedBox(
                            width: _textSize().width,
                            height: _textSize().height,
                            child: Text(
                                widget.data.vehicleChecklistId != null
                                    ? '${widget.data.vehicleChecklistId!.timeOut}/${widget.data.vehicleChecklistId!.timeIn}'
                                    : '--:--/--:--',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: blackCustom,
                                  fontWeight: FontWeight.w500,
                                )),
                          )
                  ]))
        ]),
        widget.button == true
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      StartEndWorkSlideBar(data: widget.data)
                    ]))
            : const SizedBox()
      ],
    );
  }

  void setStartTime(String value) => setState(() => _startedTime = value);

  void setEndTime(String value) => setState(() => _endedTime = value);

  final TextStyle textStyle = TextStyle(
    color: blackCustom,
    fontWeight: FontWeight.w500,
  );

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: widget.data.vehicleChecklistId != null
                ? '${widget.data.vehicleChecklistId!.timeOut}/${widget.data.vehicleChecklistId!.timeIn}'
                : '--:--/--:--',
            style: textStyle),
        maxLines: 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl)
      ..layout(minWidth: 0, maxWidth: 110);
    return textPainter.size;
  }
}
