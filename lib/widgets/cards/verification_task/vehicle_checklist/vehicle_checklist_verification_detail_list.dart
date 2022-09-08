import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/vc/vc.dart';

class VehicleChecklistVerificationDetailList extends StatefulWidget {
  final VehicleChecklist data;
  final int index;

  const VehicleChecklistVerificationDetailList(
      {Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<VehicleChecklistVerificationDetailList> createState() =>
      _VehicleChecklistVerificationDetailListState();
}

class _VehicleChecklistVerificationDetailListState
    extends State<VehicleChecklistVerificationDetailList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      decoration: BoxDecoration(
        border: widget.index != 2
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
          Text(widget.data.noKenderaan,
              style: TextStyle(
                  color: blackCustom,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
          Center(
            child: Text('Sebelum/Selepas',
                style: TextStyle(
                    color: greenCustom,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
