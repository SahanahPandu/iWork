import 'package:eswm/utils/font/font.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../models/request_worker/list/request_worker.dart';
import '../../../../utils/calendar/date.dart';

class RequestWorkerDetailList extends StatefulWidget {
  final WorkerRequest? data;
  final int? index;
  final int? lastIndex;

  const RequestWorkerDetailList(
      {Key? key, this.data, this.index, this.lastIndex})
      : super(key: key);

  @override
  State<RequestWorkerDetailList> createState() =>
      _RequestWorkerDetailListState();
}

class _RequestWorkerDetailListState extends State<RequestWorkerDetailList> {
  bool val = true;

  @override
  void initState() {
    if (val == true) {
      tickedRequestedWorker.add(widget.data!.id);
    }
    super.initState();
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
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                            color: transparent,
                            border: Border.all(color: grey200),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                      ),
                      ClipRRect(
                          borderRadius:
                              BorderRadius.circular(borderRadiusCircular),
                          child: Image.network(
                            widget.data!.reassignWithUserId.userDetail
                                        .profilePic ==
                                    "http://ems.swmsb.com/uploads/profile/blue.png"
                                ? "https://st3.depositphotos.com/9998432/13335/v/600/depositphotos_133352062-stock-illustration-default-placeholder-profile-icon.jpg"
                                : widget.data!.reassignWithUserId.userDetail
                                    .profilePic,
                            height: 56,
                            width: 56,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: greenCustom,
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
                      width: _textSize(
                              widget.data!.reassignWithUserId.userDetail.name)
                          .width,
                      height: _textSize(
                              widget.data!.reassignWithUserId.userDetail.name)
                          .height,
                      child: Text(
                        widget.data!.reassignWithUserId.userDetail.name
                            .toTitleCase(),
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
                          widget
                              .data!.reassignWithUserId.userRoles![0].roleDesc,
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
                          "Kutipan",
                          style: TextStyle(
                              color: greyCustom,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text("Diphohon Oleh",
                        style: TextStyle(
                            color: greyCustom,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: _textSize(
                              widget.data!.scMainId.superviseBy.userDetail.name)
                          .width,
                      height: _textSize(
                              widget.data!.scMainId.superviseBy.userDetail.name)
                          .height,
                      child: Text(
                        widget.data!.scMainId.superviseBy.userDetail.name
                            .toTitleCase(),
                        style: textStyle,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Tarikh",
                        style: TextStyle(
                            color: greyCustom,
                            fontSize: 13,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 8),
                    Text(
                        Date.getTheDate(widget.data!.scMainId.scheduleDate,
                            "yyyy-MM-dd", "dd/MM/yyyy", "ms"),
                        style: textStyle)
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
          child: widget.index != widget.lastIndex
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

  Size _textSize(String name) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: name, style: textStyle),
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: 200);
    return textPainter.size;
  }

  void _toggleTimeInData(bool isTicked) {
    if (isTicked == true) {
      tickedRequestedWorker.add(widget.data!.id);
    } else {
      tickedRequestedWorker
          .remove(widget.data!.id);
    }
    //print(tickedRequestedWorker);
  }
}
