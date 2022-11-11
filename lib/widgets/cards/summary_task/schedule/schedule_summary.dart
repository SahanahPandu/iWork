import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';

class ScheduleSummary extends StatefulWidget {
  const ScheduleSummary({Key? key}) : super(key: key);

  @override
  State<ScheduleSummary> createState() => _ScheduleSummaryState();
}

class _ScheduleSummaryState extends State<ScheduleSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text("Laluan",
            style: TextStyle(
                color: fillColor, fontWeight: FontWeight.w400, fontSize: 12)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              const SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("3",
                      style: TextStyle(
                          color: ngTextColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w700)),
                  Text("Isu",
                      style: TextStyle(
                          color: fillColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 11)),
                ],
              ),
              VerticalDivider(
                indent: 5,
                endIndent: 20,
                color: Colors.white.withOpacity(0.7),
                thickness: 0.5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("102",
                      style: TextStyle(
                          color: fillColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w700)),
                  Text("Jumlah",
                      style: TextStyle(
                          color: fillColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 11)),
                ],
              ),
              const SizedBox(width: 5)
            ])),
      )
    ]);
  }
}
