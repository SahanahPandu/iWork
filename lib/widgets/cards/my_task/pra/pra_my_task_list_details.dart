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
  late Color statusTextColor;
  late Color statusBoxColor;

  filterData() {
    //default status belum dimulakan
    Color textColor = Colors.grey;
    Color boxColor = Colors.grey.shade100;

    if (widget.data.idStatus == 2) {
      //Sedang Bertugas

      textColor = Colors.blue.shade800;
      boxColor = Colors.blue.shade100;
    } else if (widget.data.idStatus == 3) {
      //Tugasan Selesai

      textColor = Colors.green;
      boxColor = const Color(0xffc9ffd7);
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
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            //Nama Laluan & Status
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data.namaLaluan,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w900),
              ),
              StatusContainer(
                boxColor: statusBoxColor,
                status: widget.data.status,
                textColor: statusTextColor,
                fontWeight: statusFontWeight,
              ),
            ],
          ),
        ),
        //No Kenderaan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                      fontSize: 13,
                      color: grey400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.noKenderaan,
                style: TextStyle(
                  fontSize: 15,
                  color: black87,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        //Sub Laluan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                      fontSize: 13,
                      color: grey400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumSubLaluan}",
                style: TextStyle(
                  fontSize: 13,
                  color: black87,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),

        //Jumlah Taman/Jalan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                    width: 8,
                  ),
                  Text(
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 13,
                      color: grey400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                style: TextStyle(
                  fontSize: 15,
                  color: black87,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
