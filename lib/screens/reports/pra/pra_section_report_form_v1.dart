import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

//import files
import '../../../config/config.dart';
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/reports.dart';
import '../../../utils/device/sizes.dart';
import '../../../widgets/buttons/upload_image_button.dart';
import '../../list_of_obstacles/list_of_obstacles.dart';
import '../../list_of_park/list_of_parks.dart';
import '../../list_of_road/list_of_road_text_form_field.dart';

class PraSectionReportForm extends StatefulWidget {
  final String screen;
  final Reports? data;
  final Function? updateButton;

  const PraSectionReportForm(
      {Key? key, required this.screen, this.data, this.updateButton})
      : super(key: key);

  @override
  State<PraSectionReportForm> createState() => _PraSectionReportFormState();
}

class _PraSectionReportFormState extends State<PraSectionReportForm> {
  final TextEditingController _catatan = TextEditingController();
  final FocusNode _catatanFocusNode = FocusNode();

  Color textFieldFillColor = Colors.white;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  int iconCondition = 1;
  int borderCondition = 1;
  String namaTaman = "";
  String namaJalan = "";
  String jenisHalangan = "";
  String subLaluan = "";
  File? gambarLampiran;
  String formTitleText = "Sila isikan laporan di bawah";
  double spacingHeight = userRole == 100 ? 25 : 20;

  loadData() {
    if (widget.screen == "4") {
      //from report list
      setState(() {
        formTitleText = "Butiran Laporan";
        textFieldFillColor = textFormFieldFillColor;
        focusBorderColor = Colors.grey.shade300;
        enableBorderWithTextColor = Colors.grey.shade300;
        iconCondition = 0;
        borderCondition = 0;

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
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onVerticalDragDown,
      ],
      child: GestureDetector(
        onTap: () {
          widget.updateButton!(true);
        },
        onVerticalDragDown: (DragDownDetails details) {
          widget.updateButton!(true);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formTitleText,
              style: const TextStyle(
                color: Color(0xff2B2B2B),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: userRole == 100 ? 30 : 15,
            ),
            //Sub Laluan
            // ListOfSubRoutes(
            //   hintText: 'Sub Laluan',
            //   fontSize: 15,
            //   fillColor: textFieldFillColor,
            //   iconCondition: iconCondition,
            //   data: subLaluan,
            // ),
            SizedBox(
              height: spacingHeight,
            ),
            //Taman
            ListOfParks(
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
              text: 'Jenis Halangan',
              hintText: 'Halangan',
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
              minLines: 1,
              maxLines: 3,
              enabled: (widget.screen == "4") ? false : true,
              cursorColor: green,
              focusNode: _catatanFocusNode,
              onTap: () {
                FocusScope.of(context).requestFocus(_catatanFocusNode);
                widget.updateButton!(false);
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
        ),
      ),
    );
  }
}
