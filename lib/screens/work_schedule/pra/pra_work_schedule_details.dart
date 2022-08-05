// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../config/font.dart';
import '../../../../models/laluan.dart';
import 'package:eswm/widgets/buttons/report_button.dart';
import 'package:eswm/widgets/container/status_container.dart';

import '../../../utils/custom_icon.dart';

class PraWorkScheduleDetails extends StatefulWidget {
  Laluan data;

  PraWorkScheduleDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<PraWorkScheduleDetails> createState() => _PraWorkScheduleDetailsState();
}

class _PraWorkScheduleDetailsState extends State<PraWorkScheduleDetails> {
  Color statusTextColor = greyStatusText;
  Color statusBoxColor = greyStatusBox;

  filterData() {
    Color textColor = greyStatusText;
    Color boxColor = greyStatusBox;

    if (widget.data.idStatus == 2) {
      //Sedang Bertugas

      textColor = blueStatusText;
      boxColor = blueStatusBox;
    } else if (widget.data.idStatus == 3) {
      //Tugasan Selesai

      textColor = greenStatusText;
      boxColor = greenStatusBox;
    }

    setState(() {
      statusTextColor = textColor;
      statusBoxColor = boxColor;
    });
  }

  @override
  void initState() {
    super.initState();
    filterData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          //Nama Laluan & Status
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.data.namaLaluan,
              style: TextStyle(
                fontSize: 19,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w900,
              ),
            ),
            StatusContainer(
              boxColor: statusBoxColor,
              status: widget.data.status,
              textColor: statusTextColor,
              fontWeight: statusFontWeight,
            ),
          ],
        ),

        //No. Kenderaan
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.truckFill,
                    size: 18,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.noKenderaan,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        //Sub Laluan
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
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
                    "Jumlah Sub Laluan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumSubLaluan}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),

        //Jumlah Taman dan Jalan
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
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
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        //Jenis Kutipan
        Padding(
          padding: const EdgeInsets.only(bottom: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.grass,
                    size: 18,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jenis Kutipan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.jenisKutipan,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Center(
          child: ReportButton(dataLaluan: widget.data),
        ),
      ],
    );
  }
}
