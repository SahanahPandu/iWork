import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/pekerja.dart';
import '../../../../utils/device.dart';

class VerifyRescheduleListDetails extends StatefulWidget {
  final Pekerja? data;
  final int? index;

  const VerifyRescheduleListDetails({Key? key, this.data, this.index})
      : super(key: key);

  @override
  State<VerifyRescheduleListDetails> createState() =>
      _VerifyRescheduleListDetailsState();
}

class _VerifyRescheduleListDetailsState
    extends State<VerifyRescheduleListDetails> {
  final Devices _devices = Devices();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      decoration: BoxDecoration(
        border: widget.index != 2
            ? Border(
                top: BorderSide.none,
                bottom: BorderSide(
                  color: greyCustom,
                  width: 0.1,
                  style: BorderStyle.solid,
                ),
              )
            : null,
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
                        color: blackCustom,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
              Text("10/7/2022",
                  style: TextStyle(
                      color: blackCustom,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: _textSize().width,
            height: _textSize().height,
            child: Text(
              "Penyelia ${widget.data!.reportsTo} mohon untuk meminjam PRA ${widget.data!.name} di bawah seliaan anda untuk tugasan Laluan JHBP-C01 pada 10/07/2022",
              style: textStyle,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  final TextStyle textStyle = TextStyle(
      color: greyCustom,
      fontSize: 13,
      height: 1.5,
      fontWeight: FontWeight.w400);

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
            text:
                "Penyelia ${widget.data!.reportsTo} mohon untuk meminjam PRA ${widget.data!.name} di bawah seliaan anda untuk tugasan Laluan JHBP-C01 pada 10/07/2022",
            style: textStyle),
        maxLines: 2,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: _devices.screenWidth(context));
    return textPainter.size;
  }
}
