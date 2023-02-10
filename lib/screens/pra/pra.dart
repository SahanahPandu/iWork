// ignore_for_file: avoid_print

import 'package:eswm/models/task/pra/general_worker_task.dart';
import 'package:eswm/providers/laluan_api.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/calendar/date.dart';
import '../../utils/font/font.dart';
import '../../widgets/buttons/time_log_button.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/listview/card_list_view.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';

class Pra extends StatefulWidget {
  const Pra({Key? key}) : super(key: key);

  @override
  State<Pra> createState() => _PraState();
}

class _PraState extends State<Pra> {
  final timeLogButtonKey = GlobalKey<TimeLogButtonState>();
  String selectedDate = Date.getTheDate(DateTime.now(), "", "yyyy-MM-dd", 'ms');

  refreshPage(Function? updateButton) {
    setState(() {
      //set state so that it will reload the clock in/ clock out time in main page
    });

    if (updateButton != null) {
      //this function to update button display
      //refer page TimeLogButton, function LoadButton
      updateButton();
    }
  }

  updateSelDate(selDate) {
    setState(() {
      selectedDate = selDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GeneralWorkerTask>(
      future: LaluanApi.getDataMasaKerja(context, selectedDate),
      builder: (context, snapshot) {
        String workingTime = "";
        String clockInTime = "";
        String clockOutTime = "";

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text("Some error occured!"),
              );
            } else {
              if (snapshot.hasData) {
                GeneralWorkerTask theData = snapshot.data!;
                TimeOfDay? startTime;
                TimeOfDay? endTime;

                //get the working time
                if (theData.startSchedule != null) {
                  startTime = Date.getTheTimeOfDay(
                      theData.startSchedule, "HH:mm:ss", "ms");
                }

                if (theData.stopSchedule != null) {
                  endTime = Date.getTheTimeOfDay(
                      theData.stopSchedule, "HH:mm:ss", "ms");
                }

                if (startTime == null || endTime == null) {
                  if (startTime == null && endTime != null) {
                    workingTime = '00:00 - ${endTime.format(context)}';
                  } else if (startTime != null && endTime == null) {
                    workingTime = '${startTime.format(context)} - 00:00';
                  } else {
                    workingTime = '00:00 - 00:00';
                  }
                } else {
                  workingTime =
                      '${startTime.format(context)} - ${endTime.format(context)}';
                }

                //get the clock time
                if (theData.attendance != null) {
                  if (theData.attendance?.clockIn != null) {
                    TimeOfDay clockIn = Date.getTheTimeOfDay(
                        theData.attendance!.clockIn, "HH:mm:ss", "ms");

                    clockInTime = clockIn.format(context);
                  }

                  if (theData.attendance?.clockOut != null) {
                    TimeOfDay clockOut = Date.getTheTimeOfDay(
                        theData.attendance!.clockOut, "HH:mm:ss", "ms");

                    clockOutTime = clockOut.format(context);
                  }
                }
                if (dioError.value == 0) {
                  isTaskDataFetched = true;
                } else {
                  isTaskDataFetched = false;
                }
              } else {
                //Show image no data;
              }

              return ExpandCollapseHeader(
                centerTitle: false,
                title: _collapseTitle(workingTime),
                alwaysShowLeadingAndAction: false,
                headerWidget:
                    _header(context, workingTime, clockInTime, clockOutTime),
                fullyStretchable: true,
                body: [
                  _scrollBody(),
                ],
                headerExpandedHeight: 0.48,
                fixedTitle: _fixedTitle(context),
                fixedTitleHeight: 60,
                backgroundColor: transparent,
                appBarColor: const Color(0xff2b7fe8),
              );
            }
        }
      },
    );
  }

  SafeArea _scrollBody() {
    return SafeArea(
        child: Container(
      constraints: const BoxConstraints(minHeight: 400),
      color: white,
      padding: const EdgeInsets.all(15),
      child: CardListView(
        type: "Laluan",
        passData: selectedDate,
      ),
    ));
  }

  Row _collapseTitle(theTime) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            backgroundColor: white54,
            radius: 20,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D"),
              radius: 18,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Tugasan Hari Ini ($theTime)",
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              Date.getTheDate(selectedDate, "yyyy-MM-dd", "dd/MM/yyyy", 'ms'),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: white,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    );
  }

  Widget _header(BuildContext context, String workingTime, String clockInTime,
      String clockOutTime) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 10, bottom: 5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: white54,
                  radius: 20,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D"),
                    radius: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    userInfo[4] != ''
                        ? "Hi, ${userInfo[4].toTitleCase()}!"
                        : "Hi, User!",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              //height: Sizes().screenHeight(context) * 0.26,
              child: TodayTaskCard(
                workTime: workingTime,
                timeIn: clockInTime,
                timeOut: clockOutTime,
                selectedDate: selectedDate,
                updateSelDate: updateSelDate,
                refresh: refreshPage,
                timeLogButtonKey: timeLogButtonKey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fixedTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          "Tugas Saya",
          style: TextStyle(
            color: blackCustom,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
