import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/task/supervisor/supervisor_task.dart';

class VehicleChecklistVerificationDetailList extends StatefulWidget {
  final int index;
  final int lastItem;
  final Checklist? vcData;

  const VehicleChecklistVerificationDetailList(
      {Key? key, required this.index, this.vcData, required this.lastItem})
      : super(key: key);

  @override
  State<VehicleChecklistVerificationDetailList> createState() =>
      _VehicleChecklistVerificationDetailListState();
}

class _VehicleChecklistVerificationDetailListState
    extends State<VehicleChecklistVerificationDetailList> {
  Color beforeText = greyCustom;
  Color afterText = greyCustom;

  @override
  void initState() {
    if (widget.vcData!.vehicleChecklistId.statusCode == null) {
      beforeText = greyCustom;
      afterText = greyCustom;
    } else if (widget.vcData!.vehicleChecklistId.statusCode!.code == "VC1") {
      beforeText = greenCustom;
      afterText = greyCustom;
    } else if (widget.vcData!.vehicleChecklistId.statusCode!.code == "VC2" ||
        widget.vcData!.vehicleChecklistId.statusCode!.code == "VC3") {
      beforeText = greenCustom;
      afterText = greenCustom;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      decoration: BoxDecoration(
        /// Check for last index on card listing
        border: widget.index < 3 &&
                widget.index != 2 &&
                widget.index != widget.index
            ? Border(
                top: BorderSide.none,
                bottom: BorderSide(
                  color: greyCustom,
                  width: 0.1,
                  style: BorderStyle.solid,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.vcData!.vehicleNo,
              style: TextStyle(
                  color: blackCustom,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sebelum",
                  style: TextStyle(
                      color: beforeText,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              Text("/",
                  style: TextStyle(
                      color: afterText,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              Text("Selepas",
                  style: TextStyle(
                      color: afterText,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
