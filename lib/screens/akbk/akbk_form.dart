import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/date.dart';
import '../../utils/device.dart';
import '../../widgets/alert/alert_dialog.dart';
import '../../widgets/alert/lottie_alert_dialog.dart';
import '../../widgets/modal_bottom_sheet/acceptance_options.dart';

class AkbkForm extends StatefulWidget {
  const AkbkForm({Key? key}) : super(key: key);

  @override
  State<AkbkForm> createState() => _AkbkFormState();
}

class _AkbkFormState extends State<AkbkForm> {
  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _serviceAreaController = TextEditingController();
  final TextEditingController _repairStationController =
      TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  DateTime startInitialDayTime = DateTime(2022);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    "Arahan Kerja Baik Pulih",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: blackCustom,
                        fontSize: 15),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FlexColumnWidth(0.4),
                    1: FlexColumnWidth(0.6),
                  },
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Nama",
                            style: TextStyle(color: grey500, fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Ahmad",
                            style: TextStyle(color: black87, fontSize: 13)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Bulan / Tahun",
                            style: TextStyle(color: grey500, fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("June / 2022",
                            style: TextStyle(color: black87, fontSize: 13)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Tarikh / Masa",
                            style: TextStyle(color: grey500, fontSize: 13)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(Date.getTodayDate(),
                            style: TextStyle(color: black87, fontSize: 13)),
                      ),
                    ]),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(height: 0.6),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Maklumat Operasi",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: blackCustom,
                        fontSize: 15),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Negeri Sembilan', 'Melaka', 'Johor (S)', 'Johor(N)'],
                        0.4,
                        _stateController);
                  },
                  child: _buildInactiveTextForm(_stateController, "Negeri"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _stateController);
                  },
                  child: _buildInactiveTextForm(_districtController, "Daerah"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _serviceAreaController);
                  },
                  child: _buildInactiveTextForm(
                      _serviceAreaController, "Kawasan Servis"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _repairStationController);
                  },
                  child: _buildInactiveTextForm(
                      _repairStationController, "Stesen Kerja Pembaikan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _vehicleNoController);
                  },
                  child: _buildInactiveTextForm(
                      _vehicleNoController, "No. Pendaftaran Kenderaan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(context, ['1.3cc', '1.5cc', '1.8cc'],
                        0.4, _vehicleTypeController);
                  },
                  child: _buildInactiveTextForm(
                      _vehicleTypeController, "Jenis Kenderaan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context, ['Hicom'], 0.4, _vehicleModelController);
                  },
                  child: _buildInactiveTextForm(
                      _vehicleModelController, "Model Kenderaan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Ahmad', 'Suhaimi', 'Jalal', 'Jalil'],
                        0.4,
                        _driverController);
                  },
                  child:
                      _buildInactiveTextForm(_driverController, "Nama Pemandu"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    _showDateTime(context, _dateTimeController);
                  },
                  child: _buildInactiveTextForm(
                      _dateTimeController, "Masa & Tarikh Kejadian"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 10, "Catatan"),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(height: 0.6),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Odometer",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: blackCustom,
                        fontSize: 15),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 1, "Bacaan semasa Breakdown"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(context, ['cm', 'inch', 'm', 'km'],
                        0.4, _driverController);
                  },
                  child:
                      _buildInactiveTextForm(_driverController, "Unit Ukuran"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Baik', 'Ok', 'Tidak Baik', 'Rosak'],
                        0.4,
                        _driverController);
                  },
                  child: _buildInactiveTextForm(
                      _driverController, "Keadaan Odometer"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 10, "Catatan (jika rosak)"),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(height: 0.6),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "AKBK",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: blackCustom,
                        fontSize: 15),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        [
                          'Kerosakan Kenderaan',
                          'Penyelenggaraan Kenderaan',
                          'Kerosakan Tayar'
                        ],
                        0.4,
                        _driverController);
                  },
                  child: _buildInactiveTextForm(
                      _driverController, "Jenis Kerosakan"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(height: 0.6),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Butir-butir Kerosakan/Isu",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: blackCustom,
                        fontSize: 15),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        [
                          'Kerosakan Kenderaan',
                          'Penyelenggaraan Kenderaan',
                          'Kerosakan Tayar'
                        ],
                        0.4,
                        _driverController);
                  },
                  child: _buildInactiveTextForm(
                      _driverController, "Jenis Kerosakan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        [
                          'Kerosakan Kenderaan',
                          'Penyelenggaraan Kenderaan',
                          'Kerosakan Tayar'
                        ],
                        0.4,
                        _driverController);
                  },
                  child: _buildInactiveTextForm(_driverController, "Kod"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 10, "Catatan (jika rosak)"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  blurRadius: 6,
                  spreadRadius: 0.5)
            ],
          ),
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(context, confirmation,
                          "Hantar borang AKBK ini?", cancel, submit);
                    }).then((actionText) {
                  if (actionText == submit) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showLottieAlertDialog(
                              context, _textBuilder(), null);
                        });
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         child: CustomDialog(text: _textBuilder()),
                    //         type: PageTransitionType.fade));
                  }
                });
              },
            ),
          ),
        ));
  }

  TextFormField _buildActiveTextForm(
      TextInputType type, int max, String label) {
    return TextFormField(
      cursorColor: green,
      cursorHeight: 18,
      keyboardType: type,
      minLines: 1,
      maxLines: max,
      style: TextStyle(color: grey700, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        focusColor: green,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        labelText: label,
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
          borderRadius: BorderRadius.circular(borderRadiusCircular),
        ),
      ),
    );
  }

  TextFormField _buildInactiveTextForm(
      TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: false,
      style: TextStyle(color: grey700, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        suffixIcon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 16,
          color: black87,
        ),
        labelText: label,
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
          borderRadius: BorderRadius.circular(4),
          //gapPadding: 6.0,
        ),
      ),
    );
  }

  Future<dynamic> _showDateTime(
      BuildContext context, TextEditingController timeController) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (builder) {
          return Container(
            height: Devices().screenHeight(context) * 0.35,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SizedBox(
                height: 160,
                child: CupertinoDatePicker(
                  minimumDate: DateTime.now().subtract(const Duration(days: 4)),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: _dateTimeController.text != ""
                      ? startInitialDayTime
                      : null,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      startInitialDayTime = newDateTime;
                      _dateTimeController.text = startInitialDayTime.toString();
                    });
                  },
                ),
              ),
            ),
          );
        });
  }

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Borang AKBK anda pada",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5),
            children: <TextSpan>[
              TextSpan(
                  text:
                      " ${DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now())} \n",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, color: green)),
              TextSpan(
                  text: " telah berjaya dihantar kepada pihak mekanik",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom))
            ]));
  }
}
