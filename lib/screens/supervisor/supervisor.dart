import 'package:eswm/utils/font/font.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../models/task/supervisor/supervisor_task.dart';
import '../../providers/task/supervisor/supervisor_task_api.dart';
import '../../utils/calendar/date.dart';
import '../../utils/calendar/time.dart';
import '../../widgets/alert/toast.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import '../../widgets/tabs/task_tab/task_tab.dart';

class Supervisor extends StatefulWidget {
  const Supervisor({Key? key}) : super(key: key);

  @override
  State<Supervisor> createState() => _SupervisorState();
}

class _SupervisorState extends State<Supervisor> {
  late SupervisorTask? scheduleData;

  @override
  void initState() {
    refresh.value = !refresh.value;
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: refresh,
        builder: (BuildContext context, value, Widget? child) {
          if (value == refresh.value) {
            return RefreshIndicator(
              color: grey,
              displacement: 20,
              edgeOffset: 40,
              strokeWidth: 3,
              backgroundColor: const Color(0xa5ffffff),
              onRefresh: () {
                return Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    setState(() {
                      refresh.value = !refresh.value;
                    });
                    isTaskDataFetched
                        ? showInfoToast(
                            context, "Halaman berjaya dimuat semula!")
                        : null;
                  },
                );
              },
              child: FutureBuilder<SupervisorTask?>(
                  future: SupervisorTaskApi.getSupervisorTaskData(context),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 200),
                                SizedBox(
                                    height: 78,
                                    width: 78,
                                    child: Image.asset(opsImg)),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: TextButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                        overlayColor:
                                            MaterialStateColor.resolveWith(
                                                (states) =>
                                                    const Color(0x0f0c057a)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                transparent)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sila Muat Semula",
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 10),
                                        Icon(Icons.refresh,
                                            size: 20, color: white),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        refresh.value = !refresh.value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          if (snapshot.hasData) {
                            scheduleData = snapshot.data!;

                            /// Failed to fetch data from internet
                            if (scheduleData!.data.startWork == null &&
                                scheduleData!.data.stopWork == null &&
                                scheduleData!.data.isu == null &&
                                scheduleData!.data.sah == null &&
                                scheduleData!.status == "" &&
                                dioError.value != 0) {
                              isTaskDataFetched = false;
                            } else {
                              isTaskDataFetched = true;
                            }
                            return ExpandCollapseHeader(
                                centerTitle: false,
                                title: _collapseTitle(),
                                alwaysShowLeadingAndAction: false,
                                headerWidget: _header(context),
                                collapseHeight: 85,
                                fullyStretchable: true,
                                body: [
                                  _scrollBody(scheduleData),
                                ],
                                backgroundColor: transparent,
                                appBarColor: const Color(0xff2b7fe8));
                          }
                        }
                    }
                    return Container();
                  }),
            );
          } else {
            return Center(
              child: SizedBox(
                height: 60,
                width: 180,
                child: TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0x0f0c057a)),
                      backgroundColor: MaterialStateProperty.all(transparent)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Muat Semula",
                        style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.refresh, size: 20, color: white),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      refresh.value = !refresh.value;
                    });
                  },
                ),
              ),
            );
          }
        });
  }

  SafeArea _scrollBody(SupervisorTask? scheduleData) {
    return SafeArea(
        child: Container(
            color: white, child: TaskStackOverTab(scheduleData: scheduleData)));
  }

  Row _collapseTitle() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            backgroundColor: white54,
            radius: 20,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.hakuhodo-global.com/wp_admin/wp-content/uploads/2017/11/Shuntaro_Ito2square.jpg"),
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
              Time.getTodayTaskTimeForCollapseHeader(
                  scheduleData!.data.startWork != ""
                      ? scheduleData!.data.startWork!
                      : "--:--",
                  scheduleData!.data.stopWork != ""
                      ? scheduleData!.data.stopWork!
                      : "--:--"),
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              _getTodayDateForCollapseHeader(),
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

  Widget _header(BuildContext context) {
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
                        "https://www.hakuhodo-global.com/wp_admin/wp-content/uploads/2017/11/Shuntaro_Ito2square.jpg"),
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
                scheduleData: scheduleData,
                refresh: refreshPage,
                timeOut: '',
                timeIn: '',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTodayDateForCollapseHeader() {
    if (otherDate && selectedNewDate != '') {
      return Date.getTheDate(
          DateTime.parse(selectedNewDate), '', 'dd MMMM yyyy', 'ms');
    } else {
      return Date.getTheDate(DateTime.now(), '', 'dd MMMM yyyy', 'ms');
    }
  }
}
