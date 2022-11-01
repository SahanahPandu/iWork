import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';

//import files
import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/cuti.dart';
import '../../providers/jenis_cuti_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/buttons/ecuti_submit_button.dart';
import '../../widgets/buttons/upload_files_button.dart';

class LeaveForm extends StatefulWidget {
  final String screen;
  final Cuti? data;

  const LeaveForm({Key? key, required this.screen, this.data})
      : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  // ignore: prefer_final_fields
  ExpandableController _expandController =
      ExpandableController(initialExpanded: true);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _jenisCuti = TextEditingController();
  final TextEditingController _tarikhMula = TextEditingController();
  final TextEditingController _tarikhTamat = TextEditingController();
  final TextEditingController _catatan = TextEditingController();
  final TextEditingController _statusPenyelia = TextEditingController();
  final TextEditingController _maklumbalasPenyelia = TextEditingController();
  final FocusNode _catatanFocusNode = FocusNode();

  Color textFieldFillColor = Colors.white;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  bool _lampiranVisibility = true;
  bool _lampiranDetailsVisibility = false;
  double spaceHeight = 15;
  String jenisCuti = "";
  bool buttonVisibility = true;
  int iconCondition = 1;
  int borderCondition = 1;
  String formTitle = "Lengkapkan maklumat di bawah:";
  Color svRemarksBorder = enabledBorderWithText;
  String lampiran = "";
  String leaveDate = "";
  int totalJenisCuti = 0;

  loadData() {
    // ignore: unnecessary_null_comparison
    if (widget.screen == "2") {
      //from leave list
      setState(() {
        formTitle = "Butiran permohonan E-Cuti: ";
        iconCondition = 2; //to disable click
        _statusPenyelia.text = widget.data!.status;
        textFieldFillColor = textFormFieldFillColor;

        //control expandable container
        //if from Status = 2 (Diluluskan Tanpa Lampiran) - only the container will default expand
        if (widget.data?.idStatus != 2) {
          _expandController = ExpandableController(initialExpanded: false);
        } else if (widget.data?.idStatus == 2) {
          _expandController = ExpandableController(initialExpanded: true);
        }
        ////////////////////////////////////////////////////////////////////

        //to control Lampiran button / details and also button visibility
        int status = widget.data!.idStatus;

        if (status == 2) {
          //Diluluskan tanpa lampiran
          buttonVisibility = true;
        } else {
          if ((status == 3 || status == 4) && widget.data!.lampiran == "") {
            //if status = 3 (Diluluskan) or status = 4 (Ditolak) and lampiran is null
            //hide the lampiran section
            buttonVisibility = false;
            _lampiranVisibility = false;
            _lampiranDetailsVisibility = false;
          } else {
            // if status = 1 or other than 2/3/4 and have lampiran
            //hide the lampitan button and display lampiran details only
            buttonVisibility = false;
            _lampiranVisibility = false;
            _lampiranDetailsVisibility = true;
          }
        }
        ///////////////////////////////////////////////////////////////////

        // pass value from leave list
        widget.data!.jenisCuti != ""
            ? _jenisCuti.text = widget.data!.jenisCuti
            : null;

        widget.data!.tarikhMula != ""
            ? _tarikhMula.text = widget.data!.tarikhMula
            : null;

        widget.data!.tarikhTamat != ""
            ? _tarikhTamat.text = widget.data!.tarikhTamat
            : null;

        widget.data!.lampiran != "" ? lampiran = widget.data!.lampiran : null;

        widget.data!.catatan != ""
            ? _catatan.text = widget.data!.catatan
            : null;

        if (widget.data!.maklumbalasSV != "") {
          _maklumbalasPenyelia.text = widget.data!.maklumbalasSV;
        } else {
          _maklumbalasPenyelia.text = "-";
          svRemarksBorder = enabledBorderWithoutText;
        }
      });
    } else {
      _expandController.expanded = true;
    }
  }

  getTotalData() {
    JenisCutiApi.getJenisCutiData(context).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          totalJenisCuti = value.length;
        });
      }
    });
  }

  clearForm() {
    _formKey.currentState!.reset();
    _tarikhMula.clear();
    _tarikhTamat.clear();
    _lampiranVisibility = true;
    _lampiranDetailsVisibility = false;
    _catatan.clear();
    _jenisCuti.clear();
    lampiran = "";
    setState(() {});
  }

  updateLampiran(String fileName) {
    if (fileName != "") {
      setState(() {
        lampiran = fileName;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    getTotalData();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibility(
      onChanged: (bool keyboardVisible) {
        if (keyboardVisible) {
          setState(() {
            buttonVisibility = false;
          });
        } else {
          setState(() {
            buttonVisibility = true;
          });
        }
      },
      child: KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onVerticalDragDown,
        ],
        child: GestureDetector(
          onTap: () {
            if (widget.data?.idStatus == null || widget.data?.idStatus == 2) {
              // only applicable for new form or leave status 2 - Diluluskan Tanpa Lampiran
              setState(() {
                buttonVisibility = true;
              });
            }
          },
          onVerticalDragDown: (details) {
            if (widget.data?.idStatus == null || widget.data?.idStatus == 2) {
              setState(() {
                buttonVisibility = true;
              });
            }
          },
          child: ExpandableNotifier(
            controller: _expandController,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.screen == "2")
                            const SizedBox(
                              height: 24,
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formTitle,
                                style: const TextStyle(
                                  color: Color(0xff8A92A6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (widget.screen == "2")
                                //expand button
                                ExpandableButton(
                                  child: InkWell(
                                      onTap: () {
                                        _expandController.toggle();
                                        setState(() {});
                                      },
                                      child: expandButton()),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            borderRadius: userRole == 100
                                ? BorderRadius.circular(borderRadiusCircular)
                                : null,
                            onTap: () {
                              if (iconCondition == 1) {
                                showListOfLeaveType();
                              }
                            },
                            child: TextFormField(
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff2B2B2B),
                                fontWeight: FontWeight.w400,
                              ),
                              controller: _jenisCuti,
                              readOnly: true,
                              enabled: false,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: textFieldFillColor,
                                contentPadding: userRole == 100
                                    ? const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20)
                                    : const EdgeInsets.all(8),
                                hintText: 'Jenis Cuti',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: labelTextColor,
                                  fontWeight: textFormFieldLabelFontWeight,
                                ),
                                suffixIcon: iconCondition == 1
                                    ? const Icon(
                                        Icons.expand_more,
                                        size: 20,
                                        color: Color(0xff2B2B2B),
                                      )
                                    : null,
                                label: const Text('Jenis Cuti'),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: labelTextColor,
                                  fontWeight: textFormFieldLabelFontWeight,
                                ),
                                errorStyle: const TextStyle(height: 0),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: borderSideWidth,
                                      color: Colors.red),
                                  borderRadius: BorderRadius.circular(
                                      borderRadiusCircular),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: borderSideWidth,
                                    color: _jenisCuti.text != '' &&
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
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }

                                return null;
                              },
                            ),
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
                                      String fullDate =
                                          DateFormat("dd MMMM yyyy", "ms")
                                              .format(getStartDate);
                                      String actualDate = "";

                                      if (leaveDate == "") {
                                        //belum pilih tarikh akhir
                                        actualDate = fullDate;
                                      } else {
                                        //dah pilih tarikh akhir
                                        if (leaveDate == fullDate) {
                                          // if Tarikh Mula sama dengan Tarikh Akhir
                                          actualDate = leaveDate;
                                        } else {
                                          actualDate = "$fullDate - $leaveDate";
                                        }
                                      }

                                      setState(() {
                                        _tarikhMula.text =
                                            DateFormat("dd/MM/yyyy")
                                                .format(getStartDate);
                                        leaveDate = actualDate;
                                      });
                                    }
                                  }
                                },
                                child: SizedBox(
                                  width: Sizes().screenWidth(context) * 0.42,
                                  child: TextFormField(
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff2B2B2B),
                                      fontWeight: FontWeight.w400,
                                    ),
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
                                        fontWeight:
                                            textFormFieldLabelFontWeight,
                                      ),
                                      label: const Text('Tarikh Mula'),
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: labelTextColor,
                                        fontWeight:
                                            textFormFieldLabelFontWeight,
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
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
                                      ),
                                      errorStyle: const TextStyle(height: 0),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: borderSideWidth,
                                            color: Colors.red),
                                        borderRadius: BorderRadius.circular(
                                            borderRadiusCircular),
                                      ),
                                      suffixIcon: iconCondition == 1
                                          ? IntrinsicHeight(
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 6),
                                                    child: Icon(
                                                      CustomIcon
                                                          .scheduleOutline,
                                                      size: 16,
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : null,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              //tarikh akhir
                              InkWell(
                                onTap: () async {
                                  if (widget.screen != "2") {
                                    DateTime? getEndDate =
                                        await datePicker(context);
                                    if (getEndDate != null) {
                                      String fullDate =
                                          DateFormat("dd MMMM yyyy", "ms")
                                              .format(getEndDate);
                                      String actualDate = "";

                                      if (leaveDate == "") {
                                        //belum pilih Tarikh Mula
                                        actualDate = fullDate;
                                      } else {
                                        //dah pilih tarikh mula

                                        if (leaveDate == fullDate) {
                                          //if Tarikh Mula sama dengan Tarikh Akhir

                                          actualDate = leaveDate;
                                        } else {
                                          actualDate = "$leaveDate - $fullDate";
                                        }
                                      }

                                      setState(() {
                                        _tarikhTamat.text =
                                            DateFormat("dd/MM/yyyy")
                                                .format(getEndDate);
                                        leaveDate = actualDate;
                                      });
                                    }
                                  }
                                },
                                child: SizedBox(
                                  width: Sizes().screenWidth(context) * 0.42,
                                  child: TextFormField(
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff2B2B2B),
                                      fontWeight: FontWeight.w400,
                                    ),
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
                                      hintText: 'Tarikh Akhir',
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: labelTextColor,
                                        fontWeight:
                                            textFormFieldLabelFontWeight,
                                      ),
                                      label: const Text('Tarikh Akhir'),
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: labelTextColor,
                                        fontWeight:
                                            textFormFieldLabelFontWeight,
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
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
                                      ),
                                      errorStyle: const TextStyle(height: 0),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: borderSideWidth,
                                            color: Colors.red),
                                        borderRadius: BorderRadius.circular(
                                            borderRadiusCircular),
                                      ),
                                      suffixIcon: iconCondition == 1
                                          ? IntrinsicHeight(
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
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 6),
                                                    child: const Icon(
                                                      CustomIcon
                                                          .scheduleOutline,
                                                      size: 16,
                                                      color: Color(0xff2B2B2B),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : null,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Lampiran
                          Expandable(
                            collapsed: Container(width: 0),
                            expanded: expandableContainer(),
                          ),

                          //Supervisor sections
                          if (widget.screen == "2") supervisorSection(),

                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //button

                if (buttonVisibility)
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
                            child: EcutiSubmitButton(
                              formKey: _formKey,
                              data: leaveDate,
                              clearForm: clearForm,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget expandableContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Lampiran
        SizedBox(
          height: spaceHeight,
        ),
        if (_lampiranVisibility)
          SizedBox(
            width: Sizes().screenWidth(context),
            child: UploadFilesButton(
              lampiranName: lampiran,
              updateLampiran: updateLampiran,
            ),
          ),

        //Detail Lampiran
        if (_lampiranDetailsVisibility)
          Container(
            width: Sizes().screenWidth(context),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              lampiran,
              style: TextStyle(
                fontSize: 16,
                color: blackCustom,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),

        SizedBox(
          height: spaceHeight,
        ),

        //Catatan
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextFormField(
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xff2B2B2B),
              fontWeight: FontWeight.w400,
            ),
            controller: _catatan,
            minLines: 1,
            maxLines: 5,
            enabled: true,
            cursorColor: green,
            focusNode: _catatanFocusNode,
            onTap: () {
              FocusScope.of(context).requestFocus(_catatanFocusNode);
              setState(() {
                buttonVisibility = false;
              });
            },
            textInputAction: TextInputAction.done,
            //set bottom right button on keyboard to "Done" instead of go to next line
            decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFillColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: borderSideWidth,
                    color: focusBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(borderRadiusCircular),
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
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: borderSideWidth,
                    color: enabledBorderWithoutText,
                  ),
                  borderRadius: BorderRadius.circular(borderRadiusCircular),
                ),
                alignLabelWithHint: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                label: const Text("Catatan"),
                labelStyle: TextStyle(
                  fontSize: 15,
                  color: labelTextColor,
                  fontWeight: textFormFieldLabelFontWeight,
                )),
          ),
        ),
      ],
    );
  }

  Widget expandButton() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff3269F8),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        _expandController.expanded
            ? Icons.arrow_drop_up
            : Icons.arrow_drop_down,
        size: 20,
        color: Colors.white,
      ),
    );
  }

  Widget supervisorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        const Divider(
          thickness: 1,
          color: Color(0xffE5E5E5),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          "Pengesahan dari Penyelia: ",
          style: TextStyle(
            fontSize: 15,
            color: blackCustom,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        //status permohonan
        TextFormField(
          style: TextStyle(
            fontSize: 15,
            color: blackCustom,
            fontWeight: FontWeight.w400,
          ),
          controller: _statusPenyelia,
          readOnly: true,
          enabled: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: textFieldFillColor,
            contentPadding: userRole == 100
                ? const EdgeInsets.symmetric(vertical: 15, horizontal: 20)
                : const EdgeInsets.all(8),
            label: const Text("Status Permohonan"),
            labelStyle: TextStyle(
              fontSize: 15,
              color: labelTextColor,
              fontWeight: textFormFieldLabelFontWeight,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: borderSideWidth,
                color: enabledBorderWithoutText,
              ),
              borderRadius: BorderRadius.circular(borderRadiusCircular),
            ),
          ),
        ),

        const SizedBox(
          height: 24,
        ),
        //Maklumbalas penyelia
        TextFormField(
          style: TextStyle(
            fontSize: 15,
            color: blackCustom,
            fontWeight: FontWeight.w400,
          ),
          controller: _maklumbalasPenyelia,
          readOnly: true,
          enabled: false,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
            filled: true,
            fillColor: textFieldFillColor,
            contentPadding: userRole == 100
                ? const EdgeInsets.symmetric(vertical: 15, horizontal: 20)
                : const EdgeInsets.all(8),
            label: const Text("Maklumbalas Penyelia"),
            labelStyle: TextStyle(
              fontSize: 15,
              color: labelTextColor,
              fontWeight: textFormFieldLabelFontWeight,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: borderSideWidth,
                color: enabledBorderWithoutText,
              ),
              borderRadius: BorderRadius.circular(borderRadiusCircular),
            ),
          ),
        ),
      ],
    );
  }

  Widget? showListOfLeaveType() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        constraints: userRole == 100
            ? (Orientations().isLandscape(context)
                ? const BoxConstraints(maxWidth: 500, maxHeight: 400)
                : const BoxConstraints(
                    maxWidth: 500,
                    minHeight: 200,
                    maxHeight: 450,
                  ))
            : null,
        context: context,
        builder: (builder) {
          return SizedBox(
            height: userRole == 100
                ? null
                : MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xff969696),
                  indent: 170,
                  endIndent: 170,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 25,
                    top: 25,
                    right: 25,
                    bottom: 8,
                  ),
                  child: Text(
                    "${totalJenisCuti.toString()} Jenis Cuti",
                    style: const TextStyle(
                      color: Color(0xff969696),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xffE5E5E5),
                  indent: 25,
                  endIndent: 25,
                ),
                FutureBuilder<List>(
                  future: JenisCutiApi.getJenisCutiData(context),
                  builder: (context, snapshot) {
                    final dataFuture = snapshot.data;

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Some error occured!"),
                          );
                        } else {
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: userRole == 100
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)
                                  : const EdgeInsets.all(6),
                              child: ListView.builder(
                                physics: userRole == 100
                                    ? const BouncingScrollPhysics()
                                    : const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: dataFuture!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _jenisCuti.text =
                                            dataFuture[index].jenisCuti;

                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: userRole == 100
                                          ? null
                                          : const EdgeInsets.symmetric(
                                              vertical: 5),
                                      padding: userRole == 100
                                          ? const EdgeInsets.symmetric(
                                              vertical: 23, horizontal: 5)
                                          : const EdgeInsets.all(6),
                                      child: Text(
                                        dataFuture[index].jenisCuti,
                                        style: const TextStyle(
                                          color: Color(0xff2B2B2B),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    }
                  },
                ),
              ],
            ),
          );
        });
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
