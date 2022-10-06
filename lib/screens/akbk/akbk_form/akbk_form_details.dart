import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../config/palette.dart';
import '../../../models/akbk.dart';
import '../../../utils/custom_icon.dart';
import '../../../widgets/modal_bottom_sheet/custom_bottom_sheet_options.dart';

class AkbkFormDetails extends StatefulWidget {
  final int part;
  final Akbk? data;

  const AkbkFormDetails({Key? key, required this.part, this.data})
      : super(key: key);

  @override
  State<AkbkFormDetails> createState() => _AkbkFormDetailsState();
}

class _AkbkFormDetailsState extends State<AkbkFormDetails> {
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
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _remark = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _breakdownTypeController =
      TextEditingController();
  final TextEditingController _odometerConditionController =
      TextEditingController();
  final TextEditingController _odometerReadingController =
      TextEditingController();
  final TextEditingController _odoRemark = TextEditingController();
  final TextEditingController _kodController = TextEditingController();
  final TextEditingController _breakdownRemark = TextEditingController();
  late DateTime pickedDate;
  int _part = 0;

  @override
  void initState() {
    _loadAkbkSection(widget.part);
    _setMainAkbkText();
    super.initState();
  }

  void _setMainAkbkText() {
    if (widget.data != null) {
      setState(() {
        if (widget.data!.appliedBy != "") {
          _appliedByController.text = widget.data!.appliedBy;
        } else {
          _appliedByController.text = widget.data!.laluan;
        }
        _monthYearController.text = widget.data!.date;
        _currentDateTimeController.text =
            "${widget.data!.date} / ${widget.data!.time}";
        _stateController.text = widget.data!.state;
        _districtController.text = widget.data!.district;
        _serviceAreaController.text = widget.data!.serviceArea;
        _repairStationController.text = widget.data!.repairStation;
        _vehicleNoController.text = widget.data!.vehicleNo;
        _vehicleModelController.text = widget.data!.vehicleModel;
        _vehicleTypeController.text = widget.data!.vehicleType;
        _driverController.text = widget.data!.driverName;
        _locationController.text = widget.data!.location;
        _dateTimeController.text = widget.data!.dateTime;
        _remark.text = widget.data!.remark;
        _odometerReadingController.text = widget.data!.odoReading;
        _unitController.text = widget.data!.unitMeasure;
        _odometerConditionController.text = widget.data!.odoCondition;
        _odoRemark.text = widget.data!.remarkOdo;
        _breakdownTypeController.text = widget.data!.breakdownType;
        _kodController.text = widget.data!.kod;
        _breakdownRemark.text = widget.data!.remarkBreakdown;
      });
    } else {
      setState(() {
        _appliedByController.text = "Muhammad Zamzuri Bin Khairuddin M...";
        _monthYearController.text =
            DateFormat("MMMM / yyyy", 'ms').format(DateTime.now());
        _currentDateTimeController.text =
            DateFormat("yyyy-MM-dd / hh:mm:ss", "ms").format(DateTime.now());
      });
    }
  }

  int _loadAkbkSection(int section) {
    return _part = section;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _getSectionWidget(context, _part),
    ]);
  }

  Padding _getMainSection() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          _buildInactiveTextField(_appliedByController, "Nama"),
          const SizedBox(height: 20),
          _buildInactiveTextField(_monthYearController, "Bulan / Tahun"),
          const SizedBox(height: 20),
          _buildInactiveTextField(_currentDateTimeController, "Tarikh / Masa"),
        ]));
  }

  Widget _getOperationSection() {
    if (widget.data == null) {
      return Column(children: [
        Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      ['Negeri Sembilan', 'Melaka', 'Johor (S)', 'Johor(N)'],
                      0.4,
                      _stateController,
                      title: "Pilih Negeri");
                },
                child: _buildInactiveTextDropdown(_stateController, "Negeri"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                      0.4,
                      _districtController,
                      title: "Pilih Daerah");
                },
                child:
                    _buildInactiveTextDropdown(_districtController, "Daerah"))),
        Padding(
            padding: const EdgeInsets.all(15),
            child: _buildActiveTextForm(_serviceAreaController,
                TextInputType.multiline, 1, "Kawasan Servis")),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      ['Port Dickson', 'Rembau', 'Seremban', 'Senawang'],
                      0.4,
                      _repairStationController,
                      title: "Pilih Stesen Kerja Pembaikan");
                },
                child: _buildInactiveTextDropdown(
                    _repairStationController, "Stesen Kerja Pembaikan"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      ['BLS2321', 'RFD5274', 'BDF3221', 'ERD6346'],
                      0.4,
                      _vehicleNoController,
                      title: "Pilih No. Pendaftaran Kenderaan");
                },
                child: _buildInactiveTextDropdown(
                    _vehicleNoController, "No. Pendaftaran Kenderaan"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      [
                        'Hicom',
                        'Mitsubishi Fuso',
                        'Mitsubishi Fuso',
                        'Mitsubishi Fuso'
                      ],
                      0.4,
                      _vehicleModelController,
                      title: "Pilih Modal Kenderaan");
                },
                child: _buildInactiveTextDropdown(
                    _vehicleModelController, "Model Kenderaan"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      ['1.3cc', '1.5cc', '1.8cc', '2.0cc'],
                      0.4,
                      _vehicleTypeController,
                      title: "Pilih Jenis Kenderaan");
                },
                child: _buildInactiveTextDropdown(
                    _vehicleTypeController, "Jenis Kenderaan"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      ['Ahmad', 'Suhaimi', 'Jalal', 'Jalil'],
                      0.4,
                      _driverController,
                      title: "Pilih Nama Pemandu");
                },
                child: _buildInactiveTextDropdown(
                    _driverController, "Nama Pemandu"))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: _buildActiveTextForm(_locationController,
              TextInputType.multiline, 1, "Lokasi Kejadian"),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  _showDateTime(context, _dateTimeController);
                },
                child: _buildInactiveTextDropdown(
                    _dateTimeController, "Masa & Tarikh Kejadian", false))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: _buildActiveTextForm(
              _remark, TextInputType.multiline, 10, "Catatan"),
        )
      ]);
    } else {
      return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            _buildInactiveTextField(_stateController, "Negeri"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_districtController, "Daerah"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_serviceAreaController, "Kawasan Servis"),
            const SizedBox(height: 20),
            _buildInactiveTextField(
                _repairStationController, "Stesen Kerja Pembaikan"),
            const SizedBox(height: 20),
            _buildInactiveTextField(
                _vehicleNoController, "No. Pendaftaran Kenderaan"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_vehicleModelController, "Model Kenderaan"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_vehicleTypeController, "Jenis Kenderaan"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_driverController, "Nama Pemandu"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_locationController, "Lokasi Kejadian"),
            const SizedBox(height: 20),
            _buildInactiveTextField(
                _dateTimeController, "Masa & Tarikh Kejadian"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_remark, "Catatan")
          ]));
    }
  }

  Widget _getOdometerSection() {
    if (widget.data == null) {
      return Column(children: [
        Padding(
            padding: const EdgeInsets.all(15),
            child: _buildActiveTextForm(
                _odometerReadingController,
                TextInputType.multiline,
                1,
                "Bacaan Odometer semasa Breakdown")),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context, ['km', 'hours'], 0.3, _unitController,
                      title: "Pilih Unit Ukuran");
                },
                child: _buildInactiveTextDropdown(
                    _unitController, "Unit Ukuran"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      ['Baik', 'Ok', 'Tidak Baik', 'Rosak'],
                      0.4,
                      _odometerConditionController,
                      title: "Pilih Keadaan Odomoter");
                },
                child: _buildInactiveTextDropdown(
                    _odometerConditionController, "Keadaan Odometer"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: _buildActiveTextForm(
                _odoRemark, TextInputType.multiline, 10, "Catatan"))
      ]);
    } else {
      return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            _buildInactiveTextField(
                _odometerReadingController, "Bacaan Odometer semasa Breakdown"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_unitController, "Unit Ukuran"),
            const SizedBox(height: 20),
            _buildInactiveTextField(
                _odometerConditionController, "Keadaan Odometer"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_odoRemark, "Catatan")
          ]));
    }
  }

  Widget _getBreakdownSection() {
    if (widget.data == null) {
      return Column(children: [
        Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      [
                        'Auto-Transmisi',
                        'Brek',
                        'Elektrik',
                        'Enjin',
                        'Hidraulik',
                        'Lain-lain',
                        'Manu-Gearbox/Clutch',
                        'Puspakom',
                        'Service and Grease',
                        'Suspensi',
                        'Welding',
                      ],
                      0.5,
                      _breakdownTypeController,
                      title: "Pilih Jenis Kerosakan");
                },
                child: _buildInactiveTextDropdown(
                    _breakdownTypeController, "Jenis Kerosakan"))),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  showBottomSheetOptions(
                      context,
                      [
                        'Kerosakan Kenderaan',
                        'Penyelenggaraan Kenderaan',
                        'Kerosakan Tayar'
                      ],
                      0.4,
                      _kodController,
                      title: "Pilih Kod");
                },
                child: _buildInactiveTextDropdown(_kodController, "Kod"))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: _buildActiveTextForm(_breakdownRemark, TextInputType.multiline,
              10, "Catatan (jika rosak)"),
        )
      ]);
    } else {
      return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            _buildInactiveTextField(
                _breakdownTypeController, "Jenis Kerosakan"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_kodController, "Kod"),
            const SizedBox(height: 20),
            _buildInactiveTextField(_breakdownRemark, "Catatan"),
            const SizedBox(height: 10)
          ]));
    }
  }

  Widget _getSectionWidget(BuildContext context, int section) {
    switch (section) {
      case 1:
        return _getMainSection();
      case 2:
        return _getOperationSection();
      case 3:
        return _getOdometerSection();
      case 4:
        return _getBreakdownSection();
    }
    return Container();
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
            contentPadding: const EdgeInsets.all(15),
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
            )));
  }

  TextFormField _buildInactiveTextDropdown(
      TextEditingController controller, String label,
      [bool? defaultIcon = true]) {
    return TextFormField(
        controller: controller,
        readOnly: true,
        enabled: false,
        style: TextStyle(color: blackCustom, fontSize: 15),
        decoration: InputDecoration(
            filled: true,
            fillColor: white,
            contentPadding: const EdgeInsets.all(15),
            suffixIcon: defaultIcon == true
                ? Icon(
                    CustomIcon.dropdown,
                    size: 16,
                    color: blackCustom,
                  )
                : Icon(
                    CustomIcon.scheduleOutline,
                    size: 16,
                    color: blackCustom,
                  ),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 14,
              color: labelColor,
              fontWeight: FontWeight.w300,
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: controller.text != "" ? greenCustom : borderTextColor,
              ),
              borderRadius: BorderRadius.circular(4),
            )));
  }

  TextFormField _buildActiveTextForm(TextEditingController controller,
      TextInputType type, int max, String label) {
    return TextFormField(
        cursorColor: greenCustom,
        textInputAction: TextInputAction.done,
        cursorHeight: 20,
        cursorWidth: 1.2,
        keyboardType: type,
        minLines: 1,
        maxLines: max,
        style: TextStyle(color: blackCustom, fontSize: 15),
        decoration: InputDecoration(
            filled: true,
            fillColor: white,
            focusColor: greenCustom,
            contentPadding: const EdgeInsets.all(15),
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 14,
              color: labelColor,
              fontWeight: FontWeight.w300,
            ),
            border: const OutlineInputBorder(),
            /*focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: green)),*/
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greenCustom, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: controller.text != "" ? greenCustom : borderTextColor,
              ),
              borderRadius: BorderRadius.circular(4),
            )));
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
                  onSurface: Colors.black45),
              dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              )),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                primary: darkGreen,
              ))),
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
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                          primary: Colors.green,
                          onBackground: Colors.green,
                          onPrimary: Colors.white),
                      dialogTheme: DialogTheme(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                      textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                        primary: darkGreen,
                      ))),
                  child: child!,
                ));
          },
          initialTime: TimeOfDay.now(),
          cancelText: "BATAL",
          helpText: "PILIH MASA",
          confirmText: "OK",
        ).then((time) {
          if (time != null) {
            setState(() {
              _dateTimeController.text =
                  '${time.format(context)}, ${DateFormat("dd/MM/yyyy").format(pickedDate)} ';
            });
          }
        });
      }
    });
  }
}
