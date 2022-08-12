import 'package:flutter/material.dart';

import '../../../../config/config.dart';
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/vc/vc.dart';
import '../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';
import '../../../../utils/device.dart';

class VehicleChecklistCardDetails extends StatefulWidget {
  final VehicleChecklist data;

  const VehicleChecklistCardDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistCardDetails> createState() =>
      _VehicleChecklistCardDetailsState();
}

class _VehicleChecklistCardDetailsState
    extends State<VehicleChecklistCardDetails> {
  final Devices _device = Devices();

  Color alterColorBefore = Colors.grey;
  Color alterColorAfter = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    vc,
                    style: TextStyle(
                        fontSize: 19,
                        color: grey800,
                        fontWeight: FontWeight.w900),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 18,
                    color: alterColorBefore,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Sebelum Bertugas",
                    style: TextStyle(
                      fontSize: 15,
                      color: alterColorBefore,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 18,
                    color: alterColorAfter,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Selepas Bertugas",
                    style: TextStyle(
                      fontSize: 15,
                      color: alterColorAfter,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: tabletTaskCardMargin(context),
          height: 45.0,
          width: 350,
          child: ElevatedButton(
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: green)),
                ),
                minimumSize: MaterialStateProperty.all(
                    Size(_device.screenWidth(context), 45)),
                backgroundColor: MaterialStateProperty.all(white)),
            child: Text(vc,
                style: TextStyle(fontSize: 15, color: green)),
          ),
        ),
      ],
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    bool refresh = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VehicleChecklistDetail(data: widget.data)));
    if (!mounted) return;
    if (refresh == true) {
      _changeStatus();
    } else {}
  }

  void _changeStatus() {
    setState(() {
      if (completedFirstVc && !completedSecondVc) {
        alterColorBefore = Colors.green;
        alterColorAfter = Colors.grey;
      } else if (completedFirstVc && completedSecondVc) {
        alterColorBefore = Colors.green;
        alterColorAfter = Colors.green;
      } else if (!completedFirstVc && !completedSecondVc) {
        alterColorBefore = Colors.grey;
        alterColorAfter = Colors.grey;
      } else {
        completedFirstVc == false;
        completedSecondVc == false;
      }
    });
  }
}
