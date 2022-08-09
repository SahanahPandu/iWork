import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../../widgets/modal_bottom_sheet/acceptance_options.dart';
import 'ecuti_approval_detail.dart';

class EcutiApprovalMain extends StatefulWidget {
  final Cuti data;

  const EcutiApprovalMain({Key? key, required this.data}) : super(key: key);

  @override
  State<EcutiApprovalMain> createState() => _EcutiApprovalMain();
}

class _EcutiApprovalMain extends State<EcutiApprovalMain> {
  final ExpandableController _controller =
      ExpandableController(initialExpanded: false);
  final TextEditingController _status = TextEditingController();
  bool buttonVisibility = true;
  Color iconColor = grey500;

  @override
  void initState() {
    iconColor = grey500;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 1,
          shadowColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CustomIcon.arrowBack,
                color: Colors.grey.shade900, size: 15),
          ),
          title: Center(
            child: Text(
              "Perician",
              style: TextStyle(
                fontSize: 18,
                color: grey800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.history,
                color: grey800,
                size: 18,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ExpandableNotifier(
            controller: _controller,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableButton(
                    child: InkWell(
                      onTap: () {
                        _controller.toggle();
                        _controller.expanded
                            ? setState(() {
                                iconColor = green;
                              })
                            : setState(() {
                                iconColor = grey500;
                              }); // to update _controller toggle
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Butiran Permohonan E-Cuti",
                            style: TextStyle(
                              fontSize: 14,
                              color: _controller.expanded ? green : grey500,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: iconColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _controller.expanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 18,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ScrollOnExpand(
                    scrollOnCollapse: false,
                    scrollOnExpand: false,
                    child: Expandable(
                      collapsed: Container(),
                      expanded: EcutiApprovalDetail(
                        data: widget.data,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(height: 0.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text("Pengesahan Penyelia :",
                            style: TextStyle(
                                color: _controller.expanded ? green : grey500,
                                fontSize: 14,
                                fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            showAcceptanceOptions(context, _status);
                          },
                          child: TextFormField(
                            controller: _status,
                            readOnly: true,
                            enabled: false,
                            style: TextStyle(color: grey700, fontSize: 14),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: white,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                size: 18,
                                color: black87,
                              ),
                              labelText: "Pilih Status",
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: grey,
                                fontWeight: FontWeight.w300,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: grey500,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadiusCircular),
                                //gapPadding: 6.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: 150,
                          child: TextFormField(
                            cursorColor: green,
                            cursorHeight: 18,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 10,
                            style: TextStyle(color: grey700, fontSize: 14),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: white,
                              focusColor: green,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              labelText: "Catatan",
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: grey,
                                fontWeight: FontWeight.w300,
                              ),
                              border: const OutlineInputBorder(),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: green)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: green),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: grey500,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadiusCircular),
                                //gapPadding: 6.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        Size(Devices().screenWidth(context), 41)),
                    backgroundColor: MaterialStateProperty.all(green)),
                child: Text('Hantar',
                    style: TextStyle(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return showAlertDialog(
                            context,
                            confirmation,
                            "Sahkan borang E-Cuti ini?",
                            cancel,
                            "Sahkan");
                      }).then((actionText) {
                    if (actionText == "Sahkan") {
                      Navigator.pop(context, 'refreshEcuti');
                    }
                  });
                },
              ),
            ),
          ),
        ));
  }
}
