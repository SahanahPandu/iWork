import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/laluan.dart';

class VerifyAttendanceListDetails extends StatefulWidget {
  final Laluan? data;

  const VerifyAttendanceListDetails({Key? key, this.data}) : super(key: key);

  @override
  State<VerifyAttendanceListDetails> createState() =>
      _VerifyAttendanceListDetailsState();
}

class _VerifyAttendanceListDetailsState
    extends State<VerifyAttendanceListDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide.none,
          bottom: BorderSide(
            color: grey400,
            width: 0.3,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.data!.namaLaluan,
              style: TextStyle(
                  color: black87, fontSize: 14, fontWeight: FontWeight.w500)),
          Container(
            width: 30,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:  const BorderRadius.all(Radius.circular(5))
            ),
            child: Center(
              child: Text(widget.data!.kehadiran,
                  style: TextStyle(
                      color: Colors.blue.shade800, fontSize: 14, fontWeight: FontWeight.w700)),
            ),
          )
        ],
      ),
    );
  }
}
