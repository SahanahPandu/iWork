import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/pekerja.dart';
import '../../../../utils/device/sizes.dart';

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
          Text("Penyelia",
              style: TextStyle(
                  fontSize: 13,
                  color: blackCustom,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          SizedBox(
            width: _textSize(widget.data!.reportsTo).width,
            height: _textSize(widget.data!.reportsTo).height,
            child: Text(widget.data!.reportsTo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    color: greyCustom,
                    fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 10),
          Text("PRA",
              style: TextStyle(
                  fontSize: 13,
                  color: blackCustom,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          SizedBox(
            width: _textSize(widget.data!.name).width,
            height: _textSize(widget.data!.name).height,
            child: Text(widget.data!.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    color: greyCustom,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }

  final TextStyle textStyle =
      TextStyle(fontSize: 13, color: greyCustom, fontWeight: FontWeight.w400);

  Size _textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        maxLines: 1,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: Sizes().screenWidth(context));
    return textPainter.size;
  }
}
