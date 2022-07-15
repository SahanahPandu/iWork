import 'package:flutter/material.dart';

import 'package:eswm/config/string.dart';
import 'package:eswm/utils/device.dart';
import 'package:eswm/widgets/cards/today_task/today_task_card.dart';
import 'package:eswm/widgets/listview/compactor_task/compactor_task_list.dart';
import '../../config/palette.dart';

class CompactorPanel extends StatefulWidget {
  const CompactorPanel({Key? key}) : super(key: key);

  @override
  State<CompactorPanel> createState() => _CompactorPanelState();
}

class _CompactorPanelState extends State<CompactorPanel> {

  final Devices _device = Devices();

  bool closeTopCard = false;

  void getTopCardStatus(status) {
    setState(() {
      closeTopCard = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = _device.screenHeight(context) * 0.30;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 15),
              child: Text(
                "Hi, Suhaimi",
                style: TextStyle(
                  color: grey800,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Text(
                "BLW 7096",
                style: TextStyle(
                  color: grey500,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: closeTopCard ? 0 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: _device.screenWidth(context),
            alignment: Alignment.topCenter,
            height: closeTopCard ? 0 : categoryHeight,
            child: SizedBox(
              height: categoryHeight,
              child: const FittedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 13,
                  ),
                  child: TodayTaskCard(),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            scheduleList,
            style: TextStyle(
              color: black87,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ),
        CompactorTaskList(topCardStatus: getTopCardStatus),
      ],
    );
  }
}
