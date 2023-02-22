import 'package:eswm/utils/font/font.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../models/request_worker/list/request_worker.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/device/sizes.dart';

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
  Color acceptButtonColor = transparent;
  Color rejectButtonColor = transparent;
  bool acceptButtonSelected = false;
  bool rejectButtonSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 8),
          child: Row(
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
                                      ? loadingProgress.cumulativeBytesLoaded /
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
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Sizes().screenWidth(context) * 0.6,
                    child: Text(
                      widget.data!.reassignWithUserId.userDetail.name
                          .toTitleCase(),
                      style: textStyle,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        widget.data!.reassignWithUserId.userRoles![0].roleDesc,
                        style: TextStyle(
                            color: greyCustom,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 8),
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
                  SizedBox(
                    width: Sizes().screenWidth(context) * 0.61,
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: FlexColumnWidth(0.8),
                        1: FlexColumnWidth(1.2),
                      },
                      children: [
                        TableRow(
                          children: [
                            SizedBox(
                              height: 24,
                              child: Text("Tarikh",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: greyCustom,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)),
                            ),
                            SizedBox(
                              height: 24,
                              child: Text("Dipohon oleh",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: greyCustom,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)),
                            )
                          ],
                        ),
                        TableRow(
                          children: [
                            Text(
                                Date.getTheDate(
                                    widget.data!.scMainId.scheduleDate,
                                    "yyyy-MM-dd",
                                    "dd/MM/yyyy",
                                    "ms"),
                                style: textStyle,
                                textAlign: TextAlign.left),
                            Text(
                              widget.data!.scMainId.superviseBy.userDetail.name
                                  .toTitleCase(),
                              textAlign: TextAlign.left,
                              style: textStyle,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: transparent,
                          backgroundColor: acceptButtonColor,
                        ),
                        onPressed: () {
                          setState(() {
                            if (acceptButtonSelected) {
                              acceptButtonSelected = false;
                              acceptButtonColor = transparent;
                            } else {
                              acceptButtonSelected = true;
                              acceptButtonColor = const Color(
                                  0xFFE0EEFF); // const Color(0xFFE8FFE5);
                              rejectButtonSelected = false;
                              rejectButtonColor = transparent;
                              approvalRequestedWorker[widget.index!] = 1;
                              tickedRequestedWorker[widget.index!] =
                                  widget.data!.id;
                            }
                            if (!acceptButtonSelected &&
                                !rejectButtonSelected) {
                              approvalRequestedWorker[widget.index!] = -1;
                              tickedRequestedWorker[widget.index!] = -1;
                            }
                          });
                        },
                        child: Icon(
                          Icons.check_circle,
                          color: greenCustom,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: transparent,
                          backgroundColor: rejectButtonColor,
                        ),
                        onPressed: () {
                          setState(() {
                            if (rejectButtonSelected) {
                              rejectButtonSelected = false;
                              rejectButtonColor = transparent;
                            } else {
                              rejectButtonSelected = true;
                              rejectButtonColor = const Color(
                                  0xFFE0EEFF); // const Color(0xffffe0e0);
                              acceptButtonSelected = false;
                              acceptButtonColor = transparent;
                              approvalRequestedWorker[widget.index!] = 0;
                              tickedRequestedWorker[widget.index!] =
                                  widget.data!.id;
                            }
                            if (!acceptButtonSelected &&
                                !rejectButtonSelected) {
                              approvalRequestedWorker[widget.index!] = -1;
                              tickedRequestedWorker[widget.index!] = -1;
                            }
                          });
                        },
                        child: SizedBox(
                          height: 20,
                          child: CircleAvatar(
                            backgroundColor: redCustom,
                            child: Icon(
                              Icons.close_rounded,
                              color: white,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget.index != widget.lastIndex
              ? const Divider(
                  thickness: 0.5,
                )
              : null,
        ),
      ],
    );
  }

  final TextStyle textStyle = TextStyle(
    fontSize: 13,
    color: blackCustom,
    fontWeight: FontWeight.w500,
  );
}
