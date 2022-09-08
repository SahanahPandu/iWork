import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../config/font.dart';
import '../../../../models/laluan.dart';
import '../../../utils/custom_icon.dart';
import '../../../widgets/container/status_container.dart';

class PraWorkScheduleDetails extends StatefulWidget {
  final Laluan data;

  const PraWorkScheduleDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<PraWorkScheduleDetails> createState() => _PraWorkScheduleDetailsState();
}

class _PraWorkScheduleDetailsState extends State<PraWorkScheduleDetails> {
  double horizontalPadding = 16;
  double heightGap = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //Nama Laluan & Status
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

          const SizedBox(
            height: 24,
          ),

          //No. Kenderaan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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

          SizedBox(
            height: heightGap,
          ),

          //Sub Laluan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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

          SizedBox(
            height: heightGap,
          ),

          //Jumlah Taman dan Jalan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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

          SizedBox(
            height: heightGap,
          ),

          //Jenis Kutipan
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.recycle,
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
        ],
      ),
    );
  }
}
