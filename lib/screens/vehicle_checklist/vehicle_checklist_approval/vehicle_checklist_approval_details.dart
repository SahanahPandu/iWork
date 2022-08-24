import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/vc/vc.dart';
import '../../../utils/custom_icon.dart';
import '../../../utils/device.dart';
import '../../../widgets/container/status_container.dart';
import '../../../widgets/tabs/vehicle_checklist_tab/vehicle_checklist_approval_tab/vehicle_checklist_approval_tab.dart';

class VehicleChecklistApprovalDetails extends StatefulWidget {
  final VehicleChecklist data;

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
                widget.data.noLaluan,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: blackCustom,
                    fontSize: 16),
              ),
            ),
            StatusContainer(
              type: "vc",
              status: widget.data.status,
              statusId: widget.data.statusId,
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
                    size: 15,
                    color: activeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('No. Kenderaan',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: greyCustom,
                          fontSize: 14)),
                ],
              ),
              Text(widget.data.noKenderaan,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: blackCustom,
                      fontSize: 14)),
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
                    CustomIcon.timerOutline,
                    size: 15,
                    color: activeColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Keluar/Balik',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: greyCustom,
                          fontSize: 14)),
                ],
              ),
              Text('${widget.data.masaKeluar} / ${widget.data.masaBalik}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: blackCustom,
                      fontSize: 14)),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 18, left: 16, right: 16),
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  overlayColor:
                      MaterialStateColor.resolveWith((states) => green800),
                  minimumSize: MaterialStateProperty.all(
                      Size(Devices().screenWidth(context), 41)),
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text('Sahkan Semakan Kenderaan',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w700)),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: VehicleChecklistApprovalTab(
                          data: widget.data,
                        )));
              },
            ))
      ],
    );
  }
}
