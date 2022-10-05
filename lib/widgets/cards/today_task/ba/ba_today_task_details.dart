import 'package:flutter/material.dart';

//import files
import '../../../../utils/date.dart';
import '../../../buttons/enotis_button.dart';
import '../../../buttons/time_log_button.dart';

class BATodayTaskDetails extends StatefulWidget {
  final String timeIn;
  final String timeOut;
  final Function getTimeLog;

  const BATodayTaskDetails(
      {Key? key,
      required this.timeIn,
      required this.timeOut,
      required this.getTimeLog})
      : super(key: key);

  @override
  State<BATodayTaskDetails> createState() => _BATodayTaskDetailsState();
}

class _BATodayTaskDetailsState extends State<BATodayTaskDetails> {
  String todayDate = "0";

  @override
  void initState() {
    super.initState();
    todayDate = Date.getTodayDate();
  }

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
                color: Color(0xCBFCFCFC),
                fontWeight: FontWeight.w500,
                fontSize: 16,
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
                  size: 25,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        Text(
          todayDate,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            if (widget.timeIn != "")
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
            if (widget.timeOut != "")
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
            const ENotisButton(),
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
