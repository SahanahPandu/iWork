import 'package:eswm/utils/font/font.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/task/supervisor/supervisor_task.dart';
import '../../../../utils/device/sizes.dart';

class VerifyRequestWorkerListDetails extends StatefulWidget {
  final WorkerRequest data;
  final int? index;
  final int? lastItem;

  const VerifyRequestWorkerListDetails(
      {Key? key, required this.data, this.index, this.lastItem})
      : super(key: key);

  @override
  State<VerifyRequestWorkerListDetails> createState() =>
      _VerifyRequestWorkerListDetailsState();
}

class _VerifyRequestWorkerListDetailsState
    extends State<VerifyRequestWorkerListDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
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
            width: _textSize("widget.data!.reportsTo").width,
            height: _textSize("widget.data!.reportsTo").height,
            child: Text("widget.data!.reportsTo",
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
            width: _textSize(widget.data.userId.userDetail!.name).width,
            height: _textSize(widget.data.userId.userDetail!.name).height,
            child: Text(widget.data.userId.userDetail!.name.toTitleCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    color: greyCustom,
                    fontWeight: FontWeight.w400)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: widget.index != widget.lastItem
                ? const Divider(
                    thickness: 0.5,
                  )
                : null,
          )
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
