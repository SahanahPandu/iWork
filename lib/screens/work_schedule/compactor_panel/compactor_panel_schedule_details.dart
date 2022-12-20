import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/task/compactor/data/schedules/schedule.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/container/status_container.dart';

class CompactorPanelScheduleDetails extends StatefulWidget {
  final Schedule? data;

  const CompactorPanelScheduleDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<CompactorPanelScheduleDetails> createState() =>
      _CompactorPanelScheduleDetailsState();
}

class _CompactorPanelScheduleDetailsState
    extends State<CompactorPanelScheduleDetails> {
  Color expandBgColor = const Color(0xea4a39be);
  Color portraitExpandBgColor = const Color(0xea3e62be);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
          //Nama Laluan & Status
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(widget.data!.mainRoute,
                    style: TextStyle(
                      fontSize: 18,
                      color: white,
                      fontWeight: FontWeight.w700,
                    ))),
            StatusContainer(
              type: "Laluan",
              status: widget.data!.statusCode.name,
              statusId: widget.data!.statusCode,
              fontWeight: statusFontWeight,
              roundedCorner: true,
            )
          ]),

      //No. Kenderaan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.truckFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("No. Kenderaan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text(widget.data!.vehicleNo,
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Jumlah Sub Laluan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.roadFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Jumlah Sub Laluan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text("${widget.data!.totalSubRoute}",
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Jumlah Taman dan Jalan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.tamanFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Jumlah Taman/Jalan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text(
              "${widget.data!.totalPark}/${widget.data!.totalStreet}",
              style: TextStyle(
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.w600,
              ),
            )
          ])),
      //Jenis Kutipan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.recycle,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Jenis Kutipan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text(
              widget.data!.activityCode.activityName,
              style: TextStyle(
                fontSize: 16,
                color: white,
                fontWeight: FontWeight.w600,
              ),
            )
          ])),

      //Masuk Kerja/Keluar Kerja
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(CustomIcon.scheduleFill, size: 16, color: white),
              const SizedBox(
                width: 15,
              ),
              Text("Masuk/Keluar Kerja",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text("${widget.data!.startWorkAt} / ${widget.data!.stopWorkAt}",
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Semakan Kenderaan
      Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(
                CustomIcon.manualFill,
                size: 16,
                color: white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text("Semakan Kenderaan",
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                    fontWeight: FontWeight.w400,
                  ))
            ]),
            Text("Sebelum/Selepas",
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ))
          ])),
      //Senarai Staf
      Align(
          alignment: Alignment.centerRight,
          child: Container(
              alignment: Alignment.centerLeft,
              width: 165,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                  child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
                      children: [
                        Positioned(
                            left: 90,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Orientations().isTabletPortrait(context)
                                            ? portraitExpandBgColor
                                            : expandBgColor,
                                    radius: 28,
                                    child: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://i0.wp.com/i-panic.com/wp-content/uploads/2021/09/portrait-square-05.jpg?resize=400%2C400&ssl=1'),
                                      radius: 25.5,
                                    )))),
                        Positioned(
                            left: 45,
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Orientations().isTabletPortrait(context)
                                            ? portraitExpandBgColor
                                            : expandBgColor,
                                    radius: 28,
                                    child: const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://focusforensics.com/wp-content/uploads/staff-clayton_mccall-square.jpg'),
                                      radius: 25.5,
                                    )))),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: CircleAvatar(
                                backgroundColor:
                                    Orientations().isTabletPortrait(context)
                                        ? portraitExpandBgColor
                                        : expandBgColor,
                                radius: 28,
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://automateonline.com.au/wp-content/uploads/2019/02/portrait-square-04.jpg'),
                                  radius: 25.5,
                                )))
                      ])))),
    ]);
  }
}
