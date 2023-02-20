import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";

//import files
import '../../config/dimen.dart';
import '../../config/palette.dart';
// import '../../models/pekerja.dart';
import '../../models/schedule/schedule_data_detail_cp_sv/schedule_detail.dart';
import '../../models/user/user_data.dart';
import '../../widgets/buttons/select_employee_button.dart';

class ListOfEmployeeDetails extends StatefulWidget {
  final String? type;
  final dynamic dataPekerja;
  final Function(dynamic)? assignedEmployee;

  const ListOfEmployeeDetails({
    Key? key,
    this.type,
    this.dataPekerja,
    this.assignedEmployee,
  }) : super(key: key);

  @override
  State<ListOfEmployeeDetails> createState() => _ListOfEmployeeDetailsState();
}

class _ListOfEmployeeDetailsState extends State<ListOfEmployeeDetails> {
  String profileImage = "";
  String workerName = "";
  String roleDesc = "";
  dynamic leaveId;
  dynamic attendanceId;

  selectEmployee() {
    widget.assignedEmployee!(widget.dataPekerja);
    Navigator.pop(context);
  }

  loadData() {
    dynamic theData = widget.dataPekerja;
    if (theData.runtimeType == UserData) {
      setState(() {
        profileImage = theData.userDetail.profilePic;
        workerName = theData.userDetail.name;
        roleDesc = "Pra";
        leaveId = null;
        attendanceId = null;
      });
    } else if (theData.runtimeType == WorkerSchedule) {
      setState(() {
        profileImage = theData.userId!.userDetail!.profilePic!;
        workerName = theData.userId!.userDetail!.name!;
        roleDesc = theData.userId!.userRoles![0].roleDesc!;
        leaveId = theData.userLeaveId;
        attendanceId = theData.userAttendanceId;
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.hardEdge,
              alignment: AlignmentDirectional.center,
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                      color: transparent,
                      border: Border.all(color: grey200),
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusCircular),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(profileImage, height: 56, width: 56,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: green,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ))
              ],
            ),
            //gap between avatar and text
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: _textSize().width,
                    height: _textSize().height,
                    child: Text(
                      workerName,
                      style: textStyle,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                        roleDesc,
                        style: TextStyle(
                          color: greyCustom,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.fiber_manual_record,
                        size: 5,
                        color: greyCustom,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Kutipan, Memandu",
                        style: TextStyle(
                          color: greyCustom,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  //Status kehadiran
                  // this status only show for employee that absent
                  // if (leaveId != null || attendanceId == null)
                  _statusSection(),
                ],
              ),
            ),
          ],
        ),
        //button pilih pekerja
        if (widget.type == "Senarai Hadir")
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 104,
              height: 36,
              child: SelectEmployeeButton(onClick: selectEmployee),
            ),
          ),
      ],
    );
  }

  final TextStyle textStyle =
      TextStyle(color: blackCustom, fontSize: 15, fontWeight: FontWeight.w600);

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: workerName, style: textStyle),
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 220);
    return textPainter.size;
  }

  Widget _statusSection() {
    if (widget.dataPekerja.runtimeType == WorkerSchedule) {
      WorkerSchedule workerData = widget.dataPekerja!;
      String theAbsentStatus = "";

      if (workerData.userLeaveId != null) {
        theAbsentStatus = workerData.userLeaveId!.leaveType!.name;
      } else if (workerData.userAttendanceId == null) {
        theAbsentStatus = "Tidak Clock In";
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: orangeStatusBox,
                borderRadius: BorderRadius.circular(6),
              ),
              child: AutoSizeText(
                theAbsentStatus,
                style: TextStyle(
                  fontSize: 11,
                  color: orangeStatusText,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}
