import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../models/task/compactor/compactor_task.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/calendar/time.dart';
import '../../../../utils/device/orientations.dart';
import '../../../../utils/icon/custom_icon.dart';

class CompactorPanelTodayTaskDetails extends StatefulWidget {
  final CompactorTask? scheduleData;

  const CompactorPanelTodayTaskDetails({Key? key, this.scheduleData})
      : super(key: key);

  @override
  State<CompactorPanelTodayTaskDetails> createState() =>
      _CompactorPanelTodayTaskDetailsState();
}

class _CompactorPanelTodayTaskDetailsState
    extends State<CompactorPanelTodayTaskDetails> {
  String todayDate = "0";
  String todayTask = "";

  @override
  void initState() {
    super.initState();
    if (otherDate && selectedDate != '') {
      todayDate = Date.getTheDate(
          DateTime.parse(selectedDate), '', 'dd MMMM yyyy', 'ms');

      if (Date.isDateExpired(DateTime.parse(selectedDate))) {
        todayTask = isScheduleListExist
            ? "Tugasan Masa Lalu (${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.startWork!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.startWork!)} - ${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.stopWork!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.stopWork!)})"
            : "Tugasan Masa Lalu ( --:-- )";
      } else {
        todayTask = isScheduleListExist
            ? "Tugasan Akan Datang (${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.startWork!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.startWork!)} - ${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.stopWork!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.stopWork!)})"
            : "Tugasan Akan Datang ( --:-- )";
      }
    } else {
      todayDate = Date.getTheDate(DateTime.now(), '', 'dd MMMM yyyy', 'ms');
      todayTask = isScheduleListExist
          ? "Tugasan Hari Ini (${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.startWork!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.startWork!)} - ${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.stopWork!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.stopWork!)})"
          : "Tugasan Hari ini ( --:-- )";
    }
  }

  //------------------------------------------------------
  // Build widget.
  //------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 15,
      ),
      Text(
        todayTask,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Text(
            todayDate,
            style: const TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: Orientations().isTabletPortrait(context) ? 10 : 30,
          ),
          (otherDate && selectedDate != '')
              ? IconButton(
                  icon: const Icon(
                    CustomIcon.refresh,
                    color: Color(0xffA0FD57),
                    size: 30,
                  ),
                  onPressed: () {
                    selectedDate = '';
                    otherDate = false;
                    refresh.value = !refresh.value;
                  })
              : IconButton(
                  icon: const Icon(
                    CustomIcon.scheduleFill,
                    color: Color(0xffA0FD57),
                    size: 30,
                  ),
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
                      if (value != null) {
                        setState(() {
                          selectedDate = DateFormat("yyyy-MM-dd").format(value);
                          otherDate = true;
                          refresh.value = !refresh.value;
                        });
                      }
                    });
                  },
                )
        ]),
        //Senarai Staf
        isScheduleListExist
            ? Align(
                alignment: Alignment.centerRight,
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: 170,
                    child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.passthrough,
                        children: [
                          Positioned(
                              left: 108,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: CircleAvatar(
                                      backgroundColor: Orientations()
                                              .isTabletPortrait(context)
                                          ? const Color(0xec3f67ea)
                                          : const Color(0xec4357d0),
                                      radius: 32,
                                      child: CircleAvatar(
                                          backgroundColor: transparent,
                                          backgroundImage: const NetworkImage(
                                              "https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D"),
                                          radius: 30)))),
                          Positioned(
                              left: 54,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: CircleAvatar(
                                      backgroundColor: Orientations()
                                              .isTabletPortrait(context)
                                          ? const Color(0xec3f67ea)
                                          : const Color(0xec4357d0),
                                      radius: 32,
                                      child: CircleAvatar(
                                          backgroundColor: transparent,
                                          backgroundImage: const NetworkImage(
                                              "https://www.jurispro.com/files/photos/user_4473.jpg?m=1605811497"),
                                          radius: 30)))),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: CircleAvatar(
                                  backgroundColor:
                                      Orientations().isTabletPortrait(context)
                                          ? const Color(0xec3f67ea)
                                          : const Color(0xec4357d0),
                                  radius: 32,
                                  child: CircleAvatar(
                                    backgroundColor: transparent,
                                    backgroundImage: const NetworkImage(
                                        "https://miro.medium.com/max/800/1*7hkI-ZKsglnbjxCRV1bMZA.png"),
                                    radius: 30,
                                  )))
                        ])))
            : Container()
      ])
    ]);
  }
}
