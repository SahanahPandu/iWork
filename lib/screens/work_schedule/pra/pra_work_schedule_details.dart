import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../config/font.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/container/status_container.dart';
import '../../../models/schedule/schedule_details.dart';

class PraWorkScheduleDetails extends StatefulWidget {
  final ScheduleDetails? data;

  const PraWorkScheduleDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<PraWorkScheduleDetails> createState() => _PraWorkScheduleDetailsState();
}

class _PraWorkScheduleDetailsState extends State<PraWorkScheduleDetails> {
  double horizontalPadding = 10;
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.data?.mainRoute != null
                      ? widget.data!.mainRoute
                      : "Sub Laluan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              StatusContainer(
                type: "Laluan",
                status: widget.data?.statusCode?.name != null
                    ? widget.data!.statusCode!.name
                    : "Sedang Bertugas",
                statusId: widget.data?.statusCode != null
                    ? widget.data!.statusCode
                    : "SBT",
                fontWeight: statusFontWeight,
                roundedCorner: true,
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
                      color: white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "No. Kenderaan",
                      style: TextStyle(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data?.vehicleNo != null
                      ? widget.data!.vehicleNo
                      : "Vehicle",
                  style: TextStyle(
                    fontSize: 15,
                    color: white,
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
                      color: white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Jumlah Sub Laluan",
                      style: TextStyle(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data?.totalSubRoute != null ? widget.data!.totalSubRoute : "Total Sub Route"}",
                  style: TextStyle(
                    fontSize: 15,
                    color: white,
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
                      color: white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Jumlah Taman/Jalan",
                      style: TextStyle(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.data?.totalPark != null ? widget.data!.totalPark : "Total Park"}/${widget.data?.totalStreet != null ? widget.data!.totalStreet : "Total Street"}",
                  style: TextStyle(
                    fontSize: 15,
                    color: white,
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
                      color: white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Jenis Kutipan",
                      style: TextStyle(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data?.activityCode?.activityName != null
                      ? widget.data!.activityCode!.activityName
                      : "activity",
                  style: TextStyle(
                    fontSize: 15,
                    color: white,
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
