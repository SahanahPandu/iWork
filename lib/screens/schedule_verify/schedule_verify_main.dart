// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../utils/device.dart';
import 'attendance/attendance_verify.dart';

//import 'ecuti/ecuti_verify.dart';
//import 'reschedule/reschedule_verify.dart';

class ScheduleVerifyMain extends StatefulWidget {
  final bool? isAttendanceList, isEcutiList, isReschedule;

  const ScheduleVerifyMain(
      {Key? key, this.isAttendanceList, this.isEcutiList, this.isReschedule})
      : super(key: key);

  @override
  State<ScheduleVerifyMain> createState() => _ScheduleVerifyMainState();
}

class _ScheduleVerifyMainState extends State<ScheduleVerifyMain> {
  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildVerifyCard(context, widget.isAttendanceList, "Kehadiran",
            "Sahkan Kehadiran", const AttendanceVerify()),

        /*  _buildVerifyCard(context, widget.isEcutiList, "E-Cuti", "Sahkan Cuti",
            const EcutiVerify()),
        _buildVerifyCard(context, widget.isReschedule, "Penjadualan Semula",
            "Luluskan", const RescheduleVerify()),*/
      ],
    );
  }

  Widget _buildVerifyCard(BuildContext context, bool? isCardExist,
      String? cardTitle, String? buttonTitle, redirect) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: isCardExist == true
          ? SizedBox(
              width: _device.screenWidth(context),
              height: 215,
              child: Card(
                //Tugasan Card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadowColor: white54,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardTitle!,
                        style: TextStyle(
                            color: black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: redirect),
                      ElevatedButton(
                        style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.grey[300]),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: green600)),
                            ),
                            minimumSize: MaterialStateProperty.all(
                                Size(_device.screenWidth(context), 42)),
                            backgroundColor: MaterialStateProperty.all(green)),
                        child: Text(buttonTitle!,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: white)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
