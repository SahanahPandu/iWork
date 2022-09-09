import 'package:flutter/material.dart';

//import files
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/workshop_vehicle.dart';
import '../../widgets/container/status_container.dart';

class WorkshopVehicleDetails extends StatefulWidget {
  final WorkshopVehicle data;

  const WorkshopVehicleDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<WorkshopVehicleDetails> createState() => _WorkshopVehicleDetailsState();
}

class _WorkshopVehicleDetailsState extends State<WorkshopVehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              '${widget.data.vehicleNo} - ${widget.data.akbkNo}',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor,
                  fontSize: 16),
            ),
          ),
          StatusContainer(
            type: "workshopVehicle",
            status: widget.data.status,
            statusId: widget.data.statusId,
            fontWeight: statusFontWeight,
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('No. AKBK',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: primaryTextColor,
                    fontSize: 14)),
            Text(widget.data.akbkNo,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: secondaryTextColor,
                    fontSize: 14))
          ],
        ),
      ),
    ]);
  }
}
