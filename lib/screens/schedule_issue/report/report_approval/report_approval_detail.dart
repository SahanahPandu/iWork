import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/reports.dart';
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
  final TextEditingController _subLaluan = TextEditingController();
  final TextEditingController _taman = TextEditingController();
  final TextEditingController _jalan = TextEditingController();
  final TextEditingController _reportType = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  bool isAttached = false;

  @override
  void initState() {
    if (widget.data.namaSubLaluan != "" ||
        widget.data.namaTaman != "" ||
        widget.data.namaJalan != "" ||
        widget.data.jenisHalangan != "" ||
        widget.data.catatan != "") {
      setState(() {
        _subLaluan.text = widget.data.namaSubLaluan;
        _taman.text = widget.data.namaTaman;
        _jalan.text = widget.data.namaJalan;
        _reportType.text = widget.data.jenisHalangan;

        if (widget.data.lampiran != "") {
          isAttached = true;
        } else {
          isAttached = false;
        }

        if (widget.data.catatan != "") {
          _remarks.text = widget.data.catatan;
        } else {
          _remarks.text = "-";
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(height: 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "Butiran laporan seperti di bawah:",
            style: TextStyle(
                fontSize: 14, color: grey500, fontWeight: FontWeight.w700),
          ),
        ),
        textFormBuild(_subLaluan, "Sub Laluan"),
        textFormBuild(_taman, "Taman"),
        textFormBuild(_jalan, "Jalan"),
        textFormBuild(_reportType, "Jenis Halangan"),
        isAttached
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
                      constraints: const BoxConstraints(maxHeight: 300),
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
        textFormBuild(_remarks, "Catatan"),
      ]),
    );
  }

  Padding textFormBuild(TextEditingController textController, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: textController == _remarks ? 10 : 1,
        controller: textController,
        readOnly: true,
        enabled: false,
        style: TextStyle(color: grey700, fontSize: 14),
        decoration: InputDecoration(
          filled: true,
          fillColor: grey100,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12,
            color: grey,
            fontWeight: FontWeight.w300,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: grey500,
            ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
        ),
      ),
    );
  }
}
