import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/laluan.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device/orientations.dart';
import '../../../../widgets/slide_bar/start_end_work_slide_bar.dart';

class CompactorPanelMyTaskListDetails extends StatefulWidget {
  final Laluan data;
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              //Nama Laluan & Status
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.data.namaLaluan,
                    style: TextStyle(
                        fontSize: 18,
                        color: blackCustom,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: statusTask == 1
                        ? orange100
                        : (statusTask == 2 ? lightBlue : lighterGreen),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Center(
                      child: Text(
                        statusTask == 1
                            ? taskIdle
                            : (statusTask == 2 ? taskStarted : taskEnded),
                        style: TextStyle(
                            color: statusTask == 1
                                ? orange700
                                : (statusTask == 2 ? blue : darkGreen),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //No Kenderaan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        width: 12,
                      ),
                      Text(
                        "No. Kenderaan",
                        style: TextStyle(
                          fontSize:
                              Orientations().isLandscape(context) ? 15 : 14,
                          color: greyCustom,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.noKenderaan,
                    style: TextStyle(
                      fontSize: Orientations().isLandscape(context) ? 15 : 14,
                      color: blackCustom,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //Jumlah sub laluan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        width: 10,
                      ),
                      Text(
                        "Jumlah Sub Laluan",
                        style: TextStyle(
                          fontSize:
                              Orientations().isLandscape(context) ? 15 : 14,
                          color: greyCustom,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumSubLaluan}",
                    style: TextStyle(
                      fontSize: Orientations().isLandscape(context) ? 15 : 14,
                      color: blackCustom,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //Jumlah Taman/Jalan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        width: 10,
                      ),
                      Text(
                        "Jumlah Taman/Jalan",
                        style: TextStyle(
                          fontSize:
                              Orientations().isLandscape(context) ? 15 : 14,
                          color: greyCustom,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                    style: TextStyle(
                      fontSize: Orientations().isLandscape(context) ? 15 : 14,
                      color: blackCustom,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //Mula Kerja/ Tamat Kerja
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        width: 10,
                      ),
                      Text(
                        "Mula/Tamat Kerja",
                        style: TextStyle(
                          fontSize:
                              Orientations().isLandscape(context) ? 15 : 14,
                          color: greyCustom,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    statusTask == 1
                        ? '--:-- / --:--'
                        : '$_startedTime/$_endedTime',
                    style: TextStyle(
                      fontSize: Orientations().isLandscape(context) ? 15 : 14,
                      color: blackCustom,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 10.0, bottom: 15),
            child: widget.button == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      StartEndWorkSlideBar(),
                    ],
                  )
                : null)
      ],
    );
  }

  void setStartTime(String value) => setState(() => _startedTime = value);

  void setEndTime(String value) => setState(() => _endedTime = value);
}
