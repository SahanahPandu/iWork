import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../../../widgets/container/status_container.dart';
import '../../../config/font.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../models/ecuti/ecuti_details.dart';

class PraECutiListDetails extends StatefulWidget {
  final EcutiDetails data;

  const PraECutiListDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PraECutiListDetails> createState() => _PraECutiListDetailsState();
}

class _PraECutiListDetailsState extends State<PraECutiListDetails> {
  String tarikhMula = "";
  String tarikhTamat = "";

  loadData() {
    String startDate = "";
    String endDate = "";

    if (widget.data.dateFrom != "") {
      String theConvStartDate =
          DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.data.dateFrom));
      startDate = theConvStartDate;
    }

    if (widget.data.dateTo != "") {
      String theConvEndDate =
          DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.data.dateTo));
      endDate = theConvEndDate;
    }

    setState(() {
      tarikhMula = startDate;
      tarikhTamat = endDate;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Jenis dan Status Cuti
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.data.leaveType!.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff2B2B2B),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              StatusContainer(
                type: "Cuti",
                status: widget.data.status!.name,
                statusId: widget.data.status!.code,
                fontWeight: statusFontWeight,
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),
          //Tarikh Mula/Tamat
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              (tarikhMula != tarikhTamat)
                  ? "$tarikhMula - $tarikhTamat"
                  : tarikhMula,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xff969696),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          //for status Diluluskan tanpa Lampiran only
          if ((widget.data.uploadFile?.fileName == "" ||
                  widget.data.uploadFile?.fileName == null) &&
              widget.data.leaveType?.id == 2)
            const SizedBox(
              height: 24,
            ),
          //for status Diluluskan tanpa Lampiran only
          if ((widget.data.uploadFile?.fileName == "" ||
                  widget.data.uploadFile?.fileName == null) &&
              widget.data.leaveType?.id == 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: const [
                Icon(
                  CustomIcon.sensorAlert,
                  color: Color(0xffE04141),
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Sila muat naik lampiran",
                  style: TextStyle(
                    color: Color(0xffE04141),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ]),
            ),
        ],
      ),
    );
  }
}
