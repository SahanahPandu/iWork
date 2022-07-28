// ignore_for_file: must_be_immutable

import 'package:eswm/config/config.dart';
import 'package:eswm/models/reports.dart';
import 'package:eswm/screens/list_of_obstacles/lis_of_obstacles.dart';
import 'package:eswm/screens/list_of_road/list_of_road_text_form_field.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/buttons/upload_image_button.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../utils/device.dart';
import '../list_of_park/list_of_parks.dart';

class ReportForm extends StatefulWidget {
  String screen;
  Reports? data;

  ReportForm({Key? key, required this.screen, required this.data})
      : super(key: key);

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final Devices _device = Devices();
  final TextEditingController _catatan = TextEditingController();

  Color textFieldFillColor = textFormFieldFillColor;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;
  int iconCondition = 1;
  String namaTaman = "";
  String namaJalan = "";
  String jenisHalangan = "";

  double spacingHeight = 20;

  loadData() {
    if (widget.screen == "4") {
      //from report list
      setState(() {
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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (userRole == 100) {
      return Scaffold(
        bottomSheet: _showBottomSheet(),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: _device.isLandscape(context)
                ? const EdgeInsets.fromLTRB(100, 80, 100, 150)
                : const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //nama laluan
                Text(
                  "JHBP01-C02",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 30,
                ),
                //no kenderaan
                Row(
                  children: [
                    const Icon(
                      Icons.local_shipping,
                      size: 19,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "No. Kenderaan",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: _device.isLandscape(context) ? 300 : 200,
                    ),
                    Text(
                      "BLW7096",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  color: grey300,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Lengkapkan laporan di bawah :",
                  style: TextStyle(
                    color: black87,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //Taman
                ListOfParks(
                  showSenaraiJalan: null,
                  hintText: 'Jenis Taman',
                  fontSize: 15,
                  borderCondition: 1,
                  // have border
                  fillColor: textFieldFillColor,
                  iconCondition: iconCondition,
                  data: namaTaman,
                ),
                const SizedBox(
                  height: 25,
                ),
                //Jalan
                ListOfRoadTextFormField(
                  text: 'Jenis Jalan',
                  fontSize: 15,
                  fillColor: textFieldFillColor,
                  iconCondition: iconCondition,
                  data: namaJalan,
                ),

                const SizedBox(
                  height: 25,
                ),
                //Jenis Halangan
                ListOfObstacles(
                  text: 'Jenis Halangan',
                  fontSize: 15,
                  fillColor: textFieldFillColor,
                  iconCondition: iconCondition,
                  data: jenisHalangan,
                ),

                const SizedBox(
                  height: 25,
                ),
                //Gambar
                SizedBox(
                  width: _device.screenWidth(context),
                  height: 100,
                  child: const UploadImageButton(),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _catatan,
                  maxLines: 3,
                  enabled: true,
                  cursorColor: green,
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
            ),
          ),
        ),
      );
    }
    return Scaffold(
      bottomSheet: _showBottomSheet(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //nama laluan
              Text(
                "JHBP01-C02",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 15,
              ),
              //no kenderaan
              Row(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    size: 19,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "BLW7096",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey.shade500,
                thickness: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Sila isikan laporan di bawah: ",
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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const UploadImageButton(),
              ),
              SizedBox(
                height: spacingHeight,
              ),
              TextFormField(
                controller: _catatan,
                maxLines: 3,
                enabled: true,
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
          ),
        ),
      ),
    );
  }

  Widget? _showBottomSheet() {
    //if (_show && widget.screen != "2") {
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
              "Hantar Laporan",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
    //}

    //return null;
  }
}
