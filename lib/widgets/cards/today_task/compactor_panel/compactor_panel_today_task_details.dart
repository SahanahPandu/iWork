import 'package:flutter/material.dart';

//import files
import '../../../../utils/custom_icon.dart';
import '../../../../utils/date.dart';
import '../../../../utils/device/orientations.dart';

class CompactorPanelTodayTaskDetails extends StatefulWidget {
  final String timeIn;
  final String timeOut;
  final Function getTimeLog;

  const CompactorPanelTodayTaskDetails(
      {Key? key,
      required this.timeIn,
      required this.timeOut,
      required this.getTimeLog})
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
      const Text(
        "Tugasan Hari Ini (7:00 pagi - 12:30 petang)",
        style: TextStyle(
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
                width: 180,
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
                                          : const Color(0xec3f52c5),
                                  radius: 32,
                                  child: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://www.fortisconstruction.com/images/uploads/people/_small-grid/arnel_cabais_headshot.jpg"),
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
                                          : const Color(0xec3f52c5),
                                  radius: 32,
                                  child: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://www.jurispro.com/files/photos/user_4473.jpg?m=1605811497"),
                                      radius: 30)))),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: CircleAvatar(
                              backgroundColor:
                                  Orientations().isTabletPortrait(context)
                                      ? const Color(0xec3f67ea)
                                      : const Color(0xec3f52c5),
                              radius: 32,
                              child: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://miro.medium.com/max/800/1*7hkI-ZKsglnbjxCRV1bMZA.png"),
                                radius: 30,
                              )))
                    ])))
      ])
    ]);
  }
}
