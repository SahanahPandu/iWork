import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/palette.dart';
import '../../../models/vc/detail/vc_main.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/alert/alert_dialog.dart';
import '../../../widgets/tabs/vehicle_checklist_tab/vehicle_checklist_form_tab/vehicle_checklist_form_tab.dart';

class VehicleChecklistListDetails extends StatefulWidget {
  final VehicleChecklistMain vcData;

  const VehicleChecklistListDetails({Key? key, required this.vcData})
      : super(key: key);

  @override
  State<VehicleChecklistListDetails> createState() =>
      _VehicleChecklistListDetailsState();
}

class _VehicleChecklistListDetailsState
    extends State<VehicleChecklistListDetails> {
  Color bfrStatusColor = greyCustom;
  Color aftStatusColor = greyCustom;
  bool bfrEnable = false;
  bool aftEnable = false;

  /// STATUS    |      SEBELUM                           |    SELEPAS
  ///   1       |      initial = incomplete, enable vc   |    initial = incomplete, unable vc & show alert box
  ///   2       |      initial = complete, enable vc     |    initial = incomplete, unable vc & show alert box
  ///   3       |      initial = complete, enable vc     |    initial = complete, enable vc
  @override
  void initState() {
    if (widget.vcData.data!.vehicleChecklists == null) {
      bfrStatusColor = greyCustom;
      aftStatusColor = greyCustom;
      bfrEnable = false;
      aftEnable = false;
    } else if (widget.vcData.data!.vehicleChecklists!.statusCode == "VC1") {
      bfrStatusColor = greenCustom;
      aftStatusColor = greyCustom;
      bfrEnable = true;
      aftEnable = false;
    } else if (widget.vcData.data!.vehicleChecklists!.statusCode == "VC2") {
      bfrStatusColor = greenCustom;
      aftStatusColor = greenCustom;
      bfrEnable = true;
      aftEnable = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: Orientations().isTabletPortrait(context)
            ? const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1)
              }
            : const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1.5)
              },
        border: TableBorder.all(color: transparent),
        children: [
          TableRow(children: [
            Text(
              widget.vcData.data!.vehicleChecklists!.createdAt
                          .toString()
                          .split(' ')[0] ==
                      Date.getTheDate(DateTime.now(), '', "yyyy-MM-dd", 'ms')
                  ? "Hari Ini"
                  : widget.vcData.data!.vehicleChecklists!.createdAt
                      .toString()
                      .split(' ')[0],
              style: TextStyle(
                  fontSize: 18,
                  color: blackCustom,
                  fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                Timer(const Duration(milliseconds: 200), () {
                  setState(() {
                    widget.vcData.data!.vehicleChecklists != null
                        ? bfrStatusColor = greenCustom
                        : bfrStatusColor = greyCustom;
                  });
                });
                Navigator.push(
                    context,
                    PageTransition(
                        child: const VehicleChecklistFormTab(),
                        type: PageTransitionType.fade));
              },
              onTapDown: (_) {
                setState(() {
                  bfrStatusColor = hoverColor;
                });
              },
              onTapUp: (_) {
                setState(() {
                  widget.vcData.data!.vehicleChecklists != null
                      ? bfrStatusColor = greenCustom
                      : bfrStatusColor = greyCustom;
                });
              },
              onTapCancel: () {
                setState(() {
                  widget.vcData.data!.vehicleChecklists != null
                      ? bfrStatusColor = greenCustom
                      : bfrStatusColor = greyCustom;
                });
              },
              child: Row(
                children: [
                  Icon(CustomIcon.check, color: bfrStatusColor, size: 16),
                  const SizedBox(width: 15),
                  Text(
                    "Sebelum Keluar",
                    style: TextStyle(
                        fontSize: 16,
                        color: bfrStatusColor,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                aftEnable
                    ? Timer(const Duration(milliseconds: 200), () {
                        setState(() {
                          aftStatusColor = greenCustom;
                        });
                      })
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showAlertDialog(
                              context,
                              "Notis",
                              "Semakan Kenderaan (Selepas Balik) akan \ndiaktif dan perlu diisi selepas semua tugasan \ntamat dan selesai.",
                              "",
                              "Kembali");
                        }).then((actionText) {
                        if (actionText == "Kembali") {
                          //Navigator.pop(context);
                        }
                      });
                aftEnable
                    ? Navigator.push(
                        context,
                        PageTransition(
                            child: const VehicleChecklistFormTab(idx: 1),
                            type: PageTransitionType.fade))
                    : null;
              },
              onTapDown: (_) {
                aftEnable
                    ? setState(() {
                        aftStatusColor = hoverColor;
                      })
                    : null;
              },
              onTapUp: (_) {
                aftEnable
                    ? setState(() {
                        aftStatusColor = greenCustom;
                      })
                    : null;
              },
              onTapCancel: () {
                aftEnable
                    ? setState(() {
                        aftStatusColor = greenCustom;
                      })
                    : null;
              },
              child: Row(
                children: [
                  Icon(CustomIcon.check, color: aftStatusColor, size: 16),
                  const SizedBox(width: 15),
                  Text(
                    "Selepas Balik",
                    style: TextStyle(
                        fontSize: 16,
                        color: aftStatusColor,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            if (!Orientations().isTabletPortrait(context))
              const Text(
                "",
              ),
          ]),
        ]);
  }
}
