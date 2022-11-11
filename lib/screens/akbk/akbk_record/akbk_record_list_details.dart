import 'package:flutter/material.dart';

//import files
import '../../../config/font.dart';
import '../../../config/palette.dart';
import '../../../models/akbk.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/container/status_container.dart';

class AkbkRecordListDetails extends StatefulWidget {
  final Akbk data;

  const AkbkRecordListDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<AkbkRecordListDetails> createState() => _AkbkRecordListDetailsState();
}

class _AkbkRecordListDetailsState extends State<AkbkRecordListDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.data.vehicleNo,
                style: TextStyle(
                    fontSize: 16,
                    color: blackCustom,
                    fontWeight: FontWeight.w500),
              ),
            ),
            StatusContainer(
              type: "Akbk",
              status: widget.data.status,
              statusId: widget.data.statusId,
              fontWeight: statusFontWeight,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CustomIcon.timerFill, color: activeColor, size: 16),
                  const SizedBox(width: 10),
                  Text('Tarikh & Masa',
                      style: TextStyle(
                        fontSize: 15,
                        color: greyCustom,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Text('${widget.data.date}, ${widget.data.time}',
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CustomIcon.tamanFill, color: activeColor, size: 16),
                  const SizedBox(width: 10),
                  Text('Laluan',
                      style: TextStyle(
                        fontSize: 15,
                        color: greyCustom,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Text(widget.data.laluan != "" ? widget.data.laluan : "-",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CustomIcon.roadFill, color: activeColor, size: 16),
                  const SizedBox(width: 10),
                  Text('No. AKBK',
                      style: TextStyle(
                        fontSize: 15,
                        color: greyCustom,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Text(widget.data.akbkNo,
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 8, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(CustomIcon.exclamation, color: activeColor, size: 16),
                  const SizedBox(width: 10),
                  Text('Jenis Kerosakan',
                      style: TextStyle(
                        fontSize: 15,
                        color: greyCustom,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Text(widget.data.breakdownType,
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
