import 'package:flutter/material.dart';

//import files
import '../../models/notifikasi.dart';

class NotificationDetails extends StatefulWidget {
  final Notifikasi data;

  const NotificationDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.chat_rounded,
                  size: 27,
                  color: Color(0xff005B9E),
                ),
              ),
              if (widget.data.readIdStatus == 1)
                const Positioned(
                  top: 7,
                  right: 6,
                  child: Icon(
                    Icons.circle,
                    size: 10,
                    color: Color(0xffE04141),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.notiType,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff232D42),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.data.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.data.readIdStatus == 1
                        ? const Color(0xff232D42)
                        : const Color(0xff8A92A6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
