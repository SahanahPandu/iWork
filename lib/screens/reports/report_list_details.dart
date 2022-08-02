// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/reports.dart';
import '../../widgets/container/status_container.dart';

class ReportListDetails extends StatefulWidget {
  Reports data;
  int index;

  ReportListDetails({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<ReportListDetails> createState() => _ReportListDetailsState();
}

class _ReportListDetailsState extends State<ReportListDetails> {
  Color statusTextColor = greyStatusText;
  Color statusBoxColor = greyStatusBox;

  filterData() {
    Color textColor = greyStatusText;
    Color boxColor = greyStatusBox;

    if (widget.data.idStatus == 1) {
      //Baharu
      textColor = blueStatusText;
      boxColor = blueStatusBox;
    } else if (widget.data.idStatus == 2) {
      //Dalam Proses
      textColor = orangeStatusText;
      boxColor = orangeStatusBox;
    } else if (widget.data.idStatus == 3) {
      //Selesai
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
    // ignore: todo
    // TODO: implement initState
    super.initState();
    filterData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          //laluan and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Laporan ${widget.index + 1} - ${widget.data.namaLaluan}",
                style: TextStyle(
                  fontSize: userRole == 200? 17 : 15,
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
          const SizedBox(
            height: 30,
          ),
          //Taman
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.house,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Taman",
                    style: TextStyle(
                      fontSize: userRole == 200? 15 : 13,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.namaTaman,
                style: TextStyle(
                  fontSize: userRole == 200? 15 : 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //Jalan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.assistant_direction,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Jalan",
                    style: TextStyle(
                      fontSize: userRole == 200? 15 : 13,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.namaJalan,
                style: TextStyle(
                  fontSize: userRole == 200? 15 : 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          //Jenis Halangan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Jenis Halangan",
                    style: TextStyle(
                      fontSize: userRole == 200? 15 : 13,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                widget.data.jenisHalangan,
                style: TextStyle(
                  fontSize: userRole == 200? 15 : 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
