import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/config.dart';
import '../../../config/palette.dart';
import '../../../config/string.dart';
import '../../../models/vc/list/data/vc_data/vc_list_detail.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/device/orientations.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/alert/alert_dialog.dart';
import '../../../widgets/alert/toast.dart';
import '../../../widgets/tabs/vehicle_checklist_tab/vehicle_checklist_form_tab/vehicle_checklist_form_tab.dart';

class VehicleChecklistListDetails extends StatefulWidget {
  final VCListDetail vcData;

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
    if (widget.vcData.statusCode!.code == null) {
      bfrStatusColor = greyCustom;
      aftStatusColor = greyCustom;
      bfrEnable = false;
      aftEnable = false;
    } else if (widget.vcData.statusCode!.code == "VC1") {
      bfrStatusColor = greenCustom;
      aftStatusColor = greyCustom;
      bfrEnable = true;
      aftEnable = false;
    } else if (widget.vcData.statusCode!.code == "VC2") {
      bfrStatusColor = greenCustom;
      aftStatusColor = greenCustom;
      bfrEnable = true;
      aftEnable = true;
    } else if (widget.vcData.statusCode!.code == "VC3") {
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
              widget.vcData.createdAt.toString().split(' ')[0] ==
                      Date.getTheDate(DateTime.now(), '', "yyyy-MM-dd", 'ms')
                  ? "Hari Ini"
                  : Date.getTheDate(widget.vcData.createdAt, "yyyy-MM-dd",
                      "dd/MM/yyyy", "ms"),
              style: TextStyle(
                  fontSize: 18,
                  color: blackCustom,
                  fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                /*  Timer(const Duration(milliseconds: 200), () {
                  setState(() {
                    widget.vcData.statusCode != null
                        ? bfrStatusColor = greenCustom
                        : bfrStatusColor = greyCustom;
                  });
                });*/
                Navigator.push(
                    context,
                    PageTransition(
                        child:
                            VehicleChecklistFormTab(vcListData: widget.vcData),
                        type: PageTransitionType.fade));
              },
              onTapDown: (_) {
                setState(() {
                  bfrStatusColor = hoverColor;
                });
              },
              onTapUp: (_) {
                setState(() {
                  widget.vcData.statusCode != null
                      ? bfrStatusColor = greenCustom
                      : bfrStatusColor = greyCustom;
                });
              },
              onTapCancel: () {
                setState(() {
                  widget.vcData.statusCode != null
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
                if (!aftEnable) {
                  widget.vcData.createdAt.toString().split(' ')[0] ==
                              Date.getTheDate(
                                  DateTime.now(), '', "yyyy-MM-dd", 'ms') &&
                          vcStatus != 3
                      ? showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return showAlertDialog(context, "Notis",
                                afterVcInactive, "", "Kembali");
                          }).then((actionText) {
                          if (actionText == "Kembali") {
                            //Navigator.pop(context);
                          }
                        })
                      : widget.vcData.createdAt.toString().split(' ')[0] ==
                                  Date.getTheDate(
                                      DateTime.now(), '', "yyyy-MM-dd", 'ms') &&
                              vcStatus == 3
                          ? Navigator.push(
                              context,
                              PageTransition(
                                  child: VehicleChecklistFormTab(
                                      idx: 1, vcListData: widget.vcData),
                                  type: PageTransitionType.fade))
                          : showInfoToast(context,
                              "Tiada rekod Semakan Kenderaan (Selepas Balik) pada hari ${Date.getTheDate(widget.vcData.createdAt, "yyyy-MM-dd", "dd/MM/yyyy", "ms")}");
                } else {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: VehicleChecklistFormTab(
                              idx: 1, vcListData: widget.vcData),
                          type: PageTransitionType.fade));
                }
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
