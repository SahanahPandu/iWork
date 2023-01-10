import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/task/compactor/compactor_task.dart';
import '../../../../utils/device/sizes.dart';
import '../../../tabs/vehicle_checklist_tab/vehicle_checklist_form_tab/vehicle_checklist_form_tab.dart';

class VehicleChecklistCardDetails extends StatefulWidget {
  final CompactorTask? compactorData;

  const VehicleChecklistCardDetails({Key? key, this.compactorData})
      : super(key: key);

  @override
  State<VehicleChecklistCardDetails> createState() =>
      _VehicleChecklistCardDetailsState();
}

class _VehicleChecklistCardDetailsState
    extends State<VehicleChecklistCardDetails> {
  Color alterColorBefore = greyCustom;
  Color alterColorAfter = greyCustom;
  Color buttonColor = grey100;
  Color buttonTextColor = white;
  Color buttonSplashColor = green800;
  int vcCondition = 0;

  @override
  void initState() {
    if (otherDate && selectedNewDate != '') {
      buttonColor = grey100;
      buttonTextColor = grey500;
      buttonSplashColor = transparent;
      vcCondition = -1;
    }
    if (widget.compactorData!.data!.vehicleChecklistId == null ||
        vcStatus == 0) {
      alterColorBefore = greyCustom;
      alterColorAfter = greyCustom;
      buttonColor = greenCustom;
      buttonTextColor = white;
      buttonSplashColor = green800;
      if (vcCondition == -1) {
        buttonColor = grey100;
        buttonTextColor = grey500;
        buttonSplashColor = transparent;
      }
    } else if (widget
            .compactorData!.data!.vehicleChecklistId!.statusCode!.code! ==
        "VC1") {
      alterColorBefore = greenCustom;
      alterColorAfter = greyCustom;
      if (vcStatus == 1 &&
          (widget.compactorData!.data!.vehicleChecklistId!.timeOut == null ||
              widget.compactorData!.data!.vehicleChecklistId!.timeOut ==
                  "--:--")) {
        buttonColor = grey100;
        buttonTextColor = grey500;
        buttonSplashColor = transparent;
      } else if (vcStatus == 2 &&
          (widget.compactorData!.data!.vehicleChecklistId!.timeOut != null ||
              widget.compactorData!.data!.vehicleChecklistId!.timeOut !=
                  "--:--")) {
        buttonColor = grey100;
        buttonTextColor = grey500;
        buttonSplashColor = transparent;
      } else if (vcStatus == 3 &&
          (widget.compactorData!.data!.vehicleChecklistId!.timeOut != null ||
              widget.compactorData!.data!.vehicleChecklistId!.timeOut !=
                  "--:--")) {
        buttonColor = greenCustom;
        buttonTextColor = white;
        buttonSplashColor = green800;
      }
    } else if (widget
                .compactorData!.data!.vehicleChecklistId!.statusCode!.code! ==
            "VC2" ||
        widget.compactorData!.data!.vehicleChecklistId!.statusCode!.code! ==
            "VC3") {
      alterColorBefore = greenCustom;
      alterColorAfter = greenCustom;
      buttonColor = grey100;
      buttonTextColor = grey500;
      buttonSplashColor = transparent;
    }

    super.initState();
  }

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
            InkWell(
              onTap: () {
                widget.compactorData!.data!.vehicleChecklistId != null
                    ? Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: VehicleChecklistFormTab(
                                compactorData: widget.compactorData)))
                    : null;
              },
              child: Padding(
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
                      "Sebelum Keluar",
                      style: TextStyle(
                        fontSize: 16,
                        color: alterColorBefore,
                        fontWeight: alterColorBefore == greenCustom
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (widget.compactorData!.data!.vehicleChecklistId != null) {
                  widget.compactorData!.data!.vehicleChecklistId!.statusCode!
                                  .code ==
                              "VC2" ||
                          widget.compactorData!.data!.vehicleChecklistId!
                                  .statusCode!.code ==
                              "VC3"
                      ? Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: VehicleChecklistFormTab(
                                  compactorData: widget.compactorData, idx: 1)))
                      : null;
                }
              },
              child: Padding(
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
                      "Selepas Balik",
                      style: TextStyle(
                        fontSize: 16,
                        color: alterColorAfter,
                        fontWeight: alterColorAfter == greenCustom
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: tabletTaskCardMargin(context),
          height: 42,
          width: 330,
          child: ElevatedButton(
            onPressed: () {
              if (vcCondition != -1) {
                if (widget.compactorData!.data!.vehicleChecklistId == null) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: VehicleChecklistFormTab(
                              compactorData: widget.compactorData)));
                } else if (vcStatus == 3 &&
                    (widget.compactorData!.data!.vehicleChecklistId!.timeOut !=
                            "--:--" &&
                        widget.compactorData!.data!.vehicleChecklistId!
                                .timeIn !=
                            "--:--")) {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: VehicleChecklistFormTab(
                              compactorData: widget.compactorData, idx: 1)));
                } else {
                  null;
                }
              } else {
                null;
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
              elevation: MaterialStateProperty.all(0),
              overlayColor:
                  MaterialStateColor.resolveWith((states) => buttonSplashColor),
              shadowColor: MaterialStateProperty.all(grey900),
              minimumSize: MaterialStateProperty.all(
                  Size(Sizes().screenWidth(context), 40)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text(vc,
                style: TextStyle(fontSize: 15, color: buttonTextColor)),
          ),
        ),
      ],
    );
  }

/* Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: VehicleChecklistFormTab(scheduleData: widget.scheduleData)));

     if (!mounted) return;
    if (refresh == true) {
      _changeStatus();
    } else {}
  }*/

/*void _changeStatus() {
    setState(() {
      if (completedFirstVc && !completedSecondVc) {
        alterColorBefore = Colors.green;
        alterColorAfter = Colors.grey;
        buttonColor = grey200;
        buttonTextColor = grey400;
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
  }*/
}
