import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../models/task/supervisor/supervisor_task.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/calendar/time.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../buttons/enotis_button.dart';
import '../../../buttons/time_log_button.dart';

class SupervisorTodayTaskDetails extends StatefulWidget {
  final SupervisorTask scheduleData;
  final Function? refreshP;

  const SupervisorTodayTaskDetails({
    Key? key,
    required this.scheduleData,
    this.refreshP,
  }) : super(key: key);

  @override
  State<SupervisorTodayTaskDetails> createState() =>
      _SupervisorTodayTaskDetailsState();
}

class _SupervisorTodayTaskDetailsState
    extends State<SupervisorTodayTaskDetails> {
  String todayDate = "0";
  String todayClockIn = "";
  String todayClockOut = "";

  @override
  void initState() {
    super.initState();
    todayDate = Date.getTheDate(DateTime.now(), '', "dd MMM yyyy", 'ms');

    /// User selected other date & selected date is not today
    if (otherDate && selectedNewDate != '') {
      todayDate = Date.getTheDate(
          DateTime.parse(selectedNewDate), '', 'dd MMM yyyy', 'ms');
    } else {
      todayDate = Date.getTheDate(DateTime.now(), '', 'dd MMM yyyy', 'ms');
    }
    if (widget.scheduleData.data.attendance != null) {
      if (widget.scheduleData.data.attendance!.clockInAt != "") {
        todayClockIn =
            Time.convertToHM(widget.scheduleData.data.attendance!.clockInAt);
      } else {
        todayClockIn = "";
      }
      if (widget.scheduleData.data.attendance!.clockOutAt != "") {
        todayClockOut =
            Time.convertToHM(widget.scheduleData.data.attendance!.clockOutAt);
      } else {
        todayClockOut = "";
      }
    } else {
      todayClockIn = "";
      todayClockOut = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Time.getTodayTaskTimeForCollapseHeader(
              widget.scheduleData.data.startWork != ""
                  ? widget.scheduleData.data.startWork!
                  : "--:--",
              widget.scheduleData.data.stopWork != ""
                  ? widget.scheduleData.data.stopWork!
                  : "--:--"),
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              todayDate,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            (otherDate && selectedNewDate != '')
                ? IconButton(
                    icon: const Icon(
                      CustomIcon.refresh,
                      color: Color(0xffA0FD57),
                      size: 20,
                    ),
                    tooltip: "Tekan untuk lihat jadual hari ini",
                    onPressed: () {
                      selectedNewDate = '';
                      otherDate = false;
                      refresh.value = !refresh.value;
                    })
                : IconButton(
                    icon: const Icon(
                      CustomIcon.scheduleFill,
                      color: Color(0xffA0FD57),
                      size: 20,
                    ),
                    tooltip: "Pilih tarikh untuk lihat jadual anda",
                    onPressed: () {
                      showDatePicker(
                        confirmText: "PILIH",
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: green,
                                onPrimary: white,
                                onSurface: black45,
                              ),
                              dialogTheme: DialogTheme(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: darkGreen, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        locale: const Locale('ms'),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 1),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                      ).then((value) {
                        String today =
                            DateFormat("yyyy-MM-dd").format(DateTime.now());
                        String newDate = value != null
                            ? DateFormat("yyyy-MM-dd").format(value)
                            : "";
                        if ((newDate != "") &&
                            (today.compareTo(newDate) != 0)) {
                          setState(() {
                            selectedNewDate = newDate;
                            otherDate = true;
                            refresh.value = !refresh.value;
                          });
                        }
                      });
                    },
                  ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            todayClockIn != ""
                ? const Icon(
                    CustomIcon.timerOutline,
                    color: Color(0xffA0FD57),
                    size: 18,
                  )
                : Container(),
            const SizedBox(
              width: 6,
            ),
            Text(
              todayClockIn,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: white,
              ),
            ),
            SizedBox(
              width: 25,
              child: todayClockOut != ""
                  ? Center(
                      child: Text(
                      "-",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: white),
                    ))
                  : null,
            ),
            todayClockOut != ""
                ? const Icon(
                    CustomIcon.timerOutline,
                    color: Color(0xffA0FD57),
                    size: 18,
                  )
                : Container(),
            const SizedBox(
              width: 6,
            ),
            Text(
              todayClockOut,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: todayClockIn != "" || todayClockOut != "" ? 20 : 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeLogButton(
                refresh: widget.refreshP,
                timeIn: todayClockIn,
                timeOut: todayClockOut),
            const ENotisButton(),
          ],
        )
      ],
    );
  }
}
