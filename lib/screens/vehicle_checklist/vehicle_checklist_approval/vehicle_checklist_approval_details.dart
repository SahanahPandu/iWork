import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/vc/detail/vc_main.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/container/status_container.dart';

class VehicleChecklistApprovalDetails extends StatefulWidget {
  final VehicleChecklistMain data;

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
                "widget.data.noLaluan",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: blackCustom,
                    fontSize: 16),
              ),
            ),
            StatusContainer(
              type: "vc",
              status: widget.data.data!.vehicleChecklists!.statusCode,
              statusId: widget.data.data!.vehicleChecklists!.statusCode,
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
              Text("widget.data.noKenderaan",
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
                    CustomIcon.timerFill,
                    size: 16,
                    color: activeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Keluar/Balik',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: greyCustom,
                          fontSize: 15)),
                ],
              ),
              Text('${"widget.data.masaKeluar"} / ${"widget.data.masaBalik"}',
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
