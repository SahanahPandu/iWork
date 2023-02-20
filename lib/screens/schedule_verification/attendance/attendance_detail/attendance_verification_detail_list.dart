import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../utils/calendar/time.dart';

class AttendanceVerificationDetailList extends StatefulWidget {
  /// WorkersAttend list
  /// WorkersNotAttend list
  final dynamic data;
  final int? index;
  final int? lastIndex;

  const AttendanceVerificationDetailList(
      {Key? key, this.data, this.index, this.lastIndex})
      : super(key: key);

  @override
  State<AttendanceVerificationDetailList> createState() =>
      _AttendanceVerificationDetailListState();
}

class _AttendanceVerificationDetailListState
    extends State<AttendanceVerificationDetailList> {
  bool val = true;
  String timeIn = "";
  Color timeInColor = greenCustom;

  @override
  void initState() {
    _isClockedIn();
    super.initState();
  }

  bool _isClockedIn() {
    if (widget.data!.userAttendanceId == null) {
      timeIn = "Tiada Rekod";
      timeInColor = redCustom;
      tickedWorker.remove(widget.data!.userId.id);
      return val = false;
    } else {
      if (widget.data!.userAttendanceId!.clockInAt != "") {
        timeIn = widget.data!.userAttendanceId!.clockInAt!;
        timeInColor = greenCustom;
        tickedWorker.add(widget.data!.userId.id);
        return val = true;
      } else {
        timeIn = "Tiada Rekod";
        timeInColor = redCustom;
        tickedWorker.remove(widget.data!.userId.id);
        return val = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CheckboxListTile(
            checkboxShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Row(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                      ),
                      ClipRRect(
                          borderRadius:
                              BorderRadius.circular(borderRadiusCircular),
                          child: Image.network(
                            widget.data!.userId.userDetail.profilePic ==
                                    "http://ems.swmsb.com/uploads/profile/blue.png"
                                ? "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352062-stock-illustration-default-placeholder-profile-icon.jpg"
                                : widget.data!.userId.userDetail.profilePic,
                            height: 56,
                            width: 56,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: greenCustom,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ))
                    ]),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _textSize().width,
                      height: _textSize().height,
                      child: Text(
                        widget.data!.userId.userDetail.name,
                        style: textStyle,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          widget.data!.userId.userRoles[0].roleDesc,
                          style: TextStyle(
                              color: greyCustom,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.fiber_manual_record,
                          size: 5,
                          color: greyCustom,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Kutipan",
                          style: TextStyle(
                              color: greyCustom,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Masuk Kerja: ",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: greyCustom),
                            children: <TextSpan>[
                              TextSpan(
                                  text: timeIn,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: timeInColor)),
                            ]))
                  ],
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            activeColor: green,
            value: val,
            onChanged: (newValue) {
              setState(() {
                val = newValue!;
                _toggleTimeInData(val);
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget.index != widget.lastIndex
              ? const Divider(
                  thickness: 0.5,
                )
              : null,
        )
      ],
    );
  }

  final TextStyle textStyle = TextStyle(
    fontSize: 13,
    color: blackCustom,
    fontWeight: FontWeight.w500,
  );

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: widget.data!.userId.userDetail.name, style: textStyle),
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 180);
    return textPainter.size;
  }

  void _toggleTimeInData(bool isTicked) {
    if (isTicked == true) {
      if (widget.data!.userAttendanceId == null ||
          widget.data!.userAttendanceId!.clockInAt == "") {
        timeIn = Time.getCurrentTimeInHHMMSS();
      } else {
        timeIn = widget.data!.userAttendanceId!.clockInAt!;
      }
      timeInColor = greenCustom;
      tickedWorker.add(widget.data!.userId.id);
    } else {
      timeIn = "Tiada Rekod";
      timeInColor = redCustom;
      tickedWorker.remove(widget.data!.userId.id);
    }
    //print(tickedWorker);
  }
}
