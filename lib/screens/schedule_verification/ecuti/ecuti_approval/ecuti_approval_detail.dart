import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//import files
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../config/resource.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../../widgets/image_viewer/image_viewer.dart';
import '../../../../widgets/pdf_viewer/pdf_viewer.dart';

class EcutiApprovalDetail extends StatefulWidget {
  final Cuti data;

  const EcutiApprovalDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<EcutiApprovalDetail> createState() => _EcutiApprovalDetailState();
}

class _EcutiApprovalDetailState extends State<EcutiApprovalDetail> {
  final TextEditingController _appliedBy = TextEditingController();
  final TextEditingController _designation = TextEditingController();
  final TextEditingController _leaveType = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  bool imgAttached = false;
  bool pdfAttached = false;
  String remotePDFpath = "";
  String urlFormat = "";
  String filename = "";
  Color textColor = blackCustom;

  @override
  void initState() {
    _setLeaveDataText();
    super.initState();
  }

  void _setLeaveDataText() {
    if (widget.data.pemohon != "" ||
        widget.data.jenisCuti != "" ||
        widget.data.tarikhMula != "") {
      setState(() {
        _appliedBy.text = widget.data.pemohon;
        _leaveType.text = widget.data.jenisCuti;
        _startDate.text = widget.data.tarikhMula;
        _designation.text = widget.data.designation;
        if (widget.data.tarikhTamat != "") {
          _endDate.text = widget.data.tarikhTamat;
        } else {
          _endDate.text = widget.data.tarikhMula;
        }

        if (widget.data.lampiran != "") {
          urlFormat =
              widget.data.lampiran.substring(widget.data.lampiran.length - 4);
          if (urlFormat == ".pdf") {
            pdfAttached = true;
            _createFileOfPdfUrl().then((f) {
              setState(() {
                remotePDFpath = f.path;
              });
            });
          } else {
            imgAttached = true;
          }
        } else {
          pdfAttached = false;
          imgAttached = false;
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        _buildTextForm(_appliedBy, "Pemohon"),
        _buildTextForm(_designation, "Jawatan"),
        _buildTextForm(_leaveType, "Jenis Cuti"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: Sizes().screenWidth(context) * 0.42,
                child: _buildTextForm(_startDate, "Tarikh Mula")),
            SizedBox(
                width: Sizes().screenWidth(context) * 0.42,
                child: _buildTextForm(_endDate, "Tarikh Tamat")),
          ],
        ),
        imgAttached
            ? _imgView(context)
            : pdfAttached
                ? _pdfViewButton(context)
                : Container(),
        _buildTextForm(_remarks, "Catatan"),
      ]),
    );
  }

  Stack _imgView(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) => ImageViewer(
                  attachment: widget.data.lampiran, type: BoxFit.fitWidth),
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
                        value: loadingProgress.expectedTotalBytes != null
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
    ]);
  }

  GestureDetector _pdfViewButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (remotePDFpath.isNotEmpty) {
            Timer(const Duration(milliseconds: 200), () {
              setState(() {
                textColor = blackCustom;
              });
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PDFScreen(path: remotePDFpath, getfile: filename),
              ),
            );
          }
        },
        onTapDown: (_) {
          setState(() {
            textColor = const Color(0xFF0F8F33);
          });
        },
        onTapUp: (_) {
          setState(() {
            textColor = blackCustom;
          });
        },
        onTapCancel: () {
          setState(() {
            textColor = blackCustom;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderTextColor, width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(pdfImg),
                  const SizedBox(width: 10),
                  Text(filename,
                      style: TextStyle(
                          color: textColor,
                          //decoration: textStyle,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                ],
              )),
        ));
  }

  Future<File> _createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      var url = widget.data.lampiran;
      filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing url file!');
    }

    return completer.future;
  }

  Padding _buildTextForm(TextEditingController textController, String label,
      [bool? icon]) {
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
          suffixIcon: icon == true
              ? Icon(CustomIcon.scheduleOutline, color: grey500, size: 15)
              : null,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: borderTextColor,
            ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
        ),
      ),
    );
  }
}
