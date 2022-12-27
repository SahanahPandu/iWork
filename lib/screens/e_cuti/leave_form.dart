// ignore_for_file: avoid_print

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:keyboard_visibility_pro/keyboard_visibility_pro.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/ecuti/ecuti_details.dart';
import '../../providers/jenis_cuti_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/buttons/ecuti_submit_button.dart';
import '../../widgets/buttons/upload_files_button.dart';

class LeaveForm extends StatefulWidget {
  final String screen;
  final EcutiDetails? data;

  const LeaveForm({Key? key, required this.screen, this.data})
      : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  // ignore: prefer_final_fields
  final eCutiButttonKey = GlobalKey<EcutiSubmitButtonState>();
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
  double spaceHeight = 24;
  String jenisCuti = "";
  late int idJenisCuti = 0;
  String tarikhMula = "";
  String tarikhTamat = "";
  bool buttonVisibility = true;
  int iconCondition = 1;
  int borderCondition = 1;
  String formTitle = "Lengkapkan maklumat di bawah:";
  Color svRemarksBorder = enabledBorderWithText;
  String lampiran = "";
  String pathLampiran = "";
  bool errorVisibility = false;
  var theDate = <String, dynamic>{
    "tarikhMula": "",
    "tarikhTamat": "",
  };

  int totalJenisCuti = 0;

  loadData() {
    // ignore: unnecessary_null_comparison
    if (widget.screen == "2") {
      //from leave list
      setState(() {
        formTitle = "Butiran permohonan E-Cuti: ";
        iconCondition = 2; //to disable click
        _statusPenyelia.text = widget.data!.status!.name;
        textFieldFillColor = textFormFieldFillColor;

        ////////////////////////////////////////////////////////////////////

        //to control Lampiran button / details and also button visibility
        int leaveType = widget.data!.leaveType!.id;
        dynamic uploadFile = widget.data!.uploadFile;

        //check leave type 1/2 , 1- Cuti Kecemasan , 2 - Cuti Sakit
        if ((leaveType == 1 || leaveType == 2) &&
            (uploadFile == null || uploadFile.fileName == "")) {
          //Scenario , Cuti Kecemasan and Cuti Sakit without attachment
          //show button to upload attachment and submit button

          buttonVisibility = true;
          _lampiranVisibility = true;

          //control expandable container
          //if from Status = 2 (Diluluskan Tanpa Lampiran) - only the container will default expand
          _expandController = ExpandableController(initialExpanded: true);
        } else {
          _expandController = ExpandableController(initialExpanded: false);
          if (uploadFile != null && uploadFile.fileName != "") {
            //Scenario, Leave form with Attachment
            //to displau filename
            buttonVisibility = false;
            _lampiranVisibility = false;
            _lampiranDetailsVisibility = true;
          } else {
            //Scenario, Leave form without Attachment
            // to removed lampiran section

            buttonVisibility = false;
            _lampiranVisibility = false;
            _lampiranDetailsVisibility = false;
          }
        }

        ///////////////////////////////////////////////////////////////////

        // pass value from leave list
        widget.data!.leaveType?.name != ""
            ? _jenisCuti.text = widget.data!.leaveType!.name
            : null;

        //load date data
        //tarikh mula
        if (widget.data?.dateFrom != "") {
          String theConvStartDate = DateFormat("dd/MM/yyyy")
              .format(DateTime.parse(widget.data!.dateFrom));
          _tarikhMula.text = theConvStartDate;
        }

        //tarikh tamat
        if (widget.data?.dateTo != "") {
          String theConvEndDate = DateFormat("dd/MM/yyyy")
              .format(DateTime.parse(widget.data!.dateTo));
          _tarikhTamat.text = theConvEndDate;
        }

        //attachment
        (widget.data!.uploadFile?.fileName != "" &&
                widget.data!.uploadFile?.fileName != null)
            ? lampiran = widget.data!.uploadFile!.fileName
            : null;

        //catatan
        (widget.data!.remarks != "" && widget.data!.remarks != null)
            ? _catatan.text = widget.data!.remarks!
            : null;

        //catatan supervisor
        if (widget.data!.remarksBySv != "" &&
            widget.data!.remarksBySv != null) {
          _maklumbalasPenyelia.text = widget.data!.remarksBySv!;
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

  Future<String> postNewLeave() async {
    String status = "";
    //check attachment
    String? attachment;
    String? attachmentPath;

    if (lampiran != "") {
      attachment = lampiran;
    } else {
      attachment = null;
    }

    if (pathLampiran != "") {
      attachmentPath = pathLampiran;
    } else {
      attachmentPath = null;
    }

    //post data to the database
    FormData formData = FormData.fromMap({
      "leave_type_id": idJenisCuti,
      "date_leave_from": tarikhMula,
      "date_leave_to": tarikhTamat,
      "leave_attachment": attachment != null
          ? await MultipartFile.fromFile(
              attachmentPath!,
              filename: attachment,
              contentType: MediaType(
                "image,application",
                "png,jpeg,pdf",
              ),
            )
          : attachment,
      "remarks": _catatan.text,
    });

    try {
      Response response = await Dio().post(
        '$theBase/attendance/ecuti/new',
        data: formData,
        options: Options(headers: {
          "authorization": "Bearer ${userInfo[1]}",
          "Content-Type": "multipart/form-data",
        }),
      );

      if (response.statusCode == 200) {
        status = "successed";
        clearForm();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        //Case:The date already taken
        status = "failed";
        _tarikhMula.clear();
        _tarikhTamat.clear();

        setState(() {
          errorVisibility = true;
        });
      }
      // print(e);
    }

    return status;
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
    pathLampiran = "";
    setState(() {});
  }

  updateLampiran(String fileName, String filePath) {
    if (fileName != "" && filePath != "") {
      setState(() {
        lampiran = fileName;
        pathLampiran = filePath;
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
            if (widget.data?.status!.code == null ||
                widget.data?.status!.code == "EDTL") {
              // only applicable for new form or leave status 2 - Diluluskan Tanpa Lampiran
              setState(() {
                buttonVisibility = true;
              });
            }
          },
          onVerticalDragDown: (details) {
            if (widget.data?.status!.code == null ||
                widget.data?.status!.code == "EDTL") {
              setState(() {
                buttonVisibility = true;
              });
            }
          },
          child: ExpandableNotifier(
            controller: _expandController,
            child: Stack(
              children: [
                ScrollConfiguration(
                  behavior: const MaterialScrollBehavior()
                      .copyWith(overscroll: false),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                                    child: GestureDetector(
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
                            GestureDetector(
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
                                  contentPadding: const EdgeInsets.all(8),
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
                                          ? enabledBorderWithText
                                          : enabledBorderWithoutText,
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
                            //leave date is use to pass to lotte prompt
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //tarikh mula
                                GestureDetector(
                                  onTap: () async {
                                    if (widget.screen != "2") {
                                      DateTime? getStartDate =
                                          await datePicker(context);
                                      if (getStartDate != null) {
                                        setState(() {
                                          _tarikhMula.text =
                                              DateFormat("dd/MM/yyyy")
                                                  .format(getStartDate);
                                          tarikhMula = DateFormat("yyyy-MM-dd")
                                              .format(getStartDate);

                                          theDate = <String, dynamic>{
                                            "tarikhMula": tarikhMula,
                                            "tarikhTamat": tarikhTamat,
                                          };
                                        });
                                        eCutiButttonKey.currentState!
                                            .getTheLeaveDate(theDate);
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
                                        contentPadding: const EdgeInsets.all(8),
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
                                                ? enabledBorderWithText
                                                : enabledBorderWithoutText,
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    VerticalDivider(
                                                      color:
                                                          Colors.grey.shade400,
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
                                                        color: Colors
                                                            .grey.shade800,
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
                                GestureDetector(
                                  onTap: () async {
                                    if (widget.screen != "2") {
                                      DateTime? getEndDate =
                                          await datePicker(context);
                                      if (getEndDate != null) {
                                        setState(() {
                                          _tarikhTamat.text =
                                              DateFormat("dd/MM/yyyy")
                                                  .format(getEndDate);
                                          tarikhTamat = DateFormat("yyyy-MM-dd")
                                              .format(getEndDate);

                                          theDate = <String, dynamic>{
                                            "tarikhMula": tarikhMula,
                                            "tarikhTamat": tarikhTamat,
                                          };
                                        });
                                        eCutiButttonKey.currentState!
                                            .getTheLeaveDate(theDate);
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
                                        contentPadding: const EdgeInsets.all(8),
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
                                                ? enabledBorderWithText
                                                : enabledBorderWithoutText,
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    VerticalDivider(
                                                      color:
                                                          Colors.grey.shade400,
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
                                                        color:
                                                            Color(0xff2B2B2B),
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

                            //error message
                            if (errorVisibility) errorMessageSection(),

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
                ),
                //button

                if (buttonVisibility)
                  Positioned(
                    bottom: 0,
                    child: Material(
                      elevation: 50,
                      child: Container(
                        color: Colors.white,
                        width: Sizes().screenWidth(context),
                        height: Sizes().screenHeight(context) * 0.1,
                        child: Center(
                          child: SizedBox(
                            width: Sizes().screenWidth(context) * 0.8,
                            height: Sizes().screenHeight(context) * 0.06,
                            child: EcutiSubmitButton(
                              key: eCutiButttonKey,
                              formKey: _formKey,
                              data: theDate,
                              postData: postNewLeave,
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
            enabled: (widget.screen == "2") ? false : true,
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

  Widget errorMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: 18,
        ),
        Text(
          "*Tarikh telah diambil",
          style: TextStyle(
            fontSize: 15,
            color: Colors.red,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
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
            contentPadding: const EdgeInsets.all(8),
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
            contentPadding: const EdgeInsets.all(8),
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
            height: Sizes().screenHeight(context) * 0.3,
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
                FutureBuilder<List<dynamic>?>(
                  future: JenisCutiApi.getDataJenisCuti(),
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
                          if (dataFuture!.isEmpty) {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(CustomIcon.exclamation,
                                        color: Colors.orange, size: 14),
                                    const SizedBox(width: 10),
                                    Text("Tiada senarai jenis cuti dijumpai",
                                        style: TextStyle(color: grey500)),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.all(6),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: dataFuture.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _jenisCuti.text =
                                              dataFuture[index].name;
                                          idJenisCuti = dataFuture[index].id;

                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(6),
                                        child: Text(
                                          dataFuture[index].name,
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
