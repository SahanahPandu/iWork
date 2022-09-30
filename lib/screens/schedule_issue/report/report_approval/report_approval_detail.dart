import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/reports.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../widgets/image_viewer/image_viewer.dart';

class ReportApprovalDetail extends StatefulWidget {
  final Reports data;
  final int reportStatus;

  const ReportApprovalDetail(
      {Key? key, required this.data, required this.reportStatus})
      : super(key: key);

  @override
  State<ReportApprovalDetail> createState() => _ReportApprovalDetailState();
}

class _ReportApprovalDetailState extends State<ReportApprovalDetail> {
  final TextEditingController _laluan = TextEditingController();
  final TextEditingController _vehicleNo = TextEditingController();
  final TextEditingController _subLaluan = TextEditingController();
  final TextEditingController _taman = TextEditingController();
  final TextEditingController _jalan = TextEditingController();
  final TextEditingController _reportType = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _svStatus = TextEditingController();
  final TextEditingController _svFeedback = TextEditingController();
  final TextEditingController _baStatus = TextEditingController();
  final TextEditingController _baFeedback = TextEditingController();

  /*final TextEditingController _odoRead = TextEditingController();
  final TextEditingController _measureUnit = TextEditingController();
  final TextEditingController _odoState = TextEditingController();
  final TextEditingController _odoRemark = TextEditingController();
  final TextEditingController _breakdownType = TextEditingController();
  final TextEditingController _kod = TextEditingController();
  final TextEditingController _bRemark = TextEditingController();
  final TextEditingController _action = TextEditingController();*/

  bool _isAttached = false;
  int _condition = 0;

  @override
  void initState() {
    _getReportStatus(widget.reportStatus);
    _setTextField();
    super.initState();
  }

  void _setTextField() {
    _setMainReportText();

    switch (_condition) {
      case 4:
        _setSvFeedbackText();
        break;
      case 5:
        _setSvFeedbackText();
        _setVehicleAkbkText();
        break;
      case 7:
      case 8:
      case 9:
      case 10:
      case 11:
      case 12:
        _setSvFeedbackText();
        _setBaFeedbackText();
        break;
    }
  }

  void _setVehicleAkbkText() {}

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

  void _setMainReportText() {
    if (widget.data.namaLaluan != "" ||
        widget.data.noKenderaan != "" ||
        widget.data.namaSubLaluan != "" ||
        widget.data.namaTaman != "" ||
        widget.data.namaJalan != "" ||
        widget.data.jenisHalangan != "" ||
        widget.data.catatan != "") {
      setState(() {
        _laluan.text = widget.data.namaLaluan;
        _vehicleNo.text = widget.data.noKenderaan;
        _subLaluan.text = widget.data.namaSubLaluan;
        _taman.text = widget.data.namaTaman;
        _jalan.text = widget.data.namaJalan;
        _reportType.text = widget.data.jenisHalangan;

        if (widget.data.lampiran != "") {
          _isAttached = true;
        } else {
          _isAttached = false;
        }

        if (widget.data.catatan != "") {
          _remarks.text = widget.data.catatan;
        } else {
          _remarks.text = "-";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _buildTextForm(_laluan, "Laluan"),
      _buildTextForm(_vehicleNo, "No Kenderaan"),
      _buildTextForm(_subLaluan, "Sub Laluan"),
      _buildTextForm(_taman, "Taman"),
      _buildTextForm(_jalan, "Jalan"),
      _buildTextForm(_reportType, "Jenis Halangan"),
      _isAttached
          ? Stack(alignment: Alignment.center, children: [
              // textFormBuild(_attachment, "Lampiran", isAttached),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => ImageViewer(
                          attachment: widget.data.lampiran,
                          type: BoxFit.fitWidth),
                    ),
                  );
                },
                child: Hero(
                  tag: "imgTag",
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: 280, minWidth: Sizes().screenWidth(context)),
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.data.lampiran,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: green,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )),
                  ),
                ),
              )
            ])
          : Container(),
      _buildTextForm(_remarks, "Catatan", true),
      _getOtherWidget(context, _condition),
    ]);
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

  int _getReportStatus(int reportStatus) {
    return _condition = reportStatus;
  }

  Widget _getOtherWidget(BuildContext context, int condition) {
    switch (condition) {
      case 7:
      case 8:
      case 9:
      case 10:
      case 11:
      case 12:
        return Column(
          children: [_getSvFeedback(), _getBaFeedback()],
        );
    }
    return Container();
  }

  Column _getBaFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Divider(height: 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "Maklumbalas kepada Penyelia:",
            style: TextStyle(
                color: blackCustom, fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        _buildTextForm(_baStatus, "Status Laporan (BA)"),
        _buildTextForm(_baFeedback, "Maklumbalas BA", true),
      ],
    );
  }

  Column _getSvFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Divider(height: 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "Maklumbalas kepada Pra:",
            style: TextStyle(
                color: blackCustom, fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ),
        _buildTextForm(_svStatus, "Status Laporan"),
        _buildTextForm(_svFeedback, "Maklumbalas Penyelia", true),
      ],
    );
  }
}
