import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../../widgets/alert/lottie_alert_dialog.dart';
import '../../../../widgets/modal_bottom_sheet/custom_bottom_sheet_options.dart';
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
  final TextEditingController _feedback = TextEditingController();
  List leaveStatusList = ['Diluluskan', 'Diluluskan tanpa lampiran', 'Ditolak'];
  bool buttonVisibility = true;
  Color iconColor = grey500;
  int condition = 0;

  @override
  void initState() {
    iconColor = grey500;
    _loadLeaveStatus(widget.data.idStatus);
    _setSvFeedbackText(condition);
    super.initState();
  }

  void _setSvFeedbackText(int condition) {
    switch (condition) {
      case 2:
      case 3:
      case 4:
        if (widget.data.status != "") {
          _status.text = widget.data.status;
        }
        if (widget.data.maklumbalasSV != "") {
          _feedback.text = widget.data.maklumbalasSV;
        } else {
          _feedback.text = "-";
        }
        break;
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
                  "Pengesahan E-Cuti",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: const [SizedBox(width: 50)],
            ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: ExpandableNotifier(
              controller: _eCutiController,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    const SizedBox(height: 5),
                    const Divider(height: 0.5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Text("Pengesahan Penyelia :",
                              style: TextStyle(
                                  color: blackCustom,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400)),
                        ),
                        _buildLeaveSections(context, condition),
                      ],
                    )
                  ],
                ),
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
                  backgroundColor: MaterialStateProperty.all(greenCustom)),
              child: Text('Hantar',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w700)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(
                          context,
                          confirmation,
                          "Sahkan borang E-Cuti pekerja ${widget.data.pemohon}?",
                          cancel,
                          "Sahkan");
                    }).then((actionText) {
                  if (actionText == "Sahkan") {
                    Navigator.pop(context, 'refreshEcuti');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showLottieAlertDialog(
                              context, _textBuilder(), null);
                        });
                  }
                });
              },
            ),
          ),
        ));
  }

  Widget _buildLeaveSections(BuildContext context, int condition) {
    switch (condition) {
      case 1:
        return _getSvFeedbackColumn(context);
      case 2:
      case 3:
      case 4:
        return _setSvFeedbackColumn();
    }
    return Container();
  }

  Column _setSvFeedbackColumn() {
    return Column(
      children: [
        _buildTextForm(_status, "Status Permohonan"),
        _buildTextForm(_feedback, "Maklumbalas Penyelia", true),
      ],
    );
  }

  Column _getSvFeedbackColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
              onTap: () {
                showBottomSheetOptions(context, leaveStatusList, 0.32, _status);
              },
              child: _buildInactiveTextField(_status, "Status Permohonan")),
        ),
        _buildActiveTextField(_feedback, "Maklumbalas Penyelia")
      ],
    );
  }

  Padding _buildActiveTextField(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 100,
        child: TextFormField(
          controller: controller,
          cursorColor: green,
          cursorHeight: 20,
          cursorWidth: 1.2,
          textInputAction: TextInputAction.done,
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
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 14,
              color: labelColor,
              fontWeight: FontWeight.w400,
            ),
            border: const OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: green)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: green, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: controller.text != "" ? greenCustom : borderTextColor,
              ),
              borderRadius: BorderRadius.circular(4),
              //gapPadding: 6.0,
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildInactiveTextField(
      TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
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
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: labelColor,
          fontWeight: FontWeight.w400,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: controller.text != "" ? greenCustom : borderTextColor,
          ),
          borderRadius: BorderRadius.circular(4),
          //gapPadding: 6.0,
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

  void _loadLeaveStatus(int leaveStatus) {
    switch (leaveStatus) {
      //Baru
      case 1:
        switch (userRole) {
          // sv/eo/ba -> need to accept/reject ecuti from pra.
          case 300:
          case 400:
          case 500:
            // BUTIRAN: filled up leave form by pra, PENGESAHAN: sv/eo/ba -> acceptance option & feedback
            condition = 1;
            break;
        }
        break;
      //Diluluskan tanpa lampiran
      case 2:
        switch (userRole) {
          // sv/eo/ba -> wait pra to upload attachment
          case 300:
          case 400:
          case 500:
            // BUTIRAN: filled up leave form by pra, PENGESAHAN: sv/eo/ba -> filled up acceptance option & feedback
            condition = 2;
            break;
        }
        break;
      //Diluluskan
      case 3:
        switch (userRole) {
          // sv -> completed process
          case 300:
          case 400:
          case 500:
            // BUTIRAN: filled up leave form by pra, PENGESAHAN: sv/eo/ba -> filled up acceptance option & feedback
            condition = 3;
            break;
        }
        break;
      //Ditolak
      case 4:
        switch (userRole) {
          // sv -> Penjadualan semula selesai and laporan ditutup
          case 300:
          case 400:
          case 500:
            // BUTIRAN: filled up leave form by pra, PENGESAHAN: sv/eo/ba -> filled up acceptance option & feedback
            condition = 4;
            break;
        }
        break;
      default:
        condition = 0;
    }
  }
}
