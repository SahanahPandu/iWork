import 'package:flutter/material.dart';

//import files
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

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            //Nama Laluan & Status
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  widget.data.namaLaluan,
                  style: TextStyle(
                      fontSize: 20,
                      color: blackCustom,
                      fontWeight: FontWeight.w800),
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                      width: 12,
                    ),
                    Text(
                      "No. Kenderaan",
                      style: TextStyle(
                        fontSize: _device.isLandscape(context) ? 15 : 14,
                        color: greyCustom,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data.noKenderaan,
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15 : 14,
                    color: blackCustom,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          //Sub Laluan
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                        fontSize: _device.isLandscape(context) ? 15 : 14,
                        color: greyCustom,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.jumSubLaluan}",
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15 : 14,
                    color: blackCustom,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          //Jumlah Taman/Jalan
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                        fontSize: _device.isLandscape(context) ? 15 : 14,
                        color: greyCustom,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15 : 14,
                    color: blackCustom,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          //Mula Kerja/ Tamat Kerja
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
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
                        fontSize: _device.isLandscape(context) ? 15 : 14,
                        color: greyCustom,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  '--:-- / --:--',
                  style: TextStyle(
                    fontSize: _device.isLandscape(context) ? 15 : 14,
                    color: blackCustom,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: ReportButton(
            dataLaluan: widget.data,
          ),
        ),
      ),
    ]);
  }
}
