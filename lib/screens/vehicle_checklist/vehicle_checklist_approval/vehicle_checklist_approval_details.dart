import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/vc/confirmation/vc_verification_list.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/container/status_container.dart';

class VehicleChecklistApprovalDetails extends StatefulWidget {
  final ChecklistList data;

  const VehicleChecklistApprovalDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalDetails> createState() =>
      _VehicleChecklistApprovalDetailsState();
}

class _VehicleChecklistApprovalDetailsState
    extends State<VehicleChecklistApprovalDetails> {
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
                "15/02/2023",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: blackCustom,
                    fontSize: 16),
              ),
            ),
            StatusContainer(
              type: "vc",
              status: widget.data.vehicleChecklistId.statusCode.name,
              statusId: widget.data.vehicleChecklistId.statusCode.code,
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
              Text(widget.data.vehicleNo,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: blackCustom,
                      fontSize: 15)),
            ],
          ),
        ),
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
              Text(widget.data.mainRoute,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: blackCustom,
                      fontSize: 15)),
            ],
          ),
        )
      ],
    );
  }
}
