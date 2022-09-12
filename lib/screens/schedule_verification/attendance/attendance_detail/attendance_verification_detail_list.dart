import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/pekerja.dart';
import '../../../../utils/date.dart';

class AttendanceVerificationDetailList extends StatefulWidget {
  final Pekerja data;
  final int? index;

  const AttendanceVerificationDetailList(
      {Key? key, required this.data, this.index})
      : super(key: key);

  @override
  State<AttendanceVerificationDetailList> createState() =>
      _AttendanceVerificationDetailListState();
}

class _AttendanceVerificationDetailListState
    extends State<AttendanceVerificationDetailList> {
  bool val = true;
  String timeIn = "";
  Color timeInColor = greenCustom;

  @override
  void initState() {
    _isClockedIn();
    super.initState();
  }

  bool _isClockedIn() {
    if (widget.data.timeIn != "") {
      timeIn = widget.data.timeIn;
      timeInColor = greenCustom;
      return val = true;
    } else {
      timeIn = "Tiada Rekod";
      timeInColor = red;
      return val = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CheckboxListTile(
            checkboxShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                    clipBehavior: Clip.hardEdge,
                    alignment: AlignmentDirectional.center,
                    fit: StackFit.loose,
                    children: <Widget>[
                      Container(
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                            color: transparent,
                            border: Border.all(color: grey200),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            height: 55,
                            width: 55,
                            fit: BoxFit.fill,
                            widget.data.displayPicture,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: green,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ))
                    ]),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _textSize().width,
                      height: _textSize().height,
                      child: Text(
                        widget.data.name,
                        style: textStyle,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          widget.data.designCat,
                          style: TextStyle(
                              color: greyCustom,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.fiber_manual_record,
                          size: 5,
                          color: greyCustom,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.data.skills,
                          style: TextStyle(
                              color: greyCustom,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Masuk Kerja: ",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: greyCustom),
                            children: <TextSpan>[
                              TextSpan(
                                  text: timeIn,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: timeInColor)),
                            ]))
                  ],
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            activeColor: green,
            value: val,
            onChanged: (newValue) {
              setState(() {
                val = newValue!;
                _toggleTimeInData(val);
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget.index != 6
              ? const Divider(
                  thickness: 0.5,
                )
              : null,
        )
      ],
    );
  }

  final TextStyle textStyle = TextStyle(
    fontSize: 13,
    color: blackCustom,
    fontWeight: FontWeight.w500,
  );

  Size _textSize() {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.data.name, style: textStyle),
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 180);
    return textPainter.size;
  }

  void _toggleTimeInData(bool isTicked) {
    if (isTicked == true) {
      if (widget.data.timeIn == "") {
        if (Date.getCurrentTime().contains("AM")) {
          timeIn = "${Date.getCurrentTimeInHHMM()} pagi";
        } else {
          timeIn = "${Date.getCurrentTimeInHHMM()} petang";
        }
      } else {
        timeIn = widget.data.timeIn;
      }
      timeInColor = greenCustom;
    } else {
      timeIn = "Tiada Rekod";
      timeInColor = red;
    }
  }
}
