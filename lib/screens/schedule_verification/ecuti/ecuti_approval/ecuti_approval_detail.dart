import 'package:eswm/utils/custom_icon.dart';
import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/cuti.dart';
import '../../../../utils/device.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
        textFormBuild(_remarks, "Catatan"),
      ]),
    );
  }

  Padding textFormBuild(TextEditingController textController, String label,
      [bool? icon]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        minLines: 1,//Normal textInputField will be displayed
        maxLines: textController == _remarks? 10 : 1,//
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
          suffixIcon: icon == true
              ? Icon(CustomIcon.scheduleOutline, color: grey500, size: 15)
              : null,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: grey500,
            ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
            //gapPadding: 6.0,
          ),
        ),
      ),
    );
  }
}
