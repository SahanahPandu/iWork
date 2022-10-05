import 'dart:io';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

//import files
import '../../../config/config.dart';
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/reports.dart';
import '../../../utils/device/sizes.dart';
import '../../../widgets/buttons/change_image_upload.dart';
import '../../../widgets/buttons/upload_image_button.dart';
import '../../list_of_obstacles/list_of_obstacles.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../list_of_road/list_of_road_text_form_field.dart';
import '../../list_of_sub_routes/list_of_sub_routes_text_form_field.dart';

class PraSectionReportForm extends StatefulWidget {
  final String screen;
  final GlobalKey<ListOfSubRoutesTextFormFieldState>? subLaluanKey;
  final GlobalKey<ListOfParksState>? tamanKey;
  final GlobalKey<ListOfRoadTextFormFieldState>? jalanKey;
  final GlobalKey<ListOfObstaclesState>? jenisHalanganKey;
  final Reports? data;
  final Function? updateButton;

  const PraSectionReportForm({
    Key? key,
    required this.screen,
    this.subLaluanKey,
    this.tamanKey,
    this.jalanKey,
    this.jenisHalanganKey,
    this.data,
    this.updateButton,
  }) : super(key: key);

  @override
  PraSectionReportFormState createState() => PraSectionReportFormState();
}

class PraSectionReportFormState extends State<PraSectionReportForm> {
  final TextEditingController namaSubLaluan = TextEditingController();
  final TextEditingController catatan = TextEditingController();
  final FocusNode _catatanFocusNode = FocusNode();

  Color textFieldFillColor = Colors.white;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  int iconCondition = 1;
  String namaTaman = "";
  String namaJalan = "";
  String jenisHalangan = "";
  String subLaluan = "";
  File? gambarLampiran;
  String namaGambar = "";

  double spacingHeight = userRole == 100 ? 25 : 20;

  loadData() {
    if (widget.screen == "4") {
      //from report list
      setState(() {
        textFieldFillColor = textFormFieldFillColor;
        focusBorderColor = Colors.grey.shade300;
        enableBorderWithTextColor = Colors.grey.shade300;
        iconCondition = 0;

        if (widget.data!.namaSubLaluan != "") {
          subLaluan = widget.data!.namaSubLaluan;
        }

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
          catatan.text = widget.data!.catatan;
        }
      });
    }
  }

  getImageName(fileName) {
    setState(() {
      gambarLampiran = fileName;
      namaGambar = basename(fileName.path);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: spacingHeight,
        ),
        //Sub Laluan
        ListOfSubRoutesTextFormField(
          key: widget.subLaluanKey,
          hintText: "Sub-Laluan",
          fontSize: 15,
          fillColor: textFieldFillColor,
          iconCondition: iconCondition,
          data: subLaluan,
        ),
        SizedBox(
          height: spacingHeight,
        ),
        //Taman
        ListOfParks(
          key: widget.tamanKey,
          showSenaraiJalan: null,
          hintText: 'Taman',
          fontSize: 15,
          fillColor: textFieldFillColor,
          iconCondition: iconCondition,
          data: namaTaman,
        ),

        SizedBox(
          height: spacingHeight,
        ),
        //Jalan
        ListOfRoadTextFormField(
          key: widget.jalanKey,
          text: 'Jalan',
          hintText: 'Jalan',
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
          key: widget.jenisHalanganKey,
          text: 'Jenis Halangan',
          hintText: 'Jenis Halangan',
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
            width: Sizes().screenWidth(context),
            child: UploadImageButton(getImageName: getImageName),
          ),
        //Display selected image
        if (gambarLampiran != null || widget.screen == "4")
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  border: widget.screen == "4"
                      ? Border.all(
                          color: const Color(0xffDDDFE2),
                        )
                      : null,
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadiusCircular),
                  ),
                  color: textFieldFillColor,
                ),
                child: gambarLampiran != null
                    ? ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.all(
                            Radius.circular(borderRadiusCircular)),
                        child: Image.file(
                          gambarLampiran!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Text(
                          "Tiada Gambar",
                          style: TextStyle(
                            color: greyCustom,
                          ),
                        ),
                      ),
              ),
              if (widget.screen != "4")
                const SizedBox(
                  height: 10,
                ),
              if (widget.screen != "4")
                Text(
                  namaGambar,
                  style: TextStyle(
                    color: greyCustom,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              if (widget.screen != "4")
                const SizedBox(
                  height: 10,
                ),
              if (widget.screen != "4")
                ChangeImageButton(getImageName: getImageName),
            ],
          ),
        SizedBox(
          height: spacingHeight,
        ),
        //catatan
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextFormField(
            controller: catatan,
            minLines: 1,
            maxLines: 3,
            enabled: (widget.screen == "4") ? false : true,
            cursorColor: green,
            focusNode: _catatanFocusNode,
            onTap: () {
              FocusScope.of(context).requestFocus(_catatanFocusNode);
              widget.updateButton!(false);
            },
            textInputAction: TextInputAction.done,
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
              enabledBorder: catatan.text != ''
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
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: borderSideWidth,
                  color: userRole == 100 ? grey100 : enabledBorderWithoutText,
                ),
                borderRadius: BorderRadius.circular(borderRadiusCircular),
              ),
              alignLabelWithHint: true,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              label: Container(
                color: Colors.white,
                child: const Text("Catatan"),
              ),
              labelStyle: TextStyle(
                fontSize: 15,
                color: labelTextColor,
                fontWeight: textFormFieldLabelFontWeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
