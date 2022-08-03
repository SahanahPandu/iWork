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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.data!.namaLaluan,
            style: TextStyle(
                color: black87, fontSize: 14, fontWeight: FontWeight.w400)),
        Text(widget.data!.kehadiran,
            style: TextStyle(
                color: black87, fontSize: 14, fontWeight: FontWeight.w600))
      ],
    );
  }
}
