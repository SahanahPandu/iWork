import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../config/font.dart';
import '../../../../models/laluan.dart';
import '../../../utils/custom_icon.dart';
import '../../../widgets/buttons/report_button.dart';
import '../../../widgets/container/status_container.dart';

class PraWorkScheduleDetails extends StatefulWidget {
  final Laluan data;

  const PraWorkScheduleDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<PraWorkScheduleDetails> createState() => _PraWorkScheduleDetailsState();
}

class _PraWorkScheduleDetailsState extends State<PraWorkScheduleDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          //Nama Laluan & Status
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.data.namaLaluan,
                style: TextStyle(
                  fontSize: 16,
                  color: blackCustom,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            StatusContainer(
              type: "Laluan",
              status: widget.data.status,
              statusId: widget.data.idStatus,
              fontWeight: statusFontWeight,
            ),
          ],
        ),

        //No. Kenderaan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.truckFill,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.noKenderaan,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Sub Laluan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.roadFill,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Sub Laluan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumSubLaluan}",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Jumlah Taman dan Jalan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.tamanFill,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        //Jenis Kutipan
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.grass,
                    size: 16,
                    color: blue,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jenis Kutipan",
                    style: TextStyle(
                      fontSize: 15,
                      color: greyCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.jenisKutipan,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
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
