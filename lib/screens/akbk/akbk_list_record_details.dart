import 'package:flutter/material.dart';

//import files
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../models/akbk.dart';
import '../../widgets/container/status_container.dart';

class AkbkListRecordDetails extends StatefulWidget {
  final Akbk data;

  const AkbkListRecordDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<AkbkListRecordDetails> createState() => _AkbkListRecordDetailsState();
}

class _AkbkListRecordDetailsState extends State<AkbkListRecordDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('No. AKBK',
                  style: TextStyle(
                    fontSize: 15,
                    color: greyCustom,
                    fontWeight: FontWeight.w400,
                  )),
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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jenis Kerosakan',
                  style: TextStyle(
                    fontSize: 15,
                    color: greyCustom,
                    fontWeight: FontWeight.w400,
                  )),
              Text(widget.data.breakdownType,
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tarikh',
                  style: TextStyle(
                    fontSize: 15,
                    color: greyCustom,
                    fontWeight: FontWeight.w400,
                  )),
              Text(widget.data.date,
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
