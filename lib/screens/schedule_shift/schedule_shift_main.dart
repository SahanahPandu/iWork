import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/custom_icon.dart';
import '../../utils/device.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/toast.dart';

class ScheduleShiftMain extends StatefulWidget {
  const ScheduleShiftMain({Key? key}) : super(key: key);

  @override
  State<ScheduleShiftMain> createState() => _ScheduleShiftMainState();
}

class _ScheduleShiftMainState extends State<ScheduleShiftMain> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 1,
          shadowColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CustomIcon.arrowBack,
                color: Colors.grey.shade900, size: 15),
          ),
          title: Center(
            child: Text(
              "Anjakan Jadual",
              style: TextStyle(
                fontSize: 15,
                color: grey800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: const [
            SizedBox(
              width: 50,
            )
          ],
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Text(
                    "Anjakan Jadual",
                    style: TextStyle(
                        color: grey500,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      DateTime? startDate = await showDatePicker(
                        cancelText: "Batal",
                        confirmText: "Ya",
                        helpText: "Pilih Tarikh",
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 1),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                      );
                      if (startDate != null) {
                        setState(() {
                          _startDateController.text =
                              DateFormat("dd/MM/yyyy").format(startDate);
                        });
                      }
                    },
                    child: TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      enabled: false,
                      style: TextStyle(color: grey700, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        suffixIcon: Icon(
                          Icons.calendar_month_rounded,
                          size: 18,
                          color: black87,
                        ),
                        labelText: "Pilih Tarikh Untuk Dianjak",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: grey,
                          fontWeight: FontWeight.w300,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: grey500,
                          ),
                          borderRadius:
                              BorderRadius.circular(borderRadiusCircular),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      DateTime? endDate = await showDatePicker(
                        cancelText: "Batal",
                        confirmText: "Ya",
                        helpText: "Pilih Tarikh",
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 1),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                      );
                      if (endDate != null) {
                        setState(() {
                          _endDateController.text =
                              DateFormat("dd/MM/yyyy").format(endDate);
                        });
                      }
                    },
                    child: TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      enabled: false,
                      style: TextStyle(color: grey700, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        suffixIcon: Icon(
                          Icons.calendar_month_rounded,
                          size: 18,
                          color: black87,
                        ),
                        labelText: "Pilih Tarikh Anjakan",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: grey,
                          fontWeight: FontWeight.w300,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: grey500,
                          ),
                          borderRadius:
                              BorderRadius.circular(borderRadiusCircular),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SizedBox(
                    height: 80,
                    child: TextFormField(
                      cursorColor: green,
                      cursorHeight: 18,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 10,
                      style: TextStyle(color: grey700, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        focusColor: green,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        labelText: "Catatan",
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: grey,
                          fontWeight: FontWeight.w300,
                        ),
                        border: const OutlineInputBorder(),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: green)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: grey500,
                          ),
                          borderRadius:
                              BorderRadius.circular(borderRadiusCircular),
                          //gapPadding: 6.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 6,
                  spreadRadius: 0.5)
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SizedBox(
            height: 45,
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  overlayColor:
                      MaterialStateColor.resolveWith((states) => green800),
                  minimumSize: MaterialStateProperty.all(
                      Size(Devices().screenWidth(context), 41)),
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text('Hantar',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w700)),
              onPressed: () {
                _startDateController.text != ""
                    ? showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showAlertDialog(
                              context,
                              confirmation,
                              "Anjakan akan memberi kesan kepada semua hal berkaitan penjadualan. Anda pasti untuk sahkan Anjakan Jadual untuk tarikh ${_startDateController.text} kepada ${_endDateController.text}?",
                              "Tidak",
                              "Ya, Sahkan");
                        }).then((actionText) {
                        if (actionText == "Sahkan") {
                          Navigator.pop(context);
                        }
                      })
                    : showErrorToast(context,
                        "Sila isikan borang terlebih dahulu sebelum Sahkan");
              },
            ),
          ),
        ));
  }
}
