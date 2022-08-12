import 'package:eswm/models/vc/vc.dart';
import 'package:flutter/material.dart';

import '../../../config/font.dart';
import '../../../config/palette.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data.noLaluan,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: black87,
                    fontSize: 15),
              ),
              StatusContainer(
                type: "vc",
                status: widget.data.status,
                statusId: widget.data.statusId,
                fontWeight: statusFontWeight,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('No. Kenderaan',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: black87,
                      fontSize: 13)),
              Text(widget.data.noKenderaan,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: grey500,
                      fontSize: 13)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Masa Masuk/Keluar',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: black87,
                      fontSize: 13)),
              Text('${widget.data.masaKeluar} / ${widget.data.masaBalik}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: grey500,
                      fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}
