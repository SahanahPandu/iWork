import 'package:flutter/material.dart';

//import files
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //laluan and status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                "L${widget.index + 1} - ${widget.data.namaLaluan}",
                style: TextStyle(
                  fontSize: 16,
                  color: blackCustom,
                  fontWeight: FontWeight.w500,
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
        //Taman
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.timerFill,
                    size: 18,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Tarikh & Masa",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 160,
                child: Text(
                  widget.data.tarikhMasa,
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        //Taman
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.tamanFill,
                    size: 18,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Taman",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 160,
                child: Text(
                  widget.data.namaTaman,
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        //Jalan
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.roadFill,
                    size: 18,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.namaJalan,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        //Jenis Halangan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.exclamation,
                    size: 18,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jenis Halangan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.jenisHalangan,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
