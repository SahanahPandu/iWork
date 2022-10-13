import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/vc/vc.dart';
import '../../../../screens/vehicle_checklist/vehicle_checklist_form/vehicle_checklist_form_detail.dart';
import '../../../../utils/device/sizes.dart';

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
  Color alterColorBefore = greyCustom;
  Color alterColorAfter = greyCustom;

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
                  padding: const EdgeInsets.fromLTRB(40, 32, 0, 25),
                  child: Text(
                    vc,
                    style: TextStyle(
                        fontSize: 18,
                        color: blackCustom,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 16),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 18,
                    color: alterColorBefore,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Sebelum Bertugas",
                    style: TextStyle(
                      fontSize: 16,
                      color: alterColorBefore,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 16),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 18,
                    color: alterColorAfter,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Selepas Bertugas",
                    style: TextStyle(
                      fontSize: 16,
                      color: alterColorAfter,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: tabletTaskCardMargin(context),
          height: 40,
          width: 330,
          child: ElevatedButton(
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(greenCustom),
              elevation: MaterialStateProperty.all(0),
              overlayColor:
                  MaterialStateColor.resolveWith((states) => green800),
              shadowColor: MaterialStateProperty.all(grey900),
              minimumSize: MaterialStateProperty.all(
                  Size(Sizes().screenWidth(context), 40)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            child: Text(vc, style: TextStyle(fontSize: 15, color: white)),
          ),
        ),
      ],
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    bool refresh = await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: VehicleChecklistDetail(data: widget.data)));
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
