import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/task/supervisor/supervisor_task.dart';
import '../../../../screens/schedule_issue/schedule_issue_main.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../container/status_container.dart';

class SupervisorMyTaskListDetails extends StatefulWidget {
  final Isu data;
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
  String taskIssueText = "";

  @override
  void initState() {
    super.initState();
    _filterTaskIssueText(widget.data.tabSubGroupSv.code);
  }

  _filterTaskIssueText(String issue) {
    switch (issue) {
      case "IHD":

        /// Kehadiran
        return taskIssueText = widget.data.tabSubGroupSv.name;
      case "IBMT":

        /// Belum Mula Kerja
        return taskIssueText = widget.data.tabSubGroupSv.name;
      case "ILHK":

        /// Laporan Halangan Kerja
        return taskIssueText = widget.data.tabSubGroupSv.name;
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
                    widget.data.mainRoute,
                    style: TextStyle(
                        fontSize: 16,
                        color: blackCustom,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                StatusContainer(
                  type: "Laluan",
                  status: widget.data.statusCode.name,
                  statusId: widget.data.statusCode.code,
                  fontWeight: statusFontWeight,
                ),
              ],
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
                    widget.data.vehicleNo,
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
                    "${widget.data.totalSubRoute}",
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
                    "${widget.data.totalPark}/${widget.data.totalStreet}",
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
        widget.button == true && widget.data.tabSubGroupSv.code != ""
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
                                issueType: widget.data.tabSubGroupSv.code)));
                  },
                ),
              )
            : const SizedBox(height: 10),
      ],
    );
  }
}
