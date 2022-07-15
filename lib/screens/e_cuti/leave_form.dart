// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';

//import files
import 'package:eswm/config/palette.dart';
import 'package:eswm/utils/device.dart';
import '../../models/cuti.dart';

class LeaveForm extends StatefulWidget {
  String screen;
  Cuti? data;

  LeaveForm({Key? key, required this.screen, this.data}) : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  late StreamSubscription<bool> keyboardVisibility;
  final _formKey = GlobalKey<FormState>();
  final Devices _device = Devices();

  List<Map<String, dynamic>> jenisCuti = [
    {"id": 1, "name": "Cuti Kecemasan"},
    {"id": 1, "name": "Cuti Sakit"},
    {"id": 1, "name": "Cuti Terancang"},
  ];

  final TextEditingController _jenisCuti = TextEditingController();
  final TextEditingController _tarikhMula = TextEditingController();
  final TextEditingController _tarikhTamat = TextEditingController();
  final TextEditingController _lampiran = TextEditingController();
  final TextEditingController _catatan = TextEditingController();

  bool _show = true;
  Color textFieldFillColor = textFormFieldFillColor;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  bool _lampiranVisibility = true;
  bool _lampiranDetailsVisibility = false;

  getData() {
    // ignore: unnecessary_null_comparison
    if (widget.screen == "2") {
      //from leave list
      setState(() {
        textFieldFillColor = Colors.grey.shade300;
        focusBorderColor = Colors.grey.shade300;
        enableBorderWithTextColor = Colors.grey.shade300;

        if ((widget.data!.idStatus == 4 || widget.data!.idStatus == 3) &&
            widget.data!.lampiran == "") {
          _lampiranVisibility = false;
          _lampiranDetailsVisibility = false;
        } else if (widget.data!.idStatus != 2) {
          _lampiranVisibility = false;
          _lampiranDetailsVisibility = true;
        }

        if (widget.data!.jenisCuti != "") {
          _jenisCuti.text = widget.data!.jenisCuti;
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
    super.initState();

    keyboardVisibility =
        KeyboardVisibilityController().onChange.listen((isVisible) {
      if (isVisible) {
        setState(() {
          _show = false;
        });
      } else {
        setState(() {
          _show = true;
        });
      }
    });

    getData();
  }

  @override
  void dispose() {
    keyboardVisibility.cancel();
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
      child: Scaffold(
        bottomSheet: _showBottomSheet(),
        body: Container(
          margin: const EdgeInsets.all(7),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Text(
                      "Lengkapkan maklumat di bawah:",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  //Jenis Cuti
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: _device.screenWidth(context),
                      child: TextFormField(
                        controller: _jenisCuti,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: textFieldFillColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: borderSideWidth,
                              color: focusBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadiusCircular,
                            ),
                          ),
                          enabledBorder: _jenisCuti.text != ''
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
                          labelText: 'Pilih Jenis Cuti',
                          labelStyle: TextStyle(
                            color: labelTextColor,
                            fontWeight: labelFontWeight,
                          ),
                          contentPadding: const EdgeInsets.all(8),
                          suffixIcon: InkWell(
                            onTap: () {
                              if (widget.screen == "2") {
                              } else {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    context: context,
                                    builder: (builder) {
                                      return SizedBox(
                                        height: 350,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 25,
                                                left: 25,
                                                bottom: 15,
                                              ),
                                              child: Text(
                                                "Jenis Cuti",
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: jenisCuti.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _jenisCuti.text =
                                                              jenisCuti[index]
                                                                  ["name"];
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 25,
                                                            vertical: 20),
                                                        height: 35,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              jenisCuti[index]
                                                                  ["name"],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Divider(
                                                              color: grey500,
                                                              thickness: 1,
                                                              //indent: 8,
                                                              endIndent: 8,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }
                            },
                            child: const Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Tarikh Mula & Tarikh Tamat
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: _device.screenWidth(context) * 0.45,
                        child: TextFormField(
                          controller: _tarikhMula,
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
                            enabledBorder: _tarikhMula.text != ''
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
                            labelText: 'Tarikh Mula',
                            labelStyle: TextStyle(
                              color: labelTextColor,
                              fontWeight: labelFontWeight,
                            ),
                            contentPadding: const EdgeInsets.only(left: 8),
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
                                    child: InkWell(
                                      onTap: () async {
                                        if (widget.screen != "2") {
                                          DateTime? getStartDate =
                                              await datePicker(context);
                                          if (getStartDate != null) {
                                            setState(() {
                                              _tarikhMula.text =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(getStartDate);
                                            });
                                          }
                                        }
                                      },
                                      child: Icon(
                                        Icons.date_range,
                                        size: 30,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: _device.screenWidth(context) * 0.45,
                        child: TextFormField(
                          controller: _tarikhTamat,
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
                            enabledBorder: _tarikhTamat.text != ''
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
                            labelText: 'Tarikh Tamat',
                            labelStyle: TextStyle(
                              color: labelTextColor,
                              fontWeight: labelFontWeight,
                            ),
                            contentPadding: const EdgeInsets.only(left: 8),
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
                                    child: InkWell(
                                      onTap: () async {
                                        if (widget.screen != "2") {
                                          DateTime? getEndDate =
                                              await datePicker(context);
                                          if (getEndDate != null) {
                                            setState(() {
                                              _tarikhTamat.text =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(getEndDate);
                                            });
                                          }
                                        }
                                      },
                                      child: Icon(
                                        Icons.date_range,
                                        size: 30,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Lampiran

                  if (_lampiranVisibility)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        bottom: 5,
                      ),
                      child: SizedBox(
                        width: _device.screenWidth(context),
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.cloud_upload,
                            size: 28,
                          ),
                          label: const Text(
                            "Muat Naik Lampiran",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade800,
                            padding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 5.0,
                          ),
                        ),
                      ),
                    ),
                  if (_lampiranVisibility)
                    Text(
                      "*Maksimum 500kb.Format fail .jpeg & .png sahaja",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: grey500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                  //Detail Lampiran
                  if (_lampiranDetailsVisibility)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Container(
                        margin: const EdgeInsets.all(5),
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
                    ),

                  //Catatan
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      width: _device.screenWidth(context),
                      height: 90,
                      child: TextFormField(
                        controller: _catatan,
                        maxLines: 5,
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
                          alignLabelWithHint: true,
                          labelText: 'Catatan',
                          labelStyle: TextStyle(
                            color: labelTextColor,
                            fontWeight: labelFontWeight,
                          ),
                          contentPadding: const EdgeInsets.all(15),
                        ),
                        enabled: (widget.screen == "2") ? false : true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _showBottomSheet() {
    if (_show && widget.screen != "2") {
      return BottomSheet(
        backgroundColor: Colors.white,
        elevation: 50,
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 90,
            width: double.infinity,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    strokeWidth: 5,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5.0,
                fixedSize: const Size(300, 50),
              ),
              child: const Text(
                "Hantar",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      );
    }

    return null;
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
