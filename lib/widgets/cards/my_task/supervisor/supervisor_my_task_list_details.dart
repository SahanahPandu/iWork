import 'package:flutter/material.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/laluan.dart';
import '../../../../screens/schedule_issue/schedule_issue_main.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device.dart';
import '../../../container/status_container.dart';

class SupervisorMyTaskListDetails extends StatefulWidget {
  final Laluan data;
  final bool? button;

  const SupervisorMyTaskListDetails(
      {Key? key, required this.data, this.button = true})
      : super(key: key);

  @override
  State<SupervisorMyTaskListDetails> createState() =>
      _SupervisorMyTaskListDetailsState();
}

class _SupervisorMyTaskListDetailsState
    extends State<SupervisorMyTaskListDetails> {
  final Devices _device = Devices();
  late Color statusTextColor;
  late Color statusBoxColor;
  String taskIssueText = "";

  @override
  void initState() {
    super.initState();
    _filterData();
    _filterTaskIssueText(widget.data.isu);
  }

  _filterData() {
    //default status belum dimulakan
    Color textColor = Colors.grey;
    Color boxColor = Colors.grey.shade100;

    if (widget.data.idStatus == 2) {
      //Sedang Bertugas

      textColor = Colors.blue.shade800;
      boxColor = Colors.blue.shade100;
    } else if (widget.data.idStatus == 3) {
      //Tugasan Selesai

      textColor = Colors.green;
      boxColor = const Color(0xffc9ffd7);
    }

    setState(() {
      statusTextColor = textColor;
      statusBoxColor = boxColor;
    });
  }

  _filterTaskIssueText(String issue) {
    switch (issue) {
      case "kehadiran":
        return taskIssueText = "Kehadiran (2/3)";
      case "belum":
        return taskIssueText = "Belum Mula Tugas";
      case "laporan":
        return taskIssueText = "Laporan";
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                //Nama Laluan & Status
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.namaLaluan,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w900),
                  ),
                  StatusContainer(
                    boxColor: statusBoxColor,
                    status: widget.data.status,
                    textColor: statusTextColor,
                    fontWeight: statusFontWeight,
                  ),
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
                          fontSize: 13,
                          color: grey400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.noKenderaan,
                    style: TextStyle(
                      fontSize: 13,
                      color: black87,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            //Sub Laluan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                          fontSize: 13,
                          color: grey400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumSubLaluan}",
                    style: TextStyle(
                      fontSize: 13,
                      color: black87,
                      fontWeight: FontWeight.w700,
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
                      Icon(
                        CustomIcon.tamanFill,
                        size: 18,
                        color: blue,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Jumlah Taman/Jalan",
                        style: TextStyle(
                          fontSize: 13,
                          color: grey400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                    style: TextStyle(
                      fontSize: 13,
                      color: black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.button == true
            ? Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                width: _device.screenWidth(context) * 0.75,
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red.shade900),
                      minimumSize: MaterialStateProperty.all(
                          Size(_device.screenWidth(context), 42)),
                      backgroundColor: MaterialStateProperty.all(red)),
                  child: Text(taskIssueText,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: white)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ScheduleIssueMainScreen(
                            laluanData: widget.data,
                            fromHome: true,
                            issueType: widget.data.isu);
                      }),
                    );
                  },
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }
}
