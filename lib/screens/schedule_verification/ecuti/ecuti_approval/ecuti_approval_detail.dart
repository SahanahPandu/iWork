import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/custom_icon.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: _device.screenWidth(context) * 0.42,
                child: _buildTextForm(_startDate, "Tarikh Mula")),
            SizedBox(
                width: _device.screenWidth(context) * 0.42,
                child: _buildTextForm(_endDate, "Tarikh Tamat")),
          ],
        ),
        isAttached
            ? Stack(alignment: Alignment.center, children: [
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
        _buildTextForm(_remarks, "Catatan"),
      ]),
    );
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
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
