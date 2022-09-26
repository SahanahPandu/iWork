import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/vc/vc.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device/sizes.dart';
import '../../../alert/alert_dialog.dart';
import '../../../alert/lottie_alert_dialog.dart';
import 'vehicle_checklist_approval_tab_bar_view/vehicle_checklist_approval_after_tab_bar_view.dart';
import 'vehicle_checklist_approval_tab_bar_view/vehicle_checklist_approval_before_tab_bar_view.dart';

class VehicleChecklistApprovalTab extends StatefulWidget {
  final VehicleChecklist data;

  const VehicleChecklistApprovalTab({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistApprovalTab> createState() =>
      _VehicleChecklistApprovalTabState();
}

class _VehicleChecklistApprovalTabState
    extends State<VehicleChecklistApprovalTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: barShadowColor,
                offset: const Offset(0, 3),
                blurRadius: 8,
              )
            ]),
            child: AppBar(
              backgroundColor: white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
              ),
              title: Center(
                child: Text(
                  "Semakan Kenderaan",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CustomIcon.filter,
                    color: blackCustom,
                    size: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: tabBoxColor,
                    borderRadius: BorderRadius.circular(
                      46,
                    ),
                  ),
                  child: TabBar(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    controller: _tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          46,
                        ),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: tabShadowColor,
                            blurRadius: 1,
                            offset: const Offset(0.0, 2.0),
                          ),
                        ]),
                    labelColor: blackCustom,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                    unselectedLabelColor: greyCustom,
                    tabs: const [
                      Tab(
                        text: 'Sebelum',
                      ),
                      Tab(
                        text: 'Selepas',
                      ),
                    ],
                  ),
                ),
              ),
              ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(overscroll: false),
                child: Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      VehicleChecklistApprovalBeforeTabbarView(
                          data: widget.data),
                      VehicleChecklistApprovalAfterTabbarView(
                          data: widget.data),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 6,
                  spreadRadius: 0.5)
            ],
          ),
          child: SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  overlayColor:
                      MaterialStateColor.resolveWith((states) => green800),
                  minimumSize: MaterialStateProperty.all(
                      Size(Sizes().screenWidth(context), 41)),
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text('Sahkan',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w700)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(
                          context,
                          confirmation,
                          "Anda pasti untuk sahkan borang Semakan Kenderaan ini?",
                          "Tidak",
                          "Ya, Sahkan");
                    }).then((actionText) {
                  if (actionText == "Ya, Sahkan") {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showLottieAlertDialog(
                              context, _textBuilder(), null);
                        });
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: CustomDialog(text: _textBuilder()),
                    //         type: PageTransitionType.fade));
                  }
                });
              },
            ),
          ),
        ));
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Borang semakan pada ",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5),
            children: <TextSpan>[
              TextSpan(
                  text: DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now()),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: green,
                      height: 1.5)),
              TextSpan(
                  text: " \nbagi kenderaan",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom,
                      height: 1.5)),
              TextSpan(
                  text: " ${widget.data.noKenderaan} ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: green,
                      height: 1.5)),
              TextSpan(
                  text: "telah \nberjaya disahkan oleh anda",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom,
                      height: 1.5))
            ]));
  }
}
