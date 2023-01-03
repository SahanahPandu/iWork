import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
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

  @override
  void initState() {
    super.initState();
    todayDate = Date.getDetailedTodayDate();
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
        "Tugasan Hari Ini (${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.schedules![0].startWorkAt!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.schedules![0].startWorkAt!)} - ${DateFormat("hh:mm").format(DateTime.parse('20222312 ${widget.scheduleData!.data!.schedules![0].stopWorkAt!}'))} ${Time.convertAMPMToMs(widget.scheduleData!.data!.schedules![0].stopWorkAt!)})",
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
          IconButton(
            icon: const Icon(
              CustomIcon.scheduleFill,
              color: Color(0xffA0FD57),
              size: 30,
            ),
            onPressed: () {},
          )
        ]),
        //Senarai Staf
        Align(
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
                                  backgroundColor:
                                      Orientations().isTabletPortrait(context)
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
                                  backgroundColor:
                                      Orientations().isTabletPortrait(context)
                                          ? const Color(0xec3f67ea)
                                          : const Color(0xec4357d0),
                                  radius: 32,
                                  child: CircleAvatar(
                                      backgroundColor: transparent,
                                      backgroundImage: const NetworkImage(
                                          "https://www.jurispro.com/files/photos/user_4473.jpg?m=1605811497"),
                                      radius: 30)))),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
      ])
    ]);
  }
}
