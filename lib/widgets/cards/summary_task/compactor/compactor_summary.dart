import 'package:flutter/material.dart';

import '../../../../config/palette.dart';

class CompactorSummary extends StatefulWidget {
  const CompactorSummary({Key? key}) : super(key: key);

  @override
  State<CompactorSummary> createState() => _CompactorSummaryState();
}

class _CompactorSummaryState extends State<CompactorSummary> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text("Kompaktor",
            style: TextStyle(
                color: fillColor, fontWeight: FontWeight.w400, fontSize: 12)),
      ),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IntrinsicHeight(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("5",
                        style: TextStyle(
                            color: ngTextColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w700)),
                    Text("Bengkel",
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
                    Text("28",
                        style: TextStyle(
                            color: okTextColor,
                            fontSize: 28,
                            fontWeight: FontWeight.w700)),
                    Text("Beroperasi",
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
                    Text("90",
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
                const SizedBox(width: 20)
              ])))
    ]);
  }
}
