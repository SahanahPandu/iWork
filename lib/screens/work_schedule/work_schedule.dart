import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/icon/custom_icon.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/buttons/report_button.dart';
import 'pra/pra_work_schedule_main.dart';
import 'supervisor/supervisor_work_schedule_main.dart';

class WorkSchedule extends StatefulWidget {
  final dynamic data;

  const WorkSchedule({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  @override
  void dispose() {
    button.value = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes().screenHeight(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3298F8),
            Color(0xff4A39BE),
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Scaffold(
          backgroundColor: transparent,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: white,
              statusBarIconBrightness: Brightness.dark, //android
              statusBarBrightness: Brightness.light, //ios
            ),
            backgroundColor: transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack, color: white, size: 22),
            ),
            title: Center(
              child: Text(
                "Perincian Laluan",
                style: TextStyle(
                  fontSize: 15,
                  color: white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: const [
              SizedBox(
                width: 50,
              )
            ],
          ),
          body: ScrollConfiguration(
              behavior:
                  const MaterialScrollBehavior().copyWith(overscroll: false),
              child: _getUserWorkSchedule()),
          floatingActionButton: ValueListenableBuilder(
              valueListenable: button,
              builder: (context, value, Widget? child) {
                if (userRole == 100 || userRole == 200 && value != true) {
                  return Container(
                      margin: const EdgeInsets.only(right: 45),
                      child: ReportButton(dataLaluan: widget.data));
                } else if (userRole == 100 ||
                    userRole == 200 && value == true) {
                  return ReportButton(dataLaluan: widget.data);
                } else {
                  return Container();
                }
              })),
    );
  }

  Widget _getUserWorkSchedule() {
    switch (userRole) {

      /// PRA
      case 200:
        return PraWorkScheduleMain(data: widget.data);

      /// SV | EO | BA | SAM | ROM
      case 300:
      case 400:
      case 500:
      case 600:
      case 700:
        return SupervisorWorkScheduleMain(data: widget.data);
    }
    return Container();
  }
}
