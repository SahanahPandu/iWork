// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

//import files
import '../../config/palette.dart';
import '../../models/laluan.dart';
import '../../config/config.dart';
import '../../utils/device.dart';
import '../../widgets/buttons/hantar_button.dart';
import '../../models/reports.dart';
import '../../screens/reports/pra/pra_section_report_form.dart';

class ReportForm extends StatefulWidget {
  String screen;
  Reports? data;
  Laluan? dataLaluan;

  ReportForm(
      {Key? key,
      required this.screen,
      required this.data,
      required this.dataLaluan})
      : super(key: key);

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final Devices _device = Devices();
  late StreamSubscription<bool> keyboardSubscription;
  final ExpandableController _controller =
      ExpandableController(initialExpanded: true);
  String namaLaluan = "Laluan";
  String noKenderaan = "No Kenderaan";
  double _height = 500;
  bool buttonVisibility = true;
  //final Devices _device = Devices();

  void onClick() {
    if (_height == 500) {
      setState(() {
        _height = 0;
      });
    } else {
      setState(() {
        _height = 500;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        buttonVisibility =
            !visible; // button Hantar and keyboard  condition are vice versa
      });
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ExpandableNotifier(
            controller: _controller,
            child: Container(
              margin: userRole != 100
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                  : (userRole == 100 &&
                          _device.isLandscape(
                              context)) // condition for compactor panel
                      ? const EdgeInsets.fromLTRB(100, 80, 100, 150)
                      : const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //nama laluan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (widget.screen == "3" &&
                                widget.dataLaluan!.namaLaluan !=
                                    "") // from button Report in work shedule details
                            ? widget.dataLaluan!.namaLaluan
                            : (widget.screen == "4" &&
                                    widget.data!.namaLaluan !=
                                        "") // from report list
                                ? widget.data!.namaLaluan
                                : namaLaluan,
                        style: TextStyle(
                          fontSize: userRole == 100 ? 22 : 20,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (widget.screen == "4")
                        ExpandableButton(
                          child: InkWell(
                            onTap: () {
                              _controller.toggle();
                              setState(() {}); // to update _controller toggle
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black87,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _controller.expanded
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: userRole == 100 ? 30 : 15,
                  ),
                  //no kenderaan
                  Row(
                    children: [
                      const Icon(
                        Icons.local_shipping,
                        size: 19,
                      ),
                      SizedBox(
                        width: userRole == 100 ? 20 : 8,
                      ),
                      Text(
                        "No. Kenderaan",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: userRole != 100
                            ? 8
                            : (userRole == 100 && _device.isLandscape(context))
                                ? 300
                                : 200,
                      ),
                      Text(
                        (widget.screen == "3" &&
                                widget.dataLaluan!.noKenderaan !=
                                    "") // from button Report in work shedule details
                            ? widget.dataLaluan!.noKenderaan
                            : (widget.screen == "4" &&
                                    widget.data!.noKenderaan !=
                                        "") // from report list
                                ? widget.data!.noKenderaan
                                : noKenderaan,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: userRole == 100 ? grey300 : Colors.grey.shade500,
                    thickness: userRole == 100 ? 0.5 : 1,
                  ),
                  SizedBox(
                    height: userRole == 100 ? 30 : 15,
                  ),
                  ScrollOnExpand(
                    scrollOnCollapse: false,
                    scrollOnExpand: false,
                    child: Expandable(
                      collapsed: Container(),
                      expanded: PraSectionReportForm(
                        screen: widget.screen,
                        data: widget.data,
                      ),
                    ),
                  ),
                  //put this at the end of the column widget list ,
                  //because to able scroll all item without being covered by the button at the bottom
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),

        //button
        if (buttonVisibility && widget.screen == "3")
          Positioned(
            bottom: 0,
            child: Material(
              elevation: 50,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: const HantarButton(),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
