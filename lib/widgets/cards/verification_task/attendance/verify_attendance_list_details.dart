import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/task/supervisor/supervisor_task.dart';

class VerifyAttendanceListDetails extends StatefulWidget {
  final int? index;
  final int? lastItem;
  final Attendance? data;

  const VerifyAttendanceListDetails(
      {Key? key, this.index, this.data, this.lastItem})
      : super(key: key);

  @override
  State<VerifyAttendanceListDetails> createState() =>
      _VerifyAttendanceListDetailsState();
}

class _VerifyAttendanceListDetailsState
    extends State<VerifyAttendanceListDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        border: widget.index != widget.lastItem
            ? Border(
                top: BorderSide.none,
                bottom: BorderSide(
                  color: greyCustom,
                  width: 0.1,
                  style: BorderStyle.solid,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.data!.mainRoute!,
              style: TextStyle(
                  color: blackCustom,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
          Container(
            width: 38,
            height: 32,
            decoration: BoxDecoration(
                color: activeBoxColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.data!.workersAttendedCount.toString(),
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                Text("/",
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                Text(widget.data!.totalWorker.toString(),
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
