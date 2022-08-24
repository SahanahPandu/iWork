import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/device.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/gridview/compactor_panel/compactor_task_list.dart';

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
    final double categoryHeight = _device.isLandscape(context)
        ? _device.screenHeight(context) * 0.3
        : _device.screenHeight(context) * 0.25;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 30,
                  top: 15,
                  bottom: _device.isLandscape(context) ? 10 : 0),
              child: Text(
                "Hi, Suhaimi",
                style: TextStyle(
                  color: grey800,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 10,
                  top: 15,
                  bottom: _device.isLandscape(context) ? 10 : 0),
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
        const CompactorTaskList(isButton: true),
      ],
    );
  }
}
