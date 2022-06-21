import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/buttons/ecuti_button.dart';
import 'package:eswm/widgets/buttons/time_in_button.dart';

class PraTodayTaskDetails extends StatefulWidget {
  const PraTodayTaskDetails({Key? key}) : super(key: key);

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
          children: const [
            Icon(
              Icons.timer_outlined,
              color: Colors.white,
              size: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "7:05 pagi",
              style: TextStyle(
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
          children: const [
            EcutiButton(),
            SizedBox(
              width: 10,
            ),
            TimeInButton(),
          ],
        )
      ],
    );
  }
}
