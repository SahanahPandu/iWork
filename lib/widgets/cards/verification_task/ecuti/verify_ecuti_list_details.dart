import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/device.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 2),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Devices().screenWidth(context),
            child: Text(widget.data!.pemohon,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: blackCustom,
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.data!.jenisCuti,
                  style: TextStyle(
                      color: greyCustom,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              Text(
                  _isOneDay()
                      ? widget.data!.tarikhMula
                      : "${widget.data!.tarikhMula} - ${widget.data!.tarikhTamat}",
                  style: TextStyle(
                      color: greyCustom,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ],
          ),
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
