import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../../widgets/alert/lottie_alert_dialog.dart';
import '../../../../widgets/modal_bottom_sheet/acceptance_options.dart';
import 'ecuti_approval_detail.dart';

class EcutiApprovalMain extends StatefulWidget {
  final Cuti data;

  const EcutiApprovalMain({Key? key, required this.data}) : super(key: key);

  @override
  State<EcutiApprovalMain> createState() => _EcutiApprovalMain();
}

class _EcutiApprovalMain extends State<EcutiApprovalMain> {
  final ExpandableController _eCutiController =
      ExpandableController(initialExpanded: false);
  final TextEditingController _status = TextEditingController();
  final TextEditingController _by = TextEditingController();
  final TextEditingController _leaveType = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  List leaveStatusList = ['Diluluskan', 'Diluluskan tanpa lampiran', 'Ditolak'];
  bool buttonVisibility = true;
  Color iconColor = grey500;

  @override
  void initState() {
    iconColor = grey500;
    _setMainEcutiText();
    super.initState();
  }

  void _setMainEcutiText() {
    if (widget.data.pemohon != "") {
      setState(() {
        _by.text = widget.data.pemohon;
      });
    }
    if (widget.data.jenisCuti != "") {
      setState(() {
        _leaveType.text = widget.data.jenisCuti;
      });
    }
    if (widget.data.tarikhMula != "") {
      setState(() {
        _startDate.text = widget.data.tarikhMula;
      });
    }
    if (widget.data.tarikhTamat != "") {
      setState(() {
        _endDate.text = widget.data.tarikhTamat;
      });
    }
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
                  "Perincian e-Cuti",
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ExpandableNotifier(
            controller: _eCutiController,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ExpandableButton(
                      child: InkWell(
                        highlightColor: white,
                        onTap: () {
                          _eCutiController.toggle();
                          _eCutiController.expanded
                              ? setState(() {
                                  iconColor = green;
                                })
                              : setState(() {
                                  iconColor = grey500;
                                });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Butiran Permohonan E-Cuti:",
                                style: TextStyle(
                                    color: blackCustom,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                            Icon(
                              _eCutiController.expanded
                                  ? CustomIcon.expand
                                  : CustomIcon.collapse,
                              size: 16,
                              color: activeColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildTextForm(_by, "Pemohon"),
                  _buildTextForm(_leaveType, "Jenis Cuti"),
                  ScrollOnExpand(
                    scrollOnCollapse: false,
                    scrollOnExpand: true,
                    child: Expandable(
                      collapsed: Container(),
                      expanded: EcutiApprovalDetail(
                        data: widget.data,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 0.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text("Pengesahan Penyelia :",
                            style: TextStyle(
                                color: blackCustom,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      ),
                      _getSvStatus(context),
                      _getSvComment()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 6,
                  spreadRadius: 0.5)
            ],
          ),
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
                      Size(Sizes().screenWidth(context), 41)),
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text('Sahkan',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w700)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(context, confirmation,
                          "Sahkan borang E-Cuti ini?", cancel, "Sahkan");
                    }).then((actionText) {
                  if (actionText == "Sahkan") {
                    Navigator.pop(context, 'refreshEcuti');
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

  Padding _getSvComment() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 80,
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            labelText: "Catatan",
            labelStyle: TextStyle(
              fontSize: 14,
              color: labelColor,
              fontWeight: FontWeight.w400,
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
                color: borderTextColor,
              ),
              borderRadius: BorderRadius.circular(4),
              //gapPadding: 6.0,
            ),
          ),
        ),
      ),
    );
  }

  Padding _getSvStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          showAcceptanceOptions(context, leaveStatusList, 0.32, _status);
        },
        child: TextFormField(
          controller: _status,
          readOnly: true,
          enabled: false,
          style: TextStyle(color: grey700, fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            suffixIcon: Icon(
              CustomIcon.dropdown,
              size: 16,
              color: blackCustom,
            ),
            labelText: "Pilih Status",
            labelStyle: TextStyle(
              fontSize: 14,
              color: labelColor,
              fontWeight: FontWeight.w400,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: borderTextColor,
              ),
              borderRadius: BorderRadius.circular(4),
              //gapPadding: 6.0,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTextForm(TextEditingController textController, String label,
      [bool? flex = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: flex! ? 10 : 1,
        controller: textController,
        readOnly: true,
        enabled: false,
        style: TextStyle(
            color: blackCustom, fontSize: 15, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 14,
            color: labelColor,
            fontWeight: FontWeight.w400,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: borderTextColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Borang e-Cuti ini telah berjaya disahkan oleh anda",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5)));
  }
}
