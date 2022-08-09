import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/pekerja.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/date.dart';

class AttendanceVerificationDetailList extends StatefulWidget {
  final Pekerja data;

  const AttendanceVerificationDetailList({Key? key, required this.data})
      : super(key: key);

  @override
  State<AttendanceVerificationDetailList> createState() =>
      _AttendanceVerificationDetailListState();
}

class _AttendanceVerificationDetailListState
    extends State<AttendanceVerificationDetailList> {
  bool val = true;
  String timeIn = "";
  Color timeInColor = black45;

  @override
  void initState() {
    _isClockedIn();
    super.initState();
  }

  bool _isClockedIn() {
    if (widget.data.timeIn != "") {
      timeIn = widget.data.timeIn;
      timeInColor = black45;
      return val = true;
    } else {
      timeIn = "Tiada Rekod";
      timeInColor = red;
      return val = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: Text(
            widget.data.name,
            style: TextStyle(
              fontSize: 15,
              color: grey800,
              fontWeight: FontWeight.w900,
            ),
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
        Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 5),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                        "Laluan",
                        style: TextStyle(
                          fontSize: 13,
                          color: grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.tiedLaluan,
                    style: TextStyle(
                      fontSize: 13,
                      color: black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                          color: grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.tiedVehicle,
                    style: TextStyle(
                      fontSize: 13,
                      color: black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        CustomIcon.timerFill,
                        size: 16,
                        color: blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Masa Masuk Kerja",
                        style: TextStyle(
                          fontSize: 13,
                          color: grey800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    timeIn,
                    style: TextStyle(
                      fontSize: 13,
                      color: timeInColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  void _toggleTimeInData(bool isTicked) {
    if (isTicked == true) {
      if (widget.data.timeIn == "") {
        if (Date.getCurrentTime().contains("AM")) {
          timeIn = "${Date.getCurrentTimeInHHMM()} pagi";
        } else {
          timeIn = "${Date.getCurrentTimeInHHMM()} petang";
        }
      } else {
        timeIn = widget.data.timeIn;
      }
      timeInColor = black45;
    } else {
      timeIn = "Tiada Rekod";
      timeInColor = red;
    }
  }
}
