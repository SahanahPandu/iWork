import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/cards/today_task/today_task_card.dart';

import '../../utils/device.dart';
import '../../widgets/tabs/task_tabs/task_tabs.dart';

class BA extends StatefulWidget {
  const BA({Key? key}) : super(key: key);

  @override
  State<BA> createState() => _BAState();
}

class _BAState extends State<BA> {
  final Devices _device = Devices();
  bool closeTopCard = false;

  void getTopCardStatus(status) {
    setState(() {
      closeTopCard = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = _device.screenHeight(context) * 0.28;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 15),
          child: Text(
            "Hi, Ali Shabin!",
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
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
                    horizontal: 15,
                  ),
                  child: TodayTaskCard(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Expanded(
          //  height: Devices().screenHeight(context) * 0.53,
            child: StackOverTabs()),
      ],
    );
  }
}
