// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/palette.dart';
import '../../config/config.dart';

class StatusContainer extends StatefulWidget {
  String type;
  //Color boxColor;
  String status;
  int statusId;
  //Color textColor;
  FontWeight fontWeight;

  StatusContainer(
      {Key? key,
      required this.type,
      // required this.boxColor,
      required this.status,
      required this.statusId,
      // required this.textColor,
      required this.fontWeight})
      : super(key: key);

  @override
  State<StatusContainer> createState() => _StatusContainerState();
}

class _StatusContainerState extends State<StatusContainer> {
  Color statusTextColor = greyStatusText;
  Color statusBoxColor = greyStatusBox;

  filteredColor() {
    Color textColor = greyStatusText;
    Color boxColor = greyStatusBox;

    if (widget.type == "Kehadiran") {
      if (widget.statusId == 1) {
        //Hadir
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      } else if (widget.statusId == 2) {
        //Tidak Hadir
        textColor = redStatusText;
        boxColor = redStatusBox;
      }
    } else if (widget.type == "Cuti") {
      if (widget.statusId == 1) {
        //Dalam Proses
        textColor = blueStatusText;
        boxColor = blueStatusBox;
      } else if (widget.statusId == 2) {
        //Diluluskan Tanpa Lampiran
        textColor = orangeStatusText;
        boxColor = orangeStatusBox;
      } else if (widget.statusId == 3) {
        //Diluluskan
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      } else if (widget.statusId == 4) {
        //Tidak Diluluskan
        textColor = redStatusText;
        boxColor = redStatusBox;
      }
    } else if (widget.type == "Laporan") {
      if (widget.statusId == 1) {
        //Baharu
        textColor = blueStatusText;
        boxColor = blueStatusBox;
      } else if (widget.statusId == 2) {
        //Dalam Proses
        textColor = orangeStatusText;
        boxColor = orangeStatusBox;
      } else if (widget.statusId == 3) {
        //Selesai
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      }
    } else if (widget.type == "Laluan") {
      if (widget.statusId == 2) {
        //Sedang Bertugas

        textColor = blueStatusText;
        boxColor = blueStatusBox;
      } else if (widget.statusId == 3) {
        //Tugasan Selesai

        textColor = greenStatusText;
        boxColor = greenStatusBox;
      }
    }

    setState(() {
      statusTextColor = textColor;
      statusBoxColor = boxColor;
    });
  }

  @override
  void initState() {
    super.initState();
    filteredColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: statusBoxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.status,
        style: TextStyle(
          fontSize: userRole == 200 ? null : 12,
          color: statusTextColor,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
