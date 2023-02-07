import 'package:flutter/material.dart';

//import files
import '../../../../utils/calendar/date.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../buttons/ecuti_button.dart';
import '../../../buttons/time_log_button.dart';

// ignore: must_be_immutable
class PraTodayTaskDetails extends StatefulWidget {
  final String timeIn;
  final String timeOut;
  final String? workTime;
  String? selectedDate;
  final Function(String)? updateSelDate;
  final Function? refresh;
  final GlobalKey<TimeLogButtonState>? timeLogButtonKey;

  PraTodayTaskDetails({
    Key? key,
    required this.timeIn,
    required this.timeOut,
    this.workTime,
    this.selectedDate,
    this.updateSelDate,
    this.refresh,
    this.timeLogButtonKey,
  }) : super(key: key);

  @override
  State<PraTodayTaskDetails> createState() => _PraTodayTaskDetailsState();
}

class _PraTodayTaskDetailsState extends State<PraTodayTaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Tugasan Hari Ini (${widget.workTime})",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              Date.getTheDate(
                  widget.selectedDate, 'yyyy-MM-dd', "dd MMM yyyy", 'ms'),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              icon: const Icon(
                CustomIcon.scheduleFill,
                color: Color(0xffA0FD57),
                size: 20,
              ),
              onPressed: () async {
                DateTime? pickedDate = await Date.datePicker(context);

                if (pickedDate != null) {
                  if (widget.updateSelDate != null) {
                    String thePickedDate =
                        Date.getTheDate(pickedDate, "", "yyyy-MM-dd", 'ms');
                    widget.updateSelDate!(
                        thePickedDate); //re-call method to load list of 'Tugas Saya'

                  }
                }
              },
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        if (widget.timeIn != "" || widget.timeOut != "") _workTimeSection(),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimeLogButton(
              key: widget.timeLogButtonKey,
              timeIn: widget.timeIn,
              timeOut: widget.timeOut,
              selectedDate: widget.selectedDate,
              refresh: widget.refresh,
            ),
            const EcutiButton(),
          ],
        )
      ],
    );
  }

  Row _workTimeSection() {
    return Row(
      children: [
        if (widget.timeIn != "") _timeInSection(),
        if (widget.timeOut != "") _timeOutSection(),
      ],
    );
  }

  Row _timeInSection() {
    return Row(
      children: [
        const Icon(
          CustomIcon.timerOutline,
          color: Color(0xffA0FD57),
          size: 18,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          widget.timeIn,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Row _timeOutSection() {
    return Row(
      children: [
        const SizedBox(
          width: 25,
        ),
        const Icon(
          CustomIcon.timerOutline,
          color: Color(0xffA0FD57),
          size: 18,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          widget.timeOut,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
