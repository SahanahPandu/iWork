import 'package:flutter/material.dart';

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
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data.vehicleNo,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: black87,
                      fontSize: 15),
                ),
                StatusContainer(
                  type: "Akbk",
                  status: widget.data.status,
                  statusId: widget.data.statusId,
                  fontWeight: statusFontWeight,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. AKBK',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: black87,
                        fontSize: 13)),
                Text(widget.data.akbkNo,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: grey500,
                        fontSize: 13)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jenis Kerosakan',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: black87,
                        fontSize: 13)),
                Text(widget.data.breakdownType,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: grey500,
                        fontSize: 13)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tarikh',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: black87,
                        fontSize: 13)),
                Text(widget.data.date,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: grey500,
                        fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
