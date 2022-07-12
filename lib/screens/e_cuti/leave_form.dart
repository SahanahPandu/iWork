import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/palette.dart';
import 'package:eswm/utils/device.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';

class LeaveForm extends StatefulWidget {
  const LeaveForm({Key? key}) : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
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
  final TextEditingController _catatan = TextEditingController();

  bool _show = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: grey200,
      //bottomNavigationBar: _showBottomSheet(),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                        enabledBorder: _jenisCuti.text != ''
                            ? OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(15),
                              )
                            : OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15),
                              ),
                        labelText: 'Pilih Jenis Cuti',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.all(8),
                        suffixIcon: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                context: context,
                                builder: (builder) {
                                  return Container(
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
                                              itemBuilder: (context, index) {
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
                                                                FontWeight.w500,
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
                          border: InputBorder.none,
                          enabledBorder: _tarikhMula.text != ''
                              ? OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(15),
                                )
                              : OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(15),
                                ),

                          labelText: 'Tarikh Mula',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: const EdgeInsets.only(left: 8),
                          // suffix: const IntrinsicHeight(
                          //   child: VerticalDivider(
                          //     color: Colors.black,
                          //     thickness: 1,
                          //     indent: 10,
                          //     endIndent: 10,
                          //     width: 20,
                          //   ),
                          // ),
                          suffixIcon: InkWell(
                            onTap: () async {
                              DateTime? getStartDate =
                                  await datePicker(context);
                              if (getStartDate != null) {
                                setState(() {
                                  _tarikhMula.text = DateFormat("dd/MM/yyyy")
                                      .format(getStartDate);
                                });
                              }
                            },
                            child: Icon(
                              Icons.date_range,
                              size: 30,
                              color: Colors.grey.shade800,
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
                          border: InputBorder.none,
                          enabledBorder: _tarikhTamat.text != ''
                              ? OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(15),
                                )
                              : OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                          labelText: 'Tarikh Tamat',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400,
                          ),
                          contentPadding: const EdgeInsets.only(left: 8),
                          suffixIcon: InkWell(
                            onTap: () async {
                              DateTime? getEndDate = await datePicker(context);
                              if (getEndDate != null) {
                                setState(() {
                                  _tarikhTamat.text = DateFormat("dd/MM/yyyy")
                                      .format(getEndDate);
                                });
                              }
                            },
                            child: Icon(
                              Icons.date_range,
                              size: 30,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //Lampiran
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 5),
                  child: SizedBox(
                    width: _device.screenWidth(context),
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text(
                        "Muat Naik Lampiran",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
                Text(
                  "*Maksimum 500kb.Format fail .jpeg & .png sahaja",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: grey500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                //Catatan
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: _device.screenWidth(context),
                    height: 100,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(10),
                    //   border: Border.all(
                    //     color: Colors.grey.shade400,
                    //     style: BorderStyle.solid,
                    //     width: 1.5,
                    //   ),
                    // ),
                    child: TextFormField(
                      controller: _catatan,
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Catatan',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.all(8),
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

  Widget? _showBottomSheet() {
    if (_show) {
      return BottomSheet(
        enableDrag: true,
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 90,
            width: double.infinity,
            color: Colors.white,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
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
