import 'dart:io';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

//import files
import '../../../config/config.dart';
import '../../../config/dimen.dart';
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/report/report_details/report_details_info.dart';
import '../../../utils/device/sizes.dart';
import '../../../widgets/buttons/change_image_upload.dart';
import '../../../widgets/buttons/upload_image_button.dart';
import '../../../widgets/image_viewer/image_viewer.dart';
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
  final ReportDetailsInfo? data;
  final int? scMainId;
  final Function? updateButton;

  const PraSectionReportForm({
    Key? key,
    required this.screen,
    this.subLaluanKey,
    this.tamanKey,
    this.jalanKey,
    this.jenisHalanganKey,
    this.data,
    this.scMainId,
    this.updateButton,
  }) : super(key: key);

  @override
  PraSectionReportFormState createState() => PraSectionReportFormState();
}

class PraSectionReportFormState extends State<PraSectionReportForm> {
  final tamanKey = GlobalKey<ListOfParksState>();
  final TextEditingController namaSubLaluan = TextEditingController();
  TextEditingController catatan = TextEditingController();
  final FocusNode _catatanFocusNode = FocusNode();

  Color textFieldFillColor = Colors.white;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  int iconCondition = 1;
  String subLaluan = "";
  int idTaman = 0;
  String namaTaman = "";
  String namaJalan = "";
  String jenisHalangan = "";

  File? gambarLampiran;
  String namaGambar = "";
  String? pathGambar;

  double spacingHeight = userRole == 100 ? 30 : 20;

  getImageName(fileName) {
    setState(() {
      gambarLampiran = fileName;
      namaGambar = basename(fileName.path);
    });
  }

  updateSenaraiTaman([name]) {
    setState(() {
      tamanKey.currentState?.namaTaman.clear();
      subLaluan = name;
    });
  }

  updateShowSenaraiJalan(id, [name]) {
    setState(() {
      idTaman = id;
      namaTaman = name;
    });
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
          screen: widget.screen,
          scMainId: widget.scMainId,
          getSubLaluanName: updateSenaraiTaman,
        ),
        SizedBox(
          height: spacingHeight,
        ),
        //Taman
        ListOfParks(
          key: widget.tamanKey,
          hintText: 'Taman',
          fontSize: 15,
          fillColor: textFieldFillColor,
          iconCondition: iconCondition,
          data: namaTaman,
          screen: widget.screen,
          scMainId: widget.scMainId,
          subRoutesName: subLaluan,
          updateSenaraiJalan: updateShowSenaraiJalan,
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
          screen: widget.screen,
          scMainId: widget.scMainId,
          namaTaman: namaTaman,
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
          screen: widget.screen,
        ),

        SizedBox(
          height: spacingHeight,
        ),
        //Gambar
        if (gambarLampiran == null &&
            (widget.screen == "3" || widget.screen == "7"))
          SizedBox(
            width: Sizes().screenWidth(context),
            child: UploadImageButton(getImageName: getImageName),
          ),
        //Display selected image
        if (gambarLampiran != null || widget.screen == "4")
          Column(
            children: [
              Container(
                width: Sizes().screenWidth(context),
                height: 250,
                decoration: BoxDecoration(
                  border: widget.screen == "4"
                      ? Border.all(
                          color: const Color(0xffDDDFE2),
                        )
                      : null,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                  color: textFieldFillColor,
                ),
                child: gambarLampiran != null
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (_, __, ___) => ImageViewer(
                                  fileName: gambarLampiran!,
                                  type: BoxFit.fitWidth),
                            ),
                          );
                        },
                        child: Hero(
                          tag: "imgTag",
                          child: Container(
                            constraints: BoxConstraints(
                                maxHeight: 280,
                                minWidth: Sizes().screenWidth(context)),
                            padding: const EdgeInsets.all(5),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  gambarLampiran!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      )
                    /* ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        child: Image.file(
                          gambarLampiran!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )*/
                    : pathGambar != null
                        ? /*ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            child: Image.network(
                              pathGambar!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return const Text('Opps');
                              },
                            ),
                          )*/
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (_, __, ___) => ImageViewer(
                                      attachment: pathGambar!,
                                      type: BoxFit.fitWidth),
                                ),
                              );
                            },
                            child: Hero(
                              tag: "imgTag",
                              child: Container(
                                constraints: BoxConstraints(
                                    maxHeight: 280,
                                    minWidth: Sizes().screenWidth(context)),
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      pathGambar!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Text(
                                            'Gambar tidak dapat dimuat turun');
                                      },
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: green,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    )),
                              ),
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
