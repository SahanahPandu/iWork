// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../../../config/font_weight.dart';
import '../../../../config/palette.dart';
import '../../../../models/cuti.dart';
import '../../../../widgets/container/status_container.dart';

class PraECutiListDetails extends StatefulWidget {
  Cuti data;

  PraECutiListDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<PraECutiListDetails> createState() => _PraECutiListDetailsState();
}

class _PraECutiListDetailsState extends State<PraECutiListDetails> {
  Color statusTextColor = greyStatusText;
  Color statusBoxColor = greyStatusBox;

  filterData() {
    Color textColor = greyStatusText;
    Color boxColor = greyStatusBox;

    if (widget.data.idStatus == 1) {
      //Dalam Proses
      textColor = blueStatusText;
      boxColor = blueStatusBox;
    } else if (widget.data.idStatus == 2) {
      //Diluluskan Tanpa Lampiran
      textColor = orangeStatusText;
      boxColor = orangeStatusBox;
    } else if (widget.data.idStatus == 3) {
      //Diluluskan
      textColor = greenStatusText;
      boxColor = greenStatusBox;
    } else if (widget.data.idStatus == 4) {
      //Tidak Diluluskan
      textColor = redStatusText;
      boxColor = redStatusBox;
    }

    setState(() {
      statusTextColor = textColor;
      statusBoxColor = boxColor;
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    filterData();
  }

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
              // Container(
              //   decoration: BoxDecoration(
              //     color: statusBoxColor,
              //     borderRadius: BorderRadius.circular(6),
              //   ),
              //   child: Container(
              //     margin: const EdgeInsets.all(5),
              //     child: Center(
              //       child: Text(
              //         widget.data.status,
              //         style: TextStyle(
              //           color: statusTextColor,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              StatusContainer(
                boxColor: statusBoxColor,
                status: widget.data.status,
                textColor: statusTextColor,
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
