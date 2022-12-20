import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../config/palette.dart';
import '../../../config/string.dart';
import '../../../models/akbk.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../utils/device/sizes.dart';
import '../../../widgets/alert/alert_dialog.dart';
import '../../../widgets/alert/lottie_alert_dialog.dart';
import 'akbk_form_details.dart';

class AkbkForm extends StatefulWidget {
  final Akbk? data;

  const AkbkForm({Key? key, this.data}) : super(key: key);

  @override
  State<AkbkForm> createState() => _AkbkFormState();
}

class _AkbkFormState extends State<AkbkForm> {
  final ExpandableController _mainAkbkController =
      ExpandableController(initialExpanded: true);
  final ExpandableController _operationAkbkController =
      ExpandableController(initialExpanded: true);
  final ExpandableController _odometerAkbkController =
      ExpandableController(initialExpanded: false);
  final ExpandableController _breakdownAkbkController =
      ExpandableController(initialExpanded: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: widget.data != null
            ? PreferredSize(
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
                          icon: Icon(CustomIcon.arrowBack,
                              color: blackCustom, size: 22),
                        ),
                        title: Center(
                            child: Text("No AKBK <${widget.data!.akbkNo}>",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: blackCustom,
                                  fontWeight: FontWeight.w400,
                                ))))))
            : null,
        body: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: widget.data == null
                        ? Text(
                            "Lengkapkan maklumat AKBK:",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: blackCustom,
                                fontSize: 15),
                          )
                        : Text(
                            "Maklumat borang AKBK:",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: blackCustom,
                                fontSize: 15),
                          )),
                ExpandableNotifier(
                    controller: _mainAkbkController,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: ExpandableButton(
                                  child: InkWell(
                                      highlightColor: white,
                                      onTap: () {
                                        _mainAkbkController.toggle();
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "1. Arahan Kerja Baik Pulih",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: blackCustom,
                                                  fontSize: 13),
                                            ),
                                            Icon(
                                              _mainAkbkController.expanded
                                                  ? CustomIcon.expand
                                                  : CustomIcon.collapse,
                                              color: activeColor,
                                              size: 16,
                                            )
                                          ])))),
                          ScrollOnExpand(
                              scrollOnCollapse: false,
                              scrollOnExpand: true,
                              child: Expandable(
                                collapsed: Container(),
                                expanded:
                                    AkbkFormDetails(part: 1, data: widget.data),
                              ))
                        ])),
                ExpandableNotifier(
                    controller: _operationAkbkController,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: ExpandableButton(
                                  child: InkWell(
                                      highlightColor: white,
                                      onTap: () {
                                        _operationAkbkController.toggle();
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "2. Maklumat Operasi",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: blackCustom,
                                                  fontSize: 13),
                                            ),
                                            Icon(
                                              _operationAkbkController.expanded
                                                  ? CustomIcon.expand
                                                  : CustomIcon.collapse,
                                              color: activeColor,
                                              size: 16,
                                            )
                                          ])))),
                          ScrollOnExpand(
                              scrollOnCollapse: false,
                              scrollOnExpand: true,
                              child: Expandable(
                                collapsed: Container(),
                                expanded:
                                    AkbkFormDetails(part: 2, data: widget.data),
                              ))
                        ])),
                ExpandableNotifier(
                    controller: _odometerAkbkController,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: ExpandableButton(
                                  child: InkWell(
                                      highlightColor: white,
                                      onTap: () {
                                        _odometerAkbkController.toggle();
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "3. Odometer",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: blackCustom,
                                                  fontSize: 13),
                                            ),
                                            Icon(
                                              _odometerAkbkController.expanded
                                                  ? CustomIcon.expand
                                                  : CustomIcon.collapse,
                                              color: activeColor,
                                              size: 16,
                                            )
                                          ])))),
                          ScrollOnExpand(
                              scrollOnCollapse: false,
                              scrollOnExpand: true,
                              child: Expandable(
                                collapsed: Container(),
                                expanded:
                                    AkbkFormDetails(part: 3, data: widget.data),
                              ))
                        ])),
                ExpandableNotifier(
                  controller: _breakdownAkbkController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: ExpandableButton(
                              child: InkWell(
                                  highlightColor: white,
                                  onTap: () {
                                    _breakdownAkbkController.toggle();
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "4. Butiran Kerosakan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: blackCustom,
                                              fontSize: 13),
                                        ),
                                        Icon(
                                          _breakdownAkbkController.expanded
                                              ? CustomIcon.expand
                                              : CustomIcon.collapse,
                                          color: activeColor,
                                          size: 16,
                                        )
                                      ])))),
                      ScrollOnExpand(
                          scrollOnCollapse: true,
                          scrollOnExpand: true,
                          child: Expandable(
                            collapsed: Container(),
                            expanded:
                                AkbkFormDetails(part: 4, data: widget.data),
                          )),
                      const SizedBox(height: 20)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.data == null
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(color: white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      blurRadius: 6,
                      spreadRadius: 0.5)
                ]),
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
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => green800),
                            minimumSize: MaterialStateProperty.all(
                                Size(Sizes().screenWidth(context), 41)),
                            backgroundColor:
                                MaterialStateProperty.all(greenCustom)),
                        child: Text('Hantar Borang',
                            style: TextStyle(
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return showAlertDialog(context, confirmation,
                                    "Hantar borang AKBK ini?", cancel, submit);
                              }).then((actionText) {
                            if (actionText == submit) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return showLottieAlertDialog(
                                        context, _textBuilder(), null, null);
                                  });
                            }
                          });
                        })))
            : const SizedBox());
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Borang AKBK anda pada",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5),
            children: <TextSpan>[
              TextSpan(
                  text:
                      "\n ${DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now())}",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, color: green)),
              TextSpan(
                  text: " telah berjaya dihantar \nkepada pihak mekanik.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom))
            ]));
  }
}
