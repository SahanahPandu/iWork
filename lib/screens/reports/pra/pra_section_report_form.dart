// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';

//import files
import 'package:eswm/models/reports.dart';
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../widgets/buttons/upload_image_button.dart';
import '../../list_of_obstacles/lis_of_obstacles.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../list_of_road/list_of_road_text_form_field.dart';

class PraSectionReportForm extends StatefulWidget {
  String screen;
  Reports? data;

  PraSectionReportForm({Key? key, required this.screen, required this.data})
      : super(key: key);

  @override
  State<PraSectionReportForm> createState() => _PraSectionReportFormState();
}

class _PraSectionReportFormState extends State<PraSectionReportForm> {
  final TextEditingController _catatan = TextEditingController();
  late FocusNode? _catatanFocusNode;

  Color textFieldFillColor = textFormFieldFillColor;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  int iconCondition = 1;

  String namaTaman = "";
  String namaJalan = "";
  String jenisHalangan = "";
  File? gambarLampiran;
  String formTitleText = "Sila isikan laporan di bawah";
  double spacingHeight = 20;

  loadData() {
    if (widget.screen == "4") {
      //from report list
      setState(() {
        formTitleText = "Butiran Laporan";
        textFieldFillColor = Colors.grey.shade300;
        focusBorderColor = Colors.grey.shade300;
        enableBorderWithTextColor = Colors.grey.shade300;
        iconCondition = 0;

        if (widget.data!.namaTaman != "") {
          namaTaman = widget.data!.namaTaman;
        }

        if (widget.data!.namaJalan != "") {
          namaJalan = widget.data!.namaJalan;
        }

        if (widget.data!.jenisHalangan != "") {
          jenisHalangan = widget.data!.jenisHalangan;
        }

        if (widget.data!.catatan != "") {
          _catatan.text = widget.data!.catatan;
        }
      });
    }
  }

  getImageName(fileName) {
    setState(() {
      gambarLampiran = fileName;
    });
  }

  @override
  void initState() {
    _catatanFocusNode = FocusNode();
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _catatanFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formTitleText,
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        //Taman
        ListOfParks(
          showSenaraiJalan: null,
          hintText: 'Pilih Nama Taman',
          fontSize: 15,
          borderCondition: 1, // have border
          fillColor: textFieldFillColor,
          iconCondition: iconCondition,
          data: namaTaman,
        ),

        SizedBox(
          height: spacingHeight,
        ),
        //Jalan
        ListOfRoadTextFormField(
          text: 'Pilih Nama Jalan',
          fontSize: 15,
          fillColor: textFieldFillColor,
          iconCondition: iconCondition,
          data: namaJalan,
        ),

        SizedBox(
          height: spacingHeight,
        ),
        //Jenis Halangan
        ListOfObstacles(
          text: 'Pilih Jenis Halangan',
          fontSize: 15,
          fillColor: textFieldFillColor,
          iconCondition: iconCondition,
          data: jenisHalangan,
        ),

        SizedBox(
          height: spacingHeight,
        ),
        //Gambar
        if (gambarLampiran == null && widget.screen == "3")
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: UploadImageButton(getImageName: getImageName),
          ),
        //Display selected image
        if (gambarLampiran != null || widget.screen == "4")
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadiusCircular),
              ),
              color: Colors.lightBlue.shade100,
            ),
            child: gambarLampiran != null
                ? Center(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(1),
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(borderRadiusCircular),
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurStyle: BlurStyle.outer,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(borderRadiusCircular)),
                        child: Image.file(
                          gambarLampiran!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No Image"),
                  ),
          ),
        SizedBox(
          height: spacingHeight,
        ),
        //catatan
        TextFormField(
          controller: _catatan,
          maxLines: 3,
          enabled: true,
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
              borderRadius: BorderRadius.circular(borderRadiusCircular),
            ),
            enabledBorder: _catatan.text != ''
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                      width: borderSideWidth,
                      color: enableBorderWithTextColor,
                    ),
                    borderRadius: BorderRadius.circular(borderRadiusCircular),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide(
                      width: borderSideWidth,
                      color: enabledBorderWithoutText,
                    ),
                    borderRadius: BorderRadius.circular(borderRadiusCircular),
                  ),
            alignLabelWithHint: true,
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
      ],
    );
  }
}
