import 'package:eswm/utils/custom_icon.dart';
import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/device.dart';
import '../../../../widgets/image_viewer/image_viewer.dart';

class EcutiApprovalDetail extends StatefulWidget {
  final Cuti data;

  const EcutiApprovalDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<EcutiApprovalDetail> createState() => _EcutiApprovalDetailState();
}

class _EcutiApprovalDetailState extends State<EcutiApprovalDetail> {
  final TextEditingController _appliedBy = TextEditingController();
  final TextEditingController _leaveType = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _attachment = TextEditingController();
  final TextEditingController _remarks = TextEditingController();
  final Devices _device = Devices();
  bool isAttached = false;

  @override
  void initState() {
    if (widget.data.pemohon != "" ||
        widget.data.jenisCuti != "" ||
        widget.data.tarikhMula != "" ||
        widget.data.catatan != "") {
      setState(() {
        _appliedBy.text = widget.data.pemohon;
        _leaveType.text = widget.data.jenisCuti;
        _startDate.text = widget.data.tarikhMula;

        if (widget.data.tarikhTamat != "") {
          _endDate.text = widget.data.tarikhTamat;
        } else {
          _endDate.text = widget.data.tarikhMula;
        }

        if (widget.data.lampiran != "") {
          _attachment.text = " ";
          isAttached = true;
        } else {
          _attachment.text = "Tiada Lampiran";
          isAttached = false;
        }

        if (widget.data.catatan != "") {
          _remarks.text = widget.data.catatan;
        } else {
          _remarks.text = "Tiada Catatan";
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        textFormBuild(_appliedBy, "Nama Pekerja"),
        textFormBuild(_leaveType, "Jenis Cuti"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: _device.screenWidth(context) * 0.4,
                child: textFormBuild(_startDate, "Tarikh Mula", true)),
            SizedBox(
                width: _device.screenWidth(context) * 0.4,
                child: textFormBuild(_endDate, "Tarikh Tamat", true)),
          ],
        ),
        isAttached
            ? Stack(alignment: Alignment.center, children: [
                textFormBuild(_attachment, "Lampiran", false, isAttached),
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
                    tag: "demoTag",
                    child: Container(
                      height: 100,
                      width: 130,
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
            : textFormBuild(_attachment, "Lampiran", false, isAttached),
        textFormBuild(_remarks, "Catatan"),
      ]),
    );
  }

  Padding textFormBuild(TextEditingController textController, String label,
      [bool? icon, bool? img]) {
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
          contentPadding: img == true
              ? const EdgeInsets.symmetric(vertical: 50, horizontal: 10)
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12,
            color: grey,
            fontWeight: FontWeight.w300,
          ),
          suffixIcon: icon == true
              ? Icon(CustomIcon.scheduleOutline, color: grey500, size: 15)
              : null,
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
