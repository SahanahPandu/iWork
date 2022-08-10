import 'package:flutter/material.dart';

import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/cuti.dart';
import '../../../widgets/container/status_container.dart';

class SupervisorLeaveListDetails extends StatefulWidget {
  final Cuti data;

  const SupervisorLeaveListDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<SupervisorLeaveListDetails> createState() =>
      _SupervisorLeaveListDetailsState();
}

class _SupervisorLeaveListDetailsState
    extends State<SupervisorLeaveListDetails> {
  // Color statusTextColor = greyStatusText;
  // Color statusBoxColor = greyStatusBox;
  String statusText = "";

  _filterData() {
    // Color textColor = greyStatusText;
    // Color boxColor = greyStatusBox;

    if (widget.data.idStatus == 1) {
      //Baharu
      statusText = "Baharu";
      // textColor = blueStatusText;
      // boxColor = blueStatusBox;
    } else if (widget.data.idStatus == 2) {
      //Diluluskan Tanpa Lampiran
      statusText = "Diluluskan Tanpa Lampiran";
      // textColor = orangeStatusText;
      // boxColor = orangeStatusBox;
    } else if (widget.data.idStatus == 3) {
      //Diluluskan
      statusText = "Diluluskan";
      // textColor = greenStatusText;
      // boxColor = greenStatusBox;
    } else if (widget.data.idStatus == 4) {
      //Tidak Diluluskan
      statusText = "Tidak Diluluskan";
      // textColor = redStatusText;
      // boxColor = redStatusBox;
    }

    // setState(() {
    //   statusTextColor = textColor;
    //   statusBoxColor = boxColor;
    // });
  }

  @override
  void initState() {
    _filterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          //Jenis dan Status Cuti
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data.pemohon,
                style: TextStyle(
                  fontSize: 16,
                  color: grey800,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              StatusContainer(
                type: "Cuti",
                status: statusText,
                statusId: widget.data.idStatus,
                fontWeight: statusFontWeight,
              ),
            ],
          ),

          //Penyelia
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Penyelia",
                  style: TextStyle(
                    fontSize: 13,
                    color: black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.data.approvalBy,
                  style: TextStyle(
                    fontSize: 13,
                    color: grey500,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          //Jenis Cuti
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jenis Cuti",
                  style: TextStyle(
                    fontSize: 13,
                    color: black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.data.jenisCuti,
                  style: TextStyle(
                    fontSize: 13,
                    color: grey500,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          //Tarikh Mula/Tamat
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tarikh Mula / Tamat",
                  style: TextStyle(
                    fontSize: 13,
                    color: black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  (widget.data.tarikhMula != widget.data.tarikhTamat)
                      ? "${widget.data.tarikhMula} - ${widget.data.tarikhTamat}"
                      : widget.data.tarikhMula,
                  style: TextStyle(
                    fontSize: 13,
                    color: grey500,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
