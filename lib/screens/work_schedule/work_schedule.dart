import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';
import '../../utils/device.dart';
import 'package:eswm/widgets/buttons/report_button.dart';

import 'pra/pra_work_schedule_main.dart';
import 'supervisor/supervisor_schedule_main.dart';

class WorkSchedule extends StatefulWidget {
  final dynamic data;

  const WorkSchedule({Key? key, required this.data}) : super(key: key);

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  final bool _showSenaraiJalan = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Devices().screenHeight(context),
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
            child: userRole == 200
                ? PraWorkScheduleMain(data: widget.data)
                : SupervisorWorkScheduleMain(data: widget.data)),
        floatingActionButton: userRole == 200
            ? Container(
                margin: _showSenaraiJalan
                    ? const EdgeInsets.only(right: 45, bottom: 10)
                    : const EdgeInsets.all(0),
                child: ReportButton(dataLaluan: widget.data))
            : null,
      ),
    );
  }
}
