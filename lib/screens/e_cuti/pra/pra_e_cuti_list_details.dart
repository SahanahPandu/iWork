// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../../models/cuti.dart';
import '../../../../widgets/container/status_container.dart';

class PraECutiListDetails extends StatefulWidget {
  Cuti data;

  PraECutiListDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<PraECutiListDetails> createState() => _PraECutiListDetailsState();
}

class _PraECutiListDetailsState extends State<PraECutiListDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          //Jenis dan Status Cuti
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data.jenisCuti,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w900,
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

          //Tarikh Mula/Tamat
          Padding(
            padding: const EdgeInsets.only(
              top: 22,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tarikh Mula / Tamat",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  (widget.data.tarikhMula != widget.data.tarikhTamat)
                      ? "${widget.data.tarikhMula} - ${widget.data.tarikhTamat}"
                      : widget.data.tarikhMula,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          //Lampiran
          (widget.data.lampiran == "" &&
                  (widget.data.idJenisCuti == 1 ||
                      widget.data.idJenisCuti == 2))
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lampiran",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(children: [
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.orange,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Sila muat naik lampiran",
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ]),
                  ],
                )
              : (widget.data.lampiran != "")
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lampiran",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.data.lampiran,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  : Container(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
