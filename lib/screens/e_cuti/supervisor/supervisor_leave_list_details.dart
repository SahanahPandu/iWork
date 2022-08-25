import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/cuti.dart';
import '../../../widgets/container/status_container.dart';

class SupervisorLeaveListDetails extends StatefulWidget {
  final Cuti data;

  const SupervisorLeaveListDetails({Key? key, required this.data})
      : super(key: key);

  @override
  State<SupervisorLeaveListDetails> createState() =>
      _SupervisorLeaveListDetailsState();
}

class _SupervisorLeaveListDetailsState
    extends State<SupervisorLeaveListDetails> {
  String statusText = "";

  _filterData() {
    if (widget.data.idStatus == 1) {
      //Baharu
      statusText = "Baru";
    } else if (widget.data.idStatus == 2) {
      //Diluluskan Tanpa Lampiran
      statusText = "Diluluskan Tanpa Lampiran";
    } else if (widget.data.idStatus == 3) {
      //Diluluskan
      statusText = "Diluluskan";
    } else if (widget.data.idStatus == 4) {
      //Ditolak
      statusText = "Ditolak";
    }
  }

  @override
  void initState() {
    _filterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Jenis dan Status Cuti
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  widget.data.pemohon,
                  style: TextStyle(
                      fontSize: 16,
                      color: blackCustom,
                      fontWeight: FontWeight.w500),
                ),
              ),
              StatusContainer(
                type: "Cuti",
                status: statusText,
                statusId: widget.data.idStatus,
                fontWeight: statusFontWeight,
              ),
            ],
          ),
        ),

        //Penyelia
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Penyelia",
                style: TextStyle(
                  fontSize: 15,
                  color: greyCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.data.approvalBy,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Jenis Cuti
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jenis Cuti",
                style: TextStyle(
                  fontSize: 15,
                  color: greyCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.data.jenisCuti,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),

        //Tarikh Mula/Tamat
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mula/Tamat",
                style: TextStyle(
                  fontSize: 15,
                  color: greyCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                (widget.data.tarikhMula != widget.data.tarikhTamat)
                    ? "${widget.data.tarikhMula} - ${widget.data.tarikhTamat}"
                    : widget.data.tarikhMula,
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
