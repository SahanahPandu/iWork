import 'package:flutter/material.dart';

import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../utils/device.dart';

class VehicleChecklistCardDetails extends StatefulWidget {
  const VehicleChecklistCardDetails({Key? key}) : super(key: key);

  @override
  State<VehicleChecklistCardDetails> createState() =>
      _VehicleChecklistCardDetailsState();
}

class _VehicleChecklistCardDetailsState
    extends State<VehicleChecklistCardDetails> {
  final Devices _device = Devices();

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
                    "Semakan Kenderaan",
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
                    Icons.check_circle,
                    size: 18,
                    color: green,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Sebelum Bertugas",
                    style: TextStyle(
                      fontSize: 15,
                      color: green,
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
                    Icons.check_circle,
                    size: 18,
                    color: grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Selepas Bertugas",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
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
            onPressed: () {},
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: green)),
                ),
                minimumSize: MaterialStateProperty.all(
                    Size(_device.screenWidth(context), 45)),
                backgroundColor: MaterialStateProperty.all(white)),
            child: Text("Semak Kenderaan",
                style: TextStyle(fontSize: 15, color: green)),
          ),
        ),
      ],
    );
  }
}
