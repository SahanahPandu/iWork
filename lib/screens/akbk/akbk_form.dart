import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../utils/custom_icon.dart';
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
  final TextEditingController _appliedByController = TextEditingController();
  final TextEditingController _monthYearController = TextEditingController();
  final TextEditingController _currentDateTimeController =
      TextEditingController();
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

  late DateTime pickedDate;

  @override
  void initState() {
    _setMainAkbkText();
    super.initState();
  }

  void _setMainAkbkText() {
    setState(() {
      _appliedByController.text = "Muhammad Zamzuri Bin Khairuddin M...";
      _monthYearController.text =
          DateFormat("MMMM / yyyy", 'ms').format(DateTime.now());
      _currentDateTimeController.text =
          DateFormat("yyyy-MM-dd / hh:mm:ss", "ms").format(DateTime.now());
    });
  }

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
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Text(
                    "Lengkapkan maklumat AKBK:",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: blackCustom,
                        fontSize: 15),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Container(
                        height: 18,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: activeColor),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Arahan Kerja Baik Pulih",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: blackCustom,
                            fontSize: 13),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildInactiveTextField(_appliedByController, "Nama"),
                    const SizedBox(height: 20),
                    _buildInactiveTextField(
                        _monthYearController, "Bulan / Tahun"),
                    const SizedBox(height: 20),
                    _buildInactiveTextField(
                        _currentDateTimeController, "Tarikh / Masa"),
                  ],
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 18,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: activeColor),
                        child: Center(
                          child: Text(
                            "2",
                            style: TextStyle(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Maklumat Operasi",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: blackCustom,
                            fontSize: 13),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Negeri Sembilan', 'Melaka', 'Johor (S)', 'Johor(N)'],
                        0.4,
                        _stateController);
                  },
                  child: _buildInactiveTextDropdown(_stateController, "Negeri"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _stateController);
                  },
                  child:
                      _buildInactiveTextDropdown(_districtController, "Daerah"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _serviceAreaController);
                  },
                  child: _buildInactiveTextDropdown(
                      _serviceAreaController, "Kawasan Servis"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _repairStationController);
                  },
                  child: _buildInactiveTextDropdown(
                      _repairStationController, "Stesen Kerja Pembaikan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                        0.4,
                        _vehicleNoController);
                  },
                  child: _buildInactiveTextDropdown(
                      _vehicleNoController, "No. Pendaftaran Kenderaan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(context, ['1.3cc', '1.5cc', '1.8cc'],
                        0.4, _vehicleTypeController);
                  },
                  child: _buildInactiveTextDropdown(
                      _vehicleTypeController, "Jenis Kenderaan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context, ['Hicom'], 0.4, _vehicleModelController);
                  },
                  child: _buildInactiveTextDropdown(
                      _vehicleModelController, "Model Kenderaan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Ahmad', 'Suhaimi', 'Jalal', 'Jalil'],
                        0.4,
                        _driverController);
                  },
                  child: _buildInactiveTextDropdown(
                      _driverController, "Nama Pemandu"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    _showDateTime(context, _dateTimeController);
                  },
                  child: _buildInactiveTextDropdown(
                      _dateTimeController, "Masa & Tarikh Kejadian"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 10, "Catatan"),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 18,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: activeColor),
                        child: Center(
                          child: Text(
                            "3",
                            style: TextStyle(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Odometer",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: blackCustom,
                            fontSize: 15),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 1, "Bacaan semasa Breakdown"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(context, ['cm', 'inch', 'm', 'km'],
                        0.4, _driverController);
                  },
                  child: _buildInactiveTextDropdown(
                      _driverController, "Unit Ukuran"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showAcceptanceOptions(
                        context,
                        ['Baik', 'Ok', 'Tidak Baik', 'Rosak'],
                        0.4,
                        _driverController);
                  },
                  child: _buildInactiveTextDropdown(
                      _driverController, "Keadaan Odometer"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 10, "Catatan"),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 18,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: activeColor),
                        child: Center(
                          child: Text(
                            "4",
                            style: TextStyle(
                                color: white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Butiran Kerosakan",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: blackCustom,
                            fontSize: 15),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  child: _buildInactiveTextDropdown(
                      _driverController, "Jenis Kerosakan"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  child: _buildInactiveTextDropdown(_driverController, "Kod"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: _buildActiveTextForm(
                    TextInputType.multiline, 10, "Catatan (jika rosak)"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              child: Text('Hantar Borang',
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
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: green)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: green),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: grey500,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  TextFormField _buildInactiveTextField(
      TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: false,
      style: TextStyle(
          color: blackCustom, fontSize: 15, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: labelColor,
          fontWeight: FontWeight.w400,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: borderTextColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  TextFormField _buildInactiveTextDropdown(
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
          CustomIcon.dropdown,
          size: 16,
          color: blackCustom,
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
    return showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black45,
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: darkGreen,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      locale: const Locale('ms'),
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      confirmText: "SETERUSNYA",
    ).then((date) {
      if (date != null) {
        setState(() {
          pickedDate = date;
        });
        showTimePicker(
          context: context,
          builder: (context, child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.green,
                    onBackground: Colors.green,
                    onPrimary: Colors.white,
                  ),
                  dialogTheme: DialogTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: darkGreen,
                    ),
                  ),
                ),
                child: child!,
              ),
            );
          },
          initialTime: TimeOfDay.now(),
          cancelText: "BATAL",
          helpText: "PILIH MASA",
          confirmText: "OK",
        ).then((time) {
          if (time != null) {
            setState(() {
              _dateTimeController.text =
                  '${DateFormat("dd/MM/yyyy").format(pickedDate)} ${time.format(context)}';
            });
          }
        });
      }
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
                      "\n ${DateFormat("dd MMMM yyyy", 'ms').format(DateTime.now())}",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400, color: green)),
              TextSpan(
                  text: " telah berjaya dihantar \nkepada pihak mekanik.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: greyCustom))
            ]));
  }
}
