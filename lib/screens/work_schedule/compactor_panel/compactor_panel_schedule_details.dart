import 'package:flutter/material.dart';

import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/laluan.dart';
import '../../../utils/custom_icon.dart';
import '../../../utils/device.dart';
import '../../../widgets/buttons/report_button.dart';
import '../../../widgets/container/status_container.dart';

class CompactorPanelScheduleDetails extends StatefulWidget {
  final Laluan data;

  const CompactorPanelScheduleDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<CompactorPanelScheduleDetails> createState() =>
      _CompactorPanelScheduleDetailsState();
}

class _CompactorPanelScheduleDetailsState
    extends State<CompactorPanelScheduleDetails> {
  final Devices _device = Devices();
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
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      color: grey800,
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
                      size: 18,
                      color: blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "No. Kenderaan",
                      style: TextStyle(
                        fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                        color: grey800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data.noKenderaan,
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
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
                      "Sub Laluan",
                      style: TextStyle(
                        fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                        color: grey800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.jumSubLaluan}",
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
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
                      width: 10,
                    ),
                    Text(
                      "Jumlah Taman/Jalan",
                      style: TextStyle(
                        fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                        color: grey800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          //Mula Kerja/ Tamat Kerja
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
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
                      "Mula Kerja/Tamat Kerja",
                      style: TextStyle(
                        fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                        color: grey800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  '--:-- / --:--',
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15.0 : 13.0,
                    color: black45,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Center(
          child: ReportButton(
            dataLaluan: widget.data,
          ),
        ),
      ),
    ]);
  }
}
