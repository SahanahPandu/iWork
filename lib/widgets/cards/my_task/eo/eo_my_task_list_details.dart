import 'package:flutter/material.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/laluan.dart';
import '../../../../screens/schedule_issue/schedule_issue_main.dart';
import '../../../../utils/device.dart';
import '../../../container/status_container.dart';

class EOMyTaskListDetails extends StatefulWidget {
  final Laluan data;
  final bool? button;

  const EOMyTaskListDetails({Key? key, required this.data, this.button = true})
      : super(key: key);

  @override
  State<EOMyTaskListDetails> createState() => _EOMyTaskListDetailsState();
}

class _EOMyTaskListDetailsState extends State<EOMyTaskListDetails> {
  final Devices _device = Devices();
  String taskIssueText = "";

  @override
  void initState() {
    super.initState();
    _filterTaskIssueText(widget.data.isu);
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

  _filterTaskIssueAction(String issue) {
    switch (issue) {
      case "kehadiran":
      case "belum":
      case "laporan":
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ScheduleIssueMainScreen(
                laluanData: widget.data, fromHome: true, issueType: issue);
          }),
        );
    }
    return null;
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    widget.data.namaLaluan,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w900),
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
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "No. Kenderaan",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.noKenderaan,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
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
                      const Icon(
                        Icons.location_on,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sub Laluan",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumSubLaluan}",
                    style: const TextStyle(
                      fontSize: 13,
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
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Jumlah Taman/Jalan",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
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
                      shadowColor: MaterialStateProperty.all(Colors.grey[300]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: red)),
                      ),
                      minimumSize: MaterialStateProperty.all(
                          Size(_device.screenWidth(context), 42)),
                      backgroundColor: MaterialStateProperty.all(white)),
                  child: Text(taskIssueText,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: red)),
                  onPressed: () {
                    _filterTaskIssueAction(widget.data.isu);
                  },
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }
}
