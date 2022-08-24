import 'package:flutter/material.dart';

//import files
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide.none,
          bottom: BorderSide(
            color: greyCustom,
            width: 0.1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.data!.namaLaluan,
              style: TextStyle(
                  color: blackCustom, fontSize: 15, fontWeight: FontWeight.w400)),
          Container(
            width: 38,
            height: 32,
            decoration: BoxDecoration(
              color: activeBoxColor,
              borderRadius:  const BorderRadius.all(Radius.circular(5))
            ),
            child: Center(
              child: Text(widget.data!.kehadiran,
                  style: TextStyle(
                      color: darkBlue, fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
    );
  }
}
