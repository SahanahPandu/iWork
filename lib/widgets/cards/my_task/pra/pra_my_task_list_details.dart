// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/laluan.dart';
import '../../../../utils/custom_icon.dart';
import '../../../container/status_container.dart';

class PraMyTaskListDetails extends StatefulWidget {
  Laluan data;

  PraMyTaskListDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<PraMyTaskListDetails> createState() => _PraMyTaskListDetailsState();
}

class _PraMyTaskListDetailsState extends State<PraMyTaskListDetails> {
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
              padding: const EdgeInsets.all(15),
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
        //No Kenderaan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
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

        //Jumlah Taman/Jalan
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
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
      ],
    );
  }
}
