// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/config.dart';
import '../../screens/list_of_leave_type/list_of_leave_type.dart';
import '../../widgets/buttons/upload_files_button.dart';
import '../../config/palette.dart';
import '../../utils/device.dart';
import '../../config/font.dart';
import '../../models/cuti.dart';
import '../../widgets/buttons/hantar_button.dart';

class LeaveForm extends StatefulWidget {
  String screen;
  Cuti? data;

  LeaveForm({Key? key, required this.screen, this.data}) : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  late StreamSubscription<bool> keyboardSubscription;
  final _formKey = GlobalKey<FormState>();
  final Devices _device = Devices();
  final TextEditingController _tarikhMula = TextEditingController();
  final TextEditingController _tarikhTamat = TextEditingController();
  final TextEditingController _lampiran = TextEditingController();
  final TextEditingController _catatan = TextEditingController();

  late FocusNode? _catatanFocusNode;

  Color textFieldFillColor = textFormFieldFillColor;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  bool _lampiranVisibility = true;
  bool _lampiranDetailsVisibility = false;
  double spaceHeight = 15;
  String jenisCuti = "";
  bool buttonVisibility = true;
  int iconCondition = 1;
  int borderCondition = 1;

  loadData() {
    // ignore: unnecessary_null_comparison
    if (widget.screen == "2") {
      //from leave list
      setState(() {
        textFieldFillColor = Colors.grey.shade300;
        focusBorderColor = Colors.grey.shade300;
        enableBorderWithTextColor = Colors.grey.shade300;
        iconCondition = 0;
        borderCondition = 0;

        if ((widget.data!.idStatus == 4 || widget.data!.idStatus == 3) &&
            widget.data!.lampiran == "") {
          _lampiranVisibility = false;
          _lampiranDetailsVisibility = false;
        } else if (widget.data!.idStatus != 2) {
          _lampiranVisibility = false;
          _lampiranDetailsVisibility = true;
        }

        if (widget.data!.jenisCuti != "") {
          jenisCuti = widget.data!.jenisCuti;
        }
        if (widget.data!.tarikhMula != "") {
          _tarikhMula.text = widget.data!.tarikhMula;
        }
        if (widget.data!.tarikhTamat != "") {
          _tarikhTamat.text = widget.data!.tarikhTamat;
        }

        if (widget.data!.lampiran != "") {
          _lampiran.text = widget.data!.lampiran;
        }

        if (widget.data!.catatan != "") {
          _catatan.text = widget.data!.catatan;
        }
      });
    }
  }

  @override
  void initState() {
    _catatanFocusNode = FocusNode();
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
    loadData();
  }

  @override
  void dispose() {
    _catatanFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
          focus.focusedChild?.unfocus();
        }
      },
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lengkapkan maklumat di bawah:",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: spaceHeight,
                    ),
                    //Jenis Cuti
                    ListOfLeaveType(
                      hintText: 'Pilih Jenis Cuti',
                      fontSize: 15,
                      borderCondition: borderCondition, // have border
                      fillColor: textFieldFillColor,
                      iconCondition: iconCondition,
                      data: jenisCuti,
                    ),

                    SizedBox(
                      height: spaceHeight,
                    ),
                    //Tarikh Mula & Tarikh Tamat

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //tarikh mula
                        InkWell(
                          onTap: () async {
                            if (widget.screen != "2") {
                              DateTime? getStartDate =
                                  await datePicker(context);
                              if (getStartDate != null) {
                                setState(() {
                                  _tarikhMula.text = DateFormat("dd/MM/yyyy")
                                      .format(getStartDate);
                                });
                              }
                            }
                          },
                          child: SizedBox(
                            width: _device.screenWidth(context) * 0.42,
                            child: TextFormField(
                              controller: _tarikhMula,
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: textFieldFillColor,
                                contentPadding: userRole == 100
                                    ? const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20)
                                    : const EdgeInsets.all(8),
                                hintText: 'Tarikh Mula',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: labelTextColor,
                                  fontWeight: textFormFieldLabelFontWeight,
                                ),
                                labelText:
                                    borderCondition == 1 && iconCondition == 1
                                        ? 'Tarikh Mula'
                                        : null,
                                labelStyle:
                                    borderCondition == 1 && iconCondition == 1
                                        ? TextStyle(
                                            fontSize: 15,
                                            color: labelTextColor,
                                            fontWeight:
                                                textFormFieldLabelFontWeight,
                                          )
                                        : null,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: borderCondition == 0
                                      ? BorderSide.none
                                      : BorderSide(
                                          width: borderSideWidth,
                                          color: _tarikhMula.text != '' &&
                                                  iconCondition == 1
                                              ? (userRole == 100
                                                  ? grey100
                                                  : enabledBorderWithText)
                                              : (userRole == 100
                                                  ? grey100
                                                  : enabledBorderWithoutText),
                                        ),
                                  borderRadius: BorderRadius.circular(
                                      borderRadiusCircular),
                                  gapPadding: 6.0,
                                ),
                                suffixIcon: IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      VerticalDivider(
                                        color: Colors.grey.shade400,
                                        thickness: 1,
                                        indent: 8,
                                        endIndent: 8,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        child: Icon(
                                          Icons.date_range,
                                          size: 30,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //tarikh tamat
                        InkWell(
                          onTap: () async {
                            if (widget.screen != "2") {
                              DateTime? getEndDate = await datePicker(context);
                              if (getEndDate != null) {
                                setState(() {
                                  _tarikhTamat.text = DateFormat("dd/MM/yyyy")
                                      .format(getEndDate);
                                });
                              }
                            }
                          },
                          child: SizedBox(
                            width: _device.screenWidth(context) * 0.42,
                            child: TextFormField(
                              controller: _tarikhTamat,
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: textFieldFillColor,
                                contentPadding: userRole == 100
                                    ? const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20)
                                    : const EdgeInsets.all(8),
                                hintText: 'Tarikh Tamat',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: labelTextColor,
                                  fontWeight: textFormFieldLabelFontWeight,
                                ),
                                labelText:
                                    borderCondition == 1 && iconCondition == 1
                                        ? 'Tarikh Tamat'
                                        : null,
                                labelStyle:
                                    borderCondition == 1 && iconCondition == 1
                                        ? TextStyle(
                                            fontSize: 15,
                                            color: labelTextColor,
                                            fontWeight:
                                                textFormFieldLabelFontWeight,
                                          )
                                        : null,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: borderCondition == 0
                                      ? BorderSide.none
                                      : BorderSide(
                                          width: borderSideWidth,
                                          color: _tarikhTamat.text != '' &&
                                                  iconCondition == 1
                                              ? (userRole == 100
                                                  ? grey100
                                                  : enabledBorderWithText)
                                              : (userRole == 100
                                                  ? grey100
                                                  : enabledBorderWithoutText),
                                        ),
                                  borderRadius: BorderRadius.circular(
                                      borderRadiusCircular),
                                  gapPadding: 6.0,
                                ),
                                suffixIcon: IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      VerticalDivider(
                                        color: Colors.grey.shade400,
                                        thickness: 1,
                                        indent: 8,
                                        endIndent: 8,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        child: Icon(
                                          Icons.date_range,
                                          size: 30,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Lampiran
                    SizedBox(
                      height: spaceHeight,
                    ),
                    if (_lampiranVisibility)
                      SizedBox(
                        width: _device.screenWidth(context),
                        child: UploadFilesButton(textLampiran: _lampiran.text),
                      ),

                    //Detail Lampiran
                    if (_lampiranDetailsVisibility)
                      SizedBox(
                        width: _device.screenWidth(context),
                        child: TextFormField(
                          controller: _lampiran,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: textFieldFillColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: borderSideWidth,
                                color: focusBorderColor,
                              ),
                              borderRadius:
                                  BorderRadius.circular(borderRadiusCircular),
                            ),
                            enabledBorder: _catatan.text != ''
                                ? OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: borderSideWidth,
                                      color: enableBorderWithTextColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        borderRadiusCircular),
                                  )
                                : OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: borderSideWidth,
                                      color: enabledBorderWithoutText,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        borderRadiusCircular),
                                  ),
                            contentPadding: const EdgeInsets.all(15),
                          ),
                          enabled: false,
                        ),
                      ),
                    SizedBox(
                      height: spaceHeight,
                    ),

                    //Catatan
                    TextFormField(
                      controller: _catatan,
                      maxLines: 5,
                      enabled: (widget.screen == "2") ? false : true,
                      cursorColor: green,
                      focusNode: _catatanFocusNode,
                      onTap: () {
                        FocusScope.of(context).requestFocus(_catatanFocusNode);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textFieldFillColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: borderSideWidth,
                            color: focusBorderColor,
                          ),
                          borderRadius:
                              BorderRadius.circular(borderRadiusCircular),
                        ),
                        enabledBorder: _catatan.text != ''
                            ? OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: borderSideWidth,
                                  color: enableBorderWithTextColor,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadiusCircular),
                              )
                            : OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: borderSideWidth,
                                  color: enabledBorderWithoutText,
                                ),
                                borderRadius:
                                    BorderRadius.circular(borderRadiusCircular),
                              ),
                        alignLabelWithHint: true,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        labelText: _catatan.text == '' ? 'Catatan' : null,
                        labelStyle: _catatan.text == ''
                            ? TextStyle(
                                color: labelTextColor,
                                fontWeight: textFormFieldLabelFontWeight,
                              )
                            : null,
                        contentPadding: const EdgeInsets.all(15),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          //button
          if (buttonVisibility && widget.screen == "1")
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
      ),
    );
  }
}

Future datePicker(context) {
  DateTime current = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(current.year),
    lastDate: DateTime(current.year + 5),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  );
}
