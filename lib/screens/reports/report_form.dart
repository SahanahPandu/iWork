import 'package:eswm/widgets/buttons/upload_image_button.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/font.dart';
import '../../config/palette.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({Key? key}) : super(key: key);

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final TextEditingController _namaTaman = TextEditingController();
  final TextEditingController _namaJalan = TextEditingController();
  final TextEditingController _jenisHalangan = TextEditingController();
  final TextEditingController _catatan = TextEditingController();

  Color textFieldFillColor = textFormFieldFillColor;
  Color focusBorderColor = focusedBorder;
  Color enableBorderWithTextColor = enabledBorderWithText;

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _namaTaman,
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
                    enabledBorder: _namaTaman.text != ''
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
                    labelText: 'Pilih Taman',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: labelTextColor,
                      fontWeight: textFormFieldLabelFontWeight,
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Jalan
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _namaJalan,
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
                    enabledBorder: _namaJalan.text != ''
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
                    labelText: 'Pilih Jalan',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: labelTextColor,
                      fontWeight: textFormFieldLabelFontWeight,
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Jenis Halangan
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: _jenisHalangan,
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
                    enabledBorder: _jenisHalangan.text != ''
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
                    labelText: 'Jenis Halangan',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: labelTextColor,
                      fontWeight: textFormFieldLabelFontWeight,
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              //Gambar
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const UploadImageButton(),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _catatan,
                maxLines: 4,
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
                  labelText: 'Catatan',
                  labelStyle: TextStyle(
                    color: labelTextColor,
                    fontWeight: textFormFieldLabelFontWeight,
                  ),
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
