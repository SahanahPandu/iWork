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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: Text(widget.data!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ),
              Text("10/7/2022",
                  style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: Devices().screenWidth(context) * 0.75,
            child: Text(
                "Penyelia C ingin meminjam PRA ${widget.data!.name} di bawah seliaan anda untuk tugasan Laluan JHBP-C01 pada 10/07/2022",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
