import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';

class StatusContainer extends StatefulWidget {
  final String type;

  //Color boxColor;
  final String status;
  final dynamic statusId;

  //Color textColor;
  final FontWeight fontWeight;
  final bool? roundedCorner;

  const StatusContainer(
      {Key? key,
      required this.type,
      // required this.boxColor,
      required this.status,
      required this.statusId,
      // required this.textColor,
      required this.fontWeight,
      this.roundedCorner = false})
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
      if (widget.statusId == "EBC") {
        //Dalam Proses (PRA)
        //Baru (SV)
        // textColor = blueStatusText;
        // boxColor = blueStatusBox;
        textColor = orangeStatusText;
        boxColor = orangeStatusBox;
      } else if (widget.statusId == "EDTL") {
        //Diluluskan Tanpa Lampiran
        textColor = orangeStatusText;
        boxColor = orangeStatusBox;
      } else if (widget.statusId == "EDL") {
        //Diluluskan
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      } else if (widget.statusId == "ETLK") {
        //Tidak Diluluskan
        textColor = redStatusText;
        boxColor = redStatusBox;
      }
    } else if (widget.type == "Laporan") {
      if (widget.statusId == "RBR") {
        //Baru || Dalam Proses
        // textColor = blueStatusText;
        // boxColor = blueStatusBox;
        textColor = orangeStatusText;
        boxColor = orangeStatusBox;
      } else if (widget.statusId == "RTRS" || widget.statusId == "RSHB") {
        //Diterima SV || Disahkan BA
        // textColor = orangeStatusText;
        // boxColor = orangeStatusBox;
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      } else if (widget.statusId == "RTLS" || widget.statusId == "RTLB") {
        //Ditolak SV || Ditolak BA
        textColor = redStatusText;
        boxColor = redStatusBox;
      } else if (widget.statusId == 6) {
        //Selesai
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      }
    } else if (widget.type == "Laluan") {
      if (widget.statusId == "SBM") {
        //Belum Mula

        textColor = greyStatusText;
        boxColor = greyStatusBox;
      } else if (widget.statusId == "SBT") {
        //Sedang Bertugas

        textColor = blueStatusText;
        boxColor = blueStatusBox;
      } else if (widget.statusId == "STG") {
        //Tugasan Selesai

        textColor = greenStatusText;
        boxColor = greenStatusBox;
      } else if (widget.statusId == 3) {
        //Tunda
        textColor = redStatusText;
        boxColor = redStatusBox;
      }
    } else if (widget.type == "Akbk") {
      if (widget.statusId == 1) {
        //Baru
        textColor = orangeStatusText;
        boxColor = orangeStatusBox;
      } else if (widget.statusId == 2) {
        //Dalam Proses
        textColor = blueStatusText;
        boxColor = blueStatusBox;
      } else if (widget.statusId == 3) {
        //Selesai
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      }
    } else if (widget.type == "vc") {
      if (widget.statusId == "VC1" || widget.statusId == "VC2") {
        // Belum Disahkan
        textColor = orangeStatusText;
        boxColor = orangeStatusBox;
        /*} else if (widget.statusId == "VC2") {
        //Sedang bertugas
        textColor = blueStatusText;
        boxColor = blueStatusBox;*/
      } else if (widget.statusId == "VC3") {
        // Disahkan
        textColor = greenStatusText;
        boxColor = greenStatusBox;
      }
    } else if (widget.type == "workshopVehicle") {
      if (widget.statusId == 1 || widget.statusId == 2) {
        //Dalam Proses
        textColor = blueStatusText;
        boxColor = blueStatusBox;
      } else if (widget.statusId == 3) {
        //Selesai
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
    return Flexible(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          padding: widget.roundedCorner!
              ? const EdgeInsets.all(6)
              : const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: statusBoxColor,
            borderRadius: widget.roundedCorner!
                ? BorderRadius.circular(6)
                : const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
          ),
          child: AutoSizeText(
            widget.status,
            style: TextStyle(
              fontSize: 12,
              color: statusTextColor,
              fontWeight: widget.fontWeight,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
