import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../models/ecuti/ecuti_details.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/device/sizes.dart';

class SupervisorLeaveListDetails extends StatefulWidget {
  final EcutiDetails data;

  const SupervisorLeaveListDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<SupervisorLeaveListDetails> createState() =>
      _SupervisorLeaveListDetailsState();
}

class _SupervisorLeaveListDetailsState
    extends State<SupervisorLeaveListDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Nama
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: _textSize(widget.data.userId!.userDetail!.name).width,
                height: _textSize(widget.data.userId!.userDetail!.name).height,
                child: Text(
                  widget.data.userId!.userDetail!.name,
                  style: textStyle,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 10),
              /*StatusContainer(
                type: "Cuti",
                status: widget.data.status!.name,
                statusId: widget.data.status!.code,
                fontWeight: statusFontWeight,
              ),*/
            ],
          ),
        ),

        //Jenis Cuti
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jenis Cuti",
                style: TextStyle(
                  fontSize: 15,
                  color: greyCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.data.leaveType!.name,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Tarikh Mula/Tamat
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tarikh Mula/Tamat",
                style: TextStyle(
                  fontSize: 15,
                  color: greyCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                (widget.data.dateFrom != widget.data.dateTo)
                    ? "${Date.getTheDate(widget.data.dateFrom, 'yyyy-MM-dd', "dd/MM/yyyy", null)} - ${Date.getTheDate(widget.data.dateTo, 'yyyy-MM-dd', "dd/MM/yyyy", null)}"
                    : Date.getTheDate(
                        widget.data.dateFrom, 'yyyy-MM-dd', "dd/MM/yyyy", null),
                style: TextStyle(
                  fontSize: 14,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  final TextStyle textStyle =
      TextStyle(fontSize: 16, color: blackCustom, fontWeight: FontWeight.w400);

  Size _textSize(String data) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: data, style: textStyle),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: Sizes().screenWidth(context) * 0.76);
    return textPainter.size;
  }
}
