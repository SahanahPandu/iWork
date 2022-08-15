import 'package:eswm/models/vc/vc.dart';
import 'package:flutter/material.dart';

import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../config/string.dart';
import '../../../utils/custom_icon.dart';
import '../../../utils/device.dart';
import '../../../widgets/alert/alert_dialog.dart';
import '../../../widgets/container/status_container.dart';

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
            Text(
              widget.data.noLaluan,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor,
                  fontSize: 16),
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
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    CustomIcon.truckFill,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('No. Kenderaan',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor,
                          fontSize: 14)),
                ],
              ),
              Text(widget.data.noKenderaan,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: secondaryTextColor,
                      fontSize: 14)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    CustomIcon.timerOutline,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Keluar/Balik',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor,
                          fontSize: 14)),
                ],
              ),
              Text('${widget.data.masaKeluar} / ${widget.data.masaBalik}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: secondaryTextColor,
                      fontSize: 14)),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 18, left: 10, right: 10),
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(
                          context,
                          confirmation,
                          "Sahkan borang Semakan Kenderaan ini?",
                          cancel,
                          "Sahkan");
                    }).then((actionText) {
                  if (actionText == "Sahkan") {
                    Navigator.pop(context);
                  }
                });
              },
            ))
      ],
    );
  }
}
