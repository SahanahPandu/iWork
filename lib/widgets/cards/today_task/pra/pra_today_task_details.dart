// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/buttons/ecuti_button.dart';
import 'package:eswm/widgets/buttons/time_log_button.dart';

class PraTodayTaskDetails extends StatefulWidget {
  late String timeIn;
  late String timeOut;
  Function getTimeLog;

  PraTodayTaskDetails(
      {Key? key,
      required this.timeIn,
      required this.timeOut,
      required this.getTimeLog})
      : super(key: key);

  @override
  State<PraTodayTaskDetails> createState() => _PraTodayTaskDetailsState();
}

class _PraTodayTaskDetailsState extends State<PraTodayTaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tugasan Hari Ini",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.date_range,
                  color: Colors.white,
                  size: 29,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const Text(
          "22/5/2022",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const Text(
          "7 pagi - 12 tengahari",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Icon(
              Icons.timer_outlined,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.timeIn,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            const Icon(
              Icons.timer_outlined,
              color: Colors.white,
              size: 18,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.timeOut,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const EcutiButton(),
            const SizedBox(
              width: 10,
            ),
            TimeLogButton(getTimeLog: widget.getTimeLog),
          ],
        )
      ],
    );
  }
}
