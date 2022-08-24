import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/reports.dart';
import '../../utils/custom_icon.dart';
import '../../widgets/container/status_container.dart';

class ReportListDetails extends StatefulWidget {
  final Reports data;
  final int index;

  const ReportListDetails({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<ReportListDetails> createState() => _ReportListDetailsState();
}

class _ReportListDetailsState extends State<ReportListDetails> {
  double horizontalPadding = 16;
  Color iconColor = const Color(0xff3269F8);
  Color labelColor = const Color(0xff969696);
  Color inputColor = const Color(0xff2B2B2B);
  double gapHeight = userRole == 200 ? 16 : 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 32),
      child: Column(
        children: [
          //laluan and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "L${widget.index + 1} - ${widget.data.namaLaluan}",
                  style: TextStyle(
                    fontSize: userRole == 200 ? 16 : 14,
                    color: userRole == 200 ? const Color(0xff2B2B2B) : black87,
                    fontWeight:
                        userRole == 200 ? FontWeight.w500 : FontWeight.w600,
                  ),
                ),
              ),
              StatusContainer(
                type: "Laporan",
                status: widget.data.status,
                statusId: widget.data.idStatus,
                fontWeight: statusFontWeight,
              ),
            ],
          ),
          SizedBox(
            height: userRole == 200 ? 32 : 20,
          ),
          //Tarikh & Masa
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          CustomIcon.timerFill,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Tarikh & Masa",
                          style: TextStyle(
                            fontSize:
                                userRole == 100 || userRole == 200 ? 15 : 13,
                            color: labelColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.data.tarikh},${widget.data.masa}",
                      style: TextStyle(
                        fontSize: userRole == 100 || userRole == 200 ? 15 : 13,
                        color: inputColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: gapHeight,
          ),
          //Taman
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ClipRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          CustomIcon.tamanFill,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Taman",
                          style: TextStyle(
                            fontSize:
                                userRole == 100 || userRole == 200 ? 15 : 13,
                            color: labelColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.end,
                      widget.data.namaTaman,
                      style: TextStyle(
                        fontSize: userRole == 100 || userRole == 200 ? 15 : 13,
                        color: inputColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: gapHeight,
          ),
          //Jalan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ClipRRect(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          CustomIcon.roadFill,
                          size: 16,
                          color: iconColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Jalan",
                          style: TextStyle(
                            fontSize:
                                userRole == 100 || userRole == 200 ? 15 : 13,
                            color: labelColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.end,
                      widget.data.namaJalan,
                      style: TextStyle(
                        fontSize: userRole == 100 || userRole == 200 ? 15 : 13,
                        color: inputColor,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: gapHeight,
          ),
          //Jenis Halangan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.exclamation,
                      size: 16,
                      color: iconColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Jenis Halangan",
                      style: TextStyle(
                        fontSize: userRole == 100 || userRole == 200 ? 15 : 13,
                        color: labelColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  textAlign: TextAlign.end,
                  widget.data.jenisHalangan,
                  style: TextStyle(
                    fontSize: userRole == 100 || userRole == 200 ? 15 : 13,
                    color: inputColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
