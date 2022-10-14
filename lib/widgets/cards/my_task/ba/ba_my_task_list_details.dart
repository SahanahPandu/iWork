import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/laluan.dart';
import '../../../../screens/schedule_issue/schedule_issue_main.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../utils/device/sizes.dart';
import '../../../container/status_container.dart';

class BAMyTaskListDetails extends StatefulWidget {
  final Laluan data;
  final bool? button;

  const BAMyTaskListDetails({Key? key, required this.data, this.button = true})
      : super(key: key);

  @override
  State<BAMyTaskListDetails> createState() => _BAMyTaskListDetailsState();
}

class _BAMyTaskListDetailsState extends State<BAMyTaskListDetails> {
  String taskIssueText = "";

  @override
  void initState() {
    super.initState();
    _filterTaskIssueText(widget.data.isu);
  }

  _filterTaskIssueText(String issue) {
    switch (issue) {
      case "kehadiran":
        return taskIssueText = "Kehadiran";
      case "belum":
        return taskIssueText = "Belum Mula Tugas";
      case "laporan":
        return taskIssueText = "Laporan Halangan Kerja";
    }
    return taskIssueText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //Nama Laluan & Status
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    widget.data.namaLaluan,
                    style: TextStyle(
                        fontSize: 16,
                        color: blackCustom,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                StatusContainer(
                  type: "Laluan",
                  status: widget.data.status,
                  statusId: widget.data.idStatus,
                  fontWeight: statusFontWeight,
                ),
              ],
            ),
            //Penyelia
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.user,
                        size: 16,
                        color: blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Penyelia",
                        style: TextStyle(
                          fontSize: 15,
                          color: greyCustom,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: _textSize().width,
                        height: _textSize().height,
                        child: Text(widget.data.penyelia,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color:
                                  widget.button == true && widget.data.isu != ""
                                      ? redCustom
                                      : blackCustom,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      widget.button == true && widget.data.isu != ""
                          ? const SizedBox(width: 6)
                          : Container(),
                      widget.button == true && widget.data.isu != ""
                          ? Icon(
                              CustomIcon.shuffle,
                              size: 16,
                              color: greenCustom,
                            )
                          : Container(),
                    ],
                  )
                ],
              ),
            ),
            //No Kenderaan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.truckFill,
                        size: 16,
                        color: blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "No. Kenderaan",
                        style: TextStyle(
                          fontSize: 15,
                          color: greyCustom,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.noKenderaan,
                    style: TextStyle(
                      fontSize: 15,
                      color: blackCustom,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            //Sub Laluan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.roadFill,
                        size: 16,
                        color: blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Jumlah Sub Laluan",
                        style: TextStyle(
                          fontSize: 15,
                          color: greyCustom,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumSubLaluan}",
                    style: TextStyle(
                      fontSize: 15,
                      color: blackCustom,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),

            //Jumlah Taman/Jalan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.tamanFill,
                        size: 16,
                        color: blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Jumlah Taman/Jalan",
                        style: TextStyle(
                          fontSize: 15,
                          color: greyCustom,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                    style: TextStyle(
                      fontSize: 15,
                      color: blackCustom,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.button == true && widget.data.isu != ""
            ? Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(18),
                width: Sizes().screenWidth(context),
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red.shade900),
                      minimumSize: MaterialStateProperty.all(
                          Size(Sizes().screenWidth(context), 42)),
                      backgroundColor: MaterialStateProperty.all(redCustom)),
                  child: Text(taskIssueText,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: ScheduleIssueMainScreen(
                                laluanData: widget.data,
                                issueType: widget.data.isu)));
                  },
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }

  final TextStyle textStyle = TextStyle(
    fontSize: 15,
    color: redCustom,
    fontWeight: FontWeight.w600,
  );

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.data.penyelia, style: textStyle),
        maxLines: 1,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl)
      ..layout(minWidth: 0, maxWidth: 125);
    return textPainter.size;
  }
}
