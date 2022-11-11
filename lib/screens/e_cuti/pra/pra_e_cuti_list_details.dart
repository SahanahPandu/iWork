import 'package:flutter/material.dart';

//import files
import '../../../../models/cuti.dart';
import '../../../../widgets/container/status_container.dart';
import '../../../config/font.dart';
import '../../../utils/icon/custom_icon.dart';

class PraECutiListDetails extends StatefulWidget {
  final Cuti data;

  const PraECutiListDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<PraECutiListDetails> createState() => _PraECutiListDetailsState();
}

class _PraECutiListDetailsState extends State<PraECutiListDetails> {
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
                  widget.data.jenisCuti,
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
                status: widget.data.status,
                statusId: widget.data.idStatus,
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
              (widget.data.tarikhMula != widget.data.tarikhTamat)
                  ? "${widget.data.tarikhMula} - ${widget.data.tarikhTamat}"
                  : widget.data.tarikhMula,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xff969696),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          //for status Diluluskan tanpa Lampiran only
          if (widget.data.lampiran == "" &&
              (widget.data.idJenisCuti == 1 || widget.data.idJenisCuti == 2))
            const SizedBox(
              height: 24,
            ),
          //for status Diluluskan tanpa Lampiran only
          if (widget.data.lampiran == "" &&
              (widget.data.idJenisCuti == 1 || widget.data.idJenisCuti == 2))
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
