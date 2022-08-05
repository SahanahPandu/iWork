import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/cuti.dart';

class VerifyEcutiListDetails extends StatefulWidget {
  final Cuti? data;

  const VerifyEcutiListDetails({Key? key, this.data}) : super(key: key);

  @override
  State<VerifyEcutiListDetails> createState() => _VerifyEcutiListDetailsState();
}

class _VerifyEcutiListDetailsState extends State<VerifyEcutiListDetails> {
  @override
  void initState() {
    super.initState();
    _isOneDay();
  }

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
              Text(widget.data!.pemohon,
                  style: TextStyle(
                      color: black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              Text(
                  _isOneDay()
                      ? "Pada ${widget.data!.tarikhMula}"
                      : "Dari ${widget.data!.tarikhMula}",
                  style: TextStyle(
                      color: grey400,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              _isOneDay()
                  ? const SizedBox(height: 1)
                  : Text("hingga ${widget.data!.tarikhTamat}",
                      style: TextStyle(
                          color: grey400,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
            ],
          ),
          Text(widget.data!.jenisCuti,
              style: TextStyle(
                  color: black87, fontSize: 14, fontWeight: FontWeight.w800))
        ],
      ),
    );
  }

  bool _isOneDay() {
    if (widget.data!.tarikhMula == widget.data!.tarikhTamat) {
      return true;
    }
    return false;
  }
}
