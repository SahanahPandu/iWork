import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/reports.dart';
import '../../../../utils/custom_icon.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../widgets/alert/alert_dialog.dart';
import '../../../../widgets/alert/lottie_alert_dialog.dart';
import '../../../../widgets/modal_bottom_sheet/acceptance_options.dart';
import 'report_approval_detail.dart';

class ReportApprovalMain extends StatefulWidget {
  final Reports data;

  const ReportApprovalMain({Key? key, required this.data}) : super(key: key);

  @override
  State<ReportApprovalMain> createState() => _ReportApprovalMainState();
}

class _ReportApprovalMainState extends State<ReportApprovalMain> {
  final ExpandableController _reportController =
      ExpandableController(initialExpanded: false);
  final TextEditingController _laluan = TextEditingController();
  final TextEditingController _vehicleNo = TextEditingController();
  final TextEditingController _rStatus = TextEditingController();
  final TextEditingController _unitUkur = TextEditingController();
  final TextEditingController _odometer = TextEditingController();
  final TextEditingController _kerosakan = TextEditingController();
  final TextEditingController _startTime = TextEditingController();
  final TextEditingController _endTime = TextEditingController();
  final TextEditingController _svStatus = TextEditingController();
  final TextEditingController _svFeedback = TextEditingController();
  final TextEditingController _baStatus = TextEditingController();
  final TextEditingController _baFeedback = TextEditingController();
  final verticalPad10 = const EdgeInsets.symmetric(vertical: 10);
  List reportStatusList = ['Diterima', 'Ditolak'];
  bool buttonVisibility = true;
  int condition = 0;
  Color iconColor = grey500;
  String startHourMinute = "";
  Duration startInitialTime = const Duration();
  String endHourMinute = "";
  Duration endInitialTime = const Duration();

  @override
  void initState() {
    iconColor = grey500;
    _loadReportStatus(widget.data.idStatus, widget.data.jenisHalangan);
    _setMainReportText();
    _setSvFeedbackText();
    _setBaFeedbackText();
    super.initState();
  }

  void _setMainReportText() {
    if (widget.data.namaLaluan != "") {
      setState(() {
        _laluan.text = widget.data.namaLaluan;
      });
    }
    if (widget.data.noKenderaan != "") {
      setState(() {
        _vehicleNo.text = widget.data.noKenderaan;
      });
    }
  }

  void _setSvFeedbackText() {
    if (widget.data.statusPenyelia != "") {
      setState(() {
        _svStatus.text = widget.data.statusPenyelia;
      });
    }
    if (widget.data.maklumbalasPenyelia != "") {
      setState(() {
        _svFeedback.text = widget.data.maklumbalasPenyelia;
      });
    } else {
      _svFeedback.text = "-";
    }
  }

  void _setBaFeedbackText() {
    if (widget.data.statusBA != "") {
      setState(() {
        _baStatus.text = widget.data.statusBA;
      });
    }
    if (widget.data.maklumbalasBA != "") {
      setState(() {
        _baFeedback.text = widget.data.maklumbalasBA;
      });
    } else {
      _baFeedback.text = "-";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: barShadowColor,
                  offset: const Offset(0, 3),
                  blurRadius: 8,
                )
              ]),
              child: AppBar(
                backgroundColor: white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon:
                      Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
                ),
                title: Center(
                  child: Text(
                    'Laporan ${widget.data.id}',
                    style: TextStyle(
                      fontSize: 15,
                      color: blackCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                actions: const [
                  SizedBox(width: 50),
                ],
              ),
            )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ExpandableNotifier(
            controller: _reportController,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ExpandableButton(
                      child: InkWell(
                        highlightColor: white,
                        onTap: () {
                          _reportController.toggle();
                          _reportController.expanded
                              ? setState(() {
                                  iconColor = green;
                                })
                              : setState(() {
                                  iconColor = grey500;
                                });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Butiran maklumat laporan:",
                                style: TextStyle(
                                    color: blackCustom,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                            Icon(
                              _reportController.expanded
                                  ? CustomIcon.expand
                                  : CustomIcon.collapse,
                              size: 16,
                              color: activeColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildTextForm(_laluan, "Laluan"),
                  _buildTextForm(_vehicleNo, "No Kenderaan"),
                  ScrollOnExpand(
                    scrollOnCollapse: false,
                    scrollOnExpand: true,
                    child: Expandable(
                      collapsed: Container(),
                      expanded: ReportApprovalDetail(
                          data: widget.data, reportStatus: condition),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 0.5),
                  _buildReportSections(context, condition),
                ],
              ),
            ),
          ),
        ),
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
                      Size(Sizes().screenWidth(context), 41)),
                  backgroundColor: MaterialStateProperty.all(green)),
              child: Text('Sahkan',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w700)),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(context, confirmation,
                          "Sahkan borang laporan ini?", cancel, "Sahkan");
                    }).then((actionText) {
                  if (actionText == "Sahkan") {
                    Navigator.pop(context);
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

  RichText _textBuilder() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Borang laporan ini telah berjaya disahkan oleh anda",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: greyCustom,
                height: 1.5)));
  }

  Widget _buildReportSections(BuildContext context, int condition) {
    switch (condition) {
      case 1:
        return _buildReportAcceptanceColumn(context, "Maklumbalas kepada PRA:");
      case 2:
        return Column(
          children: [
            _buildReportAcceptanceColumn(context, "Maklumbalas kepada PRA:"),
            const SizedBox(height: 15),
            const Divider(height: 0.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReportAkbkMainColumn(context),
                const SizedBox(height: 15),
                const Divider(height: 0.5),
                _buildReportAkbkSubColumn(context),
              ],
            )
          ],
        );
      case 3:
        return Column(
          children: [
            _buildReportAcceptanceColumn(context, "Maklumbalas kepada PRA:"),
            const SizedBox(height: 15),
            const Divider(height: 0.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReportAkbkMainColumn(context),
                const SizedBox(height: 15),
                const Divider(height: 0.5),
                _buildReportAkbkTyreSubColumn(context)
              ],
            )
          ],
        );
      case 4:
      case 5:
      case 6:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text("Tindakan dari Penyelia:",
                  style: TextStyle(
                      color: blackCustom,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
            ),
            _buildTextForm(_svStatus, "Status"),
            _buildTextForm(_svFeedback, "Maklumbalas Penyelia", true),
          ],
        );
      case 7:
      case 8:
      case 9:
        return _buildRescheduleForm(context);
      case 13:
      case 14:
      case 15:
        return _buildReportAcceptanceColumn(
            context, "Maklumbalas kepada Penyelia:");
      case 16:
      case 17:
      case 18:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text("Tindakan dari BA:",
                  style: TextStyle(
                      color: blackCustom,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
            ),
            _buildTextForm(_baStatus, "Status"),
            _buildTextForm(_baFeedback, "Maklumbalas Penyelia", true),
          ],
        );
      default:
        Container();
    }
    return Container();
  }

  Padding _buildTextForm(TextEditingController textController, String label,
      [bool? flex = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: flex! ? 10 : 1,
        controller: textController,
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
      ),
    );
  }

  Column _buildRescheduleForm(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text("Lengkapkan maklumat penjadualan semula di bawah:",
            style: TextStyle(
                color: blackCustom, fontSize: 15, fontWeight: FontWeight.w400)),
      ),
      Padding(
        padding: verticalPad10,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            showAcceptanceOptions(context, reportStatusList, 0.3, _kerosakan);
          },
          child: _buildInactiveTextField(_kerosakan, "Pilih Tarikh"),
        ),
      ),
      Padding(
        padding: verticalPad10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Sizes().screenWidth(context) * 0.41,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  _showTimer(context, _startTime);
                },
                child: _buildInactiveTextField(
                    _startTime, "Mula", CustomIcon.timerOutline),
              ),
            ),
            SizedBox(
              width: Sizes().screenWidth(context) * 0.42,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  _showTimer(context, _endTime);
                },
                child: _buildInactiveTextField(
                    _endTime, "Tamat", CustomIcon.timerOutline),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: verticalPad10,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            showAcceptanceOptions(context, reportStatusList, 0.3, _kerosakan);
          },
          child: _buildInactiveTextField(_kerosakan, "Pilih Kenderaan"),
        ),
      ),
      Padding(
        padding: verticalPad10,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            showAcceptanceOptions(context, reportStatusList, 0.3, _kerosakan);
          },
          child: _buildInactiveTextField(_kerosakan, "Pilih Pekerja"),
        ),
      ),
      Padding(
        padding: verticalPad10,
        child: _buildActiveTextField(TextInputType.multiline, "Catatan", 1, 10),
      ),
    ]);
  }

  Future<dynamic> _showTimer(
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
            height: Sizes().screenHeight(context) * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SizedBox(
                height: 150,
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: timeController == _startTime
                      ? (_startTime.text != ""
                          ? startInitialTime
                          : const Duration(hours: 0, minutes: 0))
                      : (_endTime.text != ""
                          ? endInitialTime
                          : _startTime.text != ""
                              ? startInitialTime
                              : const Duration(hours: 0, minutes: 0)),
                  onTimerDurationChanged: (newTime) {
                    setState(() {
                      timeController == _startTime
                          ? startInitialTime = newTime
                          : endInitialTime = newTime;
                      timeController == _startTime
                          ? startHourMinute = newTime.toString()
                          : endHourMinute = newTime.toString();
                      timeController == _startTime
                          ? timeController.text =
                              '${getStartSelectedHour()}:${getStartSelectedMinute()}'
                          : timeController.text =
                              '${getEndSelectedHour()}:${getEndSelectedMinute()}';
                    });
                  },
                ),
              ),
            ),
          );
        });
  }

  String getStartSelectedHour() {
    return startHourMinute.split(":")[0];
  }

  String getStartSelectedMinute() {
    return startHourMinute.split(":")[1];
  }

  String getEndSelectedHour() {
    return endHourMinute.split(":")[0];
  }

  String getEndSelectedMinute() {
    return endHourMinute.split(":")[1];
  }

  Column _buildReportAkbkTyreSubColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: verticalPad10,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showAcceptanceOptions(
                  context, reportStatusList, 0.25, _kerosakan);
            },
            child: _buildInactiveTextField(_kerosakan, "Sila Pilih Saiz Tayar"),
          ),
        ),
        Padding(
          padding: verticalPad10,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showAcceptanceOptions(
                  context, reportStatusList, 0.25, _kerosakan);
            },
            child:
                _buildInactiveTextField(_kerosakan, "Sila Pilih Lokasi Tayar"),
          ),
        ),
        Padding(
          padding: verticalPad10,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showAcceptanceOptions(
                  context, reportStatusList, 0.25, _kerosakan);
            },
            child: _buildInactiveTextField(_kerosakan, "Sila Pilih Isu"),
          ),
        ),
        Padding(
          padding: verticalPad10,
          child: _buildActiveTextField(
              TextInputType.multiline, "Lain-lain Isu", 1, 10),
        ),
      ],
    );
  }

  Column _buildReportAkbkSubColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: verticalPad10,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showAcceptanceOptions(
                  context, reportStatusList, 0.25, _kerosakan);
            },
            child: _buildInactiveTextField(_kerosakan, "Jenis-jenis Kerosakan"),
          ),
        ),
        Padding(
            padding: verticalPad10,
            child: _buildActiveTextField(TextInputType.number, "Kod")),
        Padding(
          padding: verticalPad10,
          child:
              _buildActiveTextField(TextInputType.multiline, "Catatan", 1, 10),
        ),
        Padding(
          padding: verticalPad10,
          child:
              _buildActiveTextField(TextInputType.multiline, "Tindakan", 1, 10),
        ),
      ],
    );
  }

  Column _buildReportAkbkMainColumn(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text("Lengkapkan borang AKBK di bawah untuk pengesahan BA:",
              style: TextStyle(
                  color: blackCustom,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
        ),
        Padding(
            padding: verticalPad10,
            child: _buildActiveTextField(
                TextInputType.number, "Bacaan Odometer semasa breakdown")),
        Padding(
          padding: verticalPad10,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showAcceptanceOptions(context, reportStatusList, 0.3, _unitUkur);
            },
            child: _buildInactiveTextField(_unitUkur, "Unit Ukuran"),
          ),
        ),
        Padding(
          padding: verticalPad10,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showAcceptanceOptions(context, reportStatusList, 0.3, _odometer);
            },
            child: _buildInactiveTextField(_odometer, "Keadaan Odometer"),
          ),
        ),
        Padding(
          padding: verticalPad10,
          child:
              _buildActiveTextField(TextInputType.multiline, "Catatan", 1, 10),
        ),
      ],
    );
  }

  TextFormField _buildActiveTextField(TextInputType type, String label,
      [int? minLines = 1, int? maxLines = 1]) {
    return TextFormField(
      cursorColor: green,
      cursorHeight: 18,
      keyboardType: type,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(color: blackCustom, fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        focusColor: green,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: labelColor,
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
            color: borderTextColor,
          ),
          borderRadius: BorderRadius.circular(4),
          //gapPadding: 6.0,
        ),
      ),
    );
  }

  Column _buildReportAcceptanceColumn(BuildContext context, String feedBackTo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(feedBackTo,
              style: TextStyle(
                  color: blackCustom,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showAcceptanceOptions(context, reportStatusList, 0.3, _rStatus);
            },
            child: _buildInactiveTextField(_rStatus, "Pilih Status"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildActiveTextField(
              TextInputType.multiline, "Isi maklumbalas di ruang ini", 1, 10),
        )
      ],
    );
  }

  TextFormField _buildInactiveTextField(
      TextEditingController controller, String label,
      [IconData? icon = CustomIcon.dropdown]) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: false,
      style: TextStyle(color: blackCustom, fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        fillColor: white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        suffixIcon: Icon(
          icon,
          size: 16,
          color: black87,
        ),
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
          //gapPadding: 6.0,
        ),
      ),
    );
  }

  void _loadReportStatus(int rptStatus, String rptType) {
    switch (rptStatus) {
      //Baharu
      case 1:
        switch (userRole) {
          // sv -> need to accept/reject laluan/cuaca case from pra.
          case 300:
          case 400:
          case 500:
            switch (rptType) {
              // display: report by pra, sv -> acceptance option & feedback
              case "Cuaca":
              case "Laluan":
                condition = 1;
                break;
              // display: report by pra, sv -> acceptance option, feedback & akbk
              case "Kerosakan Kenderaan":
                condition = 2;
                break;
              // display: report by pra, sv -> acceptance option, feedback & akbk tayar
              case "Kerosakan Tayar":
                condition = 3;
                break;
            }
            break;
        }
        break;
      //Diterima sv
      case 2:
        switch (userRole) {
          // sv -> wait eo/ba to accept/reject case
          case 300:
            switch (rptType) {
              // display: report by pra, feedback by sv
              case "Cuaca":
              case "Laluan":
                condition = 4;
                break;
              // display: report by pra, feedback & akbk by sv
              case "Kerosakan Kenderaan":
                condition = 5;
                break;
              // display: report by pra, feedback & akbk tayar by sv
              case "Kerosakan Tayar":
                condition = 6;
                break;
            }
            break;
          // eo/ba -> need to accept/reject case from sv.
          case 400:
          case 500:
            switch (rptType) {
              // display: report by pra, feedback by sv, eo/ba -> acceptance option & feedback
              case "Cuaca":
              case "Laluan":
                condition = 13;
                break;
              // display: report by pra, feedback & akbk by sv, eo/ba -> acceptance option & feedback
              case "Kerosakan Kenderaan":
                condition = 14;
                break;
              // display: report by pra, feedback & akbk tayar by sv, eo/ba -> acceptance option & feedback
              case "Kerosakan Tayar":
                condition = 15;
                break;
            }
            break;
        }
        break;
      //Disahkan ba
      case 4:
        switch (userRole) {
          // sv -> need to reschedule case
          case 300:
            switch (rptType) {
              // display: report by pra, feedback by sv, feedback by eo/ba, reschedule form
              case "Cuaca":
              case "Laluan":
                condition = 7;
                break;
              // display: report by pra, feedback & akbk by sv, feedback by eo/ba, reschedule form
              case "Kerosakan Kenderaan":
                condition = 8;
                break;
              // display: report by pra, feedback & akbk tayar by sv, feedback by eo/ba, reschedule form
              case "Kerosakan Tayar":
                condition = 9;
                break;
            }
            break;
          // eo/ba -> display report, wait sv to reschedule
          case 400:
          case 500:
            switch (rptType) {
              // display: report by pra, feedback by sv, feedback by eo/ba
              case "Cuaca":
              case "Laluan":
                condition = 16;
                break;
              // display: report by pra, feedback & akbk by sv, feedback by eo/ba
              case "Kerosakan Kenderaan":
                condition = 17;
                break;
              // display: report by pra, feedback & akbk tayar by sv, feedback by eo/ba
              case "Kerosakan Tayar":
                condition = 18;
                break;
            }
            break;
        }
        break;
      //Selesai
      case 6:
        switch (userRole) {
          // sv -> Penjadualan semula selesai and laporan ditutup
          case 300:
          case 400:
          case 500:
            switch (rptType) {
              // display: report by pra, feedback by sv, feedback by eo/ba, reschedule report
              case "Cuaca":
              case "Laluan":
                condition = 10;
                break;
              // display: report by pra, feedback & akbk by sv, feedback by eo/ba, reschedule report
              case "Kerosakan Kenderaan":
                condition = 11;
                break;
              // display: report by pra, feedback & akbk tayar by sv, feedback by eo/ba, reschedule report
              case "Kerosakan Tayar":
                condition = 12;
                break;
            }
            break;
        }
        break;
      default:
        condition = 0;
    }
  }
}
