import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/laluan.dart';
import '../../../../utils/device.dart';
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

  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                //Nama Laluan & Status
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.namaLaluan,
                    style: TextStyle(
                        fontSize: 19,
                        color: grey800,
                        fontWeight: FontWeight.w900),
                  ),
                  Container(
                    width: 130,
                    decoration: BoxDecoration(
                      color: statusTask == 1
                          ? orange100
                          : (statusTask == 2 ? lightBlue : lighterGreen),
                      borderRadius: BorderRadius.circular(8),
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
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sub Laluan",
                        style: TextStyle(
                          fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                          color: grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumSubLaluan}",
                    style: TextStyle(
                      fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //No Kenderaan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_shipping,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "No. Kenderaan",
                        style: TextStyle(
                          fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                          color: grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.noKenderaan,
                    style: TextStyle(
                      fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //Jumlah Taman/Jalan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.house,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Jumlah Taman/Jalan",
                        style: TextStyle(
                          fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                          color: grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                    style: TextStyle(
                      fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //Mula Kerja/ Tamat Kerja
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Mula Kerja/Tamat Kerja",
                        style: TextStyle(
                          fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                          color: grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    statusTask == 1
                        ? '--:-- / --:--'
                        : '$_startedTime/$_endedTime',
                    style: TextStyle(
                      fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                      color: black45,
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
