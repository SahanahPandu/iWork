import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/pekerja.dart';
import '../../../../utils/device.dart';

class VerifyRescheduleListDetails extends StatefulWidget {
  final Pekerja? data;

  const VerifyRescheduleListDetails({Key? key, this.data}) : super(key: key);

  @override
  State<VerifyRescheduleListDetails> createState() =>
      _VerifyRescheduleListDetailsState();
}

class _VerifyRescheduleListDetailsState
    extends State<VerifyRescheduleListDetails> {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data!.reportsTo,
                  style: TextStyle(
                      color: black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              SizedBox(
                width: Devices().screenWidth(context) * 0.7,
                child: Text(
                    "Penyelia ${widget.data!.reportsTo} ingin meminjam PRA ${widget.data!.name} di bawah seliaan anda untuk tugasan tertentu",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: grey400,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
