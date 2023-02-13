import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../config/font.dart';
import '../../../models/schedule/schedule_details.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/container/status_container.dart';

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
                statusId: widget.data?.statusCode!.code != null
                    ? widget.data!.statusCode!.code
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
                  widget.data?.vehicleNo != null ? widget.data!.vehicleNo : "-",
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
                  "${widget.data?.totalSubRoute != null ? widget.data!.totalSubRoute : "-"}",
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
                  "${widget.data?.totalPark != null ? widget.data!.totalPark : "-"}/${widget.data?.totalStreet != null ? widget.data!.totalStreet : "-"}",
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
                      : "-",
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

          //Jadual Mula/Tamat
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.scheduleFill,
                      size: 16,
                      color: white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Jadual Mula/Tamat",
                      style: TextStyle(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data?.startScheduleAt == null &&
                          widget.data?.stopScheduleAt ==
                              null // no start & stop schedule time
                      ? "--:--"
                      : widget.data?.startScheduleAt != null &&
                              widget.data?.stopScheduleAt ==
                                  null // have start schedule time but no stop schedule time
                          ? "${widget.data!.startScheduleAt!} / --:--"
                          : widget.data?.startScheduleAt == null &&
                                  widget.data?.stopScheduleAt !=
                                      null // no start schedule time but have stop schedule time
                              ? "--:-- / ${widget.data?.stopScheduleAt}"
                              : "${widget.data?.startScheduleAt} / ${widget.data?.stopScheduleAt}", // have both start and stop schedule time
                  style: TextStyle(
                    fontSize: 15,
                    color: white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: heightGap,
          ),

          //Mula/Tamat Kerja
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      CustomIcon.timerFill,
                      size: 16,
                      color: white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Mula/Tamat Kerja",
                      style: TextStyle(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.data?.startWorkAt == null &&
                          widget.data?.stopWorkAt ==
                              null // no start & stop work time
                      ? "--:--"
                      : widget.data?.startWorkAt != null &&
                              widget.data?.stopWorkAt ==
                                  null // have start work time but no stop work time
                          ? "${widget.data!.startWorkAt!} / --:--"
                          : widget.data?.startWorkAt == null &&
                                  widget.data?.stopWorkAt !=
                                      null // no start work time but have stop work time
                              ? "--:-- / ${widget.data?.stopWorkAt}"
                              : "${widget.data?.startWorkAt} / ${widget.data?.stopWorkAt}", // have both start and stop work time
                  style: TextStyle(
                    fontSize: 15,
                    color: white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
