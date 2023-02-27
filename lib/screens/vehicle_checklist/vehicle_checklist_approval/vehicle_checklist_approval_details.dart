import 'package:eswm/utils/calendar/date.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/container/status_container.dart';

class VehicleChecklistApprovalDetails extends StatefulWidget {
  /// from pengesahan tab ChecklistList
  /// from app drawer -> VCListDetail
  final dynamic data;
  final bool isDrawer;

  const VehicleChecklistApprovalDetails(
      {Key? key, required this.data, required this.isDrawer})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalDetails> createState() =>
      _VehicleChecklistApprovalDetailsState();
}

class _VehicleChecklistApprovalDetailsState
    extends State<VehicleChecklistApprovalDetails> {
  Color beforeVC = blackCustom;
  Color afterVC = blackCustom;
  String? statusName = "";
  String? statusCode = "";
  String? routeName = "";
  String? date = "";

  @override
  void initState() {
    if (widget.isDrawer) {
      if (widget.data.scheduleCollectionMain!.vehicleChecklistId == null) {
        beforeVC = blackCustom;
        afterVC = blackCustom;
      } else {
        if (widget.data.statusCode!.code == "VC1") {
          beforeVC = greenCustom;
          afterVC = blackCustom;
        } else if (widget.data.statusCode!.code == "VC2" ||
            widget.data.statusCode!.code == "VC3") {
          beforeVC = greenCustom;
          afterVC = greenCustom;
        }
      }
      statusName = widget.data.statusCode!.name;
      statusCode = widget.data.statusCode!.code;
      routeName = widget.data.scheduleCollectionMain!.mainRoute;
      date = Date.getTheDate(
          widget.data.createdAt, "yyyy-MM-dd", "dd/MM/yyyy", "ms");
    } else {
      // ignore: unnecessary_null_comparison
      if (widget.data.vehicleChecklistId == null) {
        beforeVC = blackCustom;
        afterVC = blackCustom;
      } else {
        if (widget.data.vehicleChecklistId.statusCode.code == "VC1") {
          beforeVC = greenCustom;
          afterVC = blackCustom;
        } else if (widget.data.vehicleChecklistId.statusCode.code == "VC2" ||
            widget.data.vehicleChecklistId.statusCode.code == "VC3") {
          beforeVC = greenCustom;
          afterVC = greenCustom;
        }
      }
      statusName = widget.data.vehicleChecklistId.statusCode.name;
      statusCode = widget.data.vehicleChecklistId.statusCode.code;
      routeName = widget.data.mainRoute;
      date = Date.getTheDate(DateTime.now(), '', "dd/MM/yyyy", 'ms');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                date!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: blackCustom,
                    fontSize: 16),
              ),
            ),
            StatusContainer(
              type: "vc",
              status: statusName!,
              statusId: statusCode,
              fontWeight: statusFontWeight,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.truckFill,
                    size: 16,
                    color: activeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('No. Kenderaan',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: greyCustom,
                          fontSize: 15)),
                ],
              ),
              Text(widget.data.vehicleNo!,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: blackCustom,
                      fontSize: 15)),
            ],
          ),
        ),
        //Nama laluan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.roadFill,
                    size: 16,
                    color: activeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Laluan',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: greyCustom,
                          fontSize: 15)),
                ],
              ),
              Text(routeName!,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: blackCustom,
                      fontSize: 15)),
            ],
          ),
        ),
        // Semakan kenderaan
        /* Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    CustomIcon.manualFill,
                    size: 16,
                    color: activeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Status Semakan',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: greyCustom,
                          fontSize: 15)),
                ],
              ),
              RichText(
                  text: TextSpan(
                      text: "Sebelum",
                      style: TextStyle(
                        fontSize: 16,
                        color: beforeVC,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: "/",
                        style: TextStyle(
                          fontSize: 16,
                          color: afterVC,
                          fontWeight: FontWeight.w600,
                        )),
                    TextSpan(
                        text: "Selepas",
                        style: TextStyle(
                          fontSize: 16,
                          color: afterVC,
                          fontWeight: FontWeight.w600,
                        )),
                  ])),
            ],
          ),
        )*/
      ],
    );
  }
}
