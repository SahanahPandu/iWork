import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../models/task/compactor/compactor_task.dart';
import '../../../../models/task/compactor/data/workers/workers.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/device/orientations.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../alert/user_profile_dialog.dart';
import '../../../container/staff_stack_container.dart';

class CompactorPanelTodayTaskDetails extends StatefulWidget {
  final CompactorTask? scheduleData;

  const CompactorPanelTodayTaskDetails({Key? key, this.scheduleData})
      : super(key: key);

  @override
  State<CompactorPanelTodayTaskDetails> createState() =>
      _CompactorPanelTodayTaskDetailsState();
}

class _CompactorPanelTodayTaskDetailsState
    extends State<CompactorPanelTodayTaskDetails>
    with TickerProviderStateMixin {
  String todayDate = "0";
  String todayTask = "";

  @override
  void initState() {
    super.initState();
    if (otherDate && selectedNewDate != '') {
      todayDate = Date.getTheDate(
          DateTime.parse(selectedNewDate), '', 'dd MMMM yyyy', 'ms');

      if (Date.isDateExpired(DateTime.parse(selectedNewDate))) {
        todayTask = isScheduleListExist
            ? "Tugasan Masa Lalu (${DateFormat("hh:mm a").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.startWork!}')).toLowerCase()} - ${DateFormat("hh:mm a").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.stopWork!}')).toLowerCase()})"
            : "Tugasan Masa Lalu ( --:-- )";
      } else {
        todayTask = isScheduleListExist
            ? "Tugasan Akan Datang (${DateFormat("hh:mm a").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.startWork!}')).toLowerCase()} - ${DateFormat("hh:mm a").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.stopWork!}')).toLowerCase()})"
            : "Tugasan Akan Datang ( --:-- )";
      }
    } else {
      todayDate = Date.getTheDate(DateTime.now(), '', 'dd MMMM yyyy', 'ms');
      todayTask = isScheduleListExist
          ? "Tugasan Hari Ini (${DateFormat("hh:mm a").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.startWork!}')).toLowerCase()} - ${DateFormat("hh:mm a").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.stopWork!}')).toLowerCase()})"
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
          (otherDate && selectedNewDate != '')
              ? IconButton(
                  icon: const Icon(
                    CustomIcon.refresh,
                    color: Color(0xffA0FD57),
                    size: 30,
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
                    size: 30,
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
                      if ((newDate != "") && (today.compareTo(newDate) != 0)) {
                        setState(() {
                          selectedNewDate = newDate;
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
            ? SizedBox(
                width: 180,
                child: widget.scheduleData!.data!.workers!.isNotEmpty
                    ? buildStackedImages()
                    : null)
            : Container()
      ])
    ]);
  }

  Widget buildStackedImages() {
    const double size = 65;
    const double xShift = 10;
    List userData = [];
    if (widget.scheduleData!.data!.workers!.isNotEmpty) {
      for (int i = 0; i < widget.scheduleData!.data!.workers!.length; i++) {
        userData.add(widget.scheduleData!.data!.workers![i]);
      }
      final items = userData.map((userData) => buildImage(userData)).toList();

      return StaffStackContainer(
        items: items,
        size: size,
        xShift: xShift,
      );
    }
    return Container();
  }

  Widget buildImage(Worker? userData) {
    const double borderSize = 3;

    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(borderSize),
        color: Orientations().isTabletPortrait(context)
            ? const Color(0xec3f67ea)
            : const Color(0xec4357d0),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showUserProfileDialog(
                      context,
                      widget.scheduleData!.data!.workers!.isNotEmpty
                          ? userData
                          : null,
                      userData!.userId!.userDetail!.profilePic! !=
                              "http://ems.swmsb.com/uploads/profile/blue.png"
                          ? userData.userId!.userDetail!.profilePic!
                          : "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352062-stock-illustration-default-placeholder-profile-icon.jpg");
                });
          },
          child: ClipOval(
            child: userData!.userId!.userDetail!.profilePic! !=
                    "http://ems.swmsb.com/uploads/profile/blue.png"
                ? Image.network(
                    userData.userId!.userDetail!.profilePic!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.5),
                    child: Center(
                      child: Text(
                        userData.userId!.userDetail!.name!.substring(0, 2),
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
