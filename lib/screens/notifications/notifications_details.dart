import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//import files
import '../../config/palette.dart';
import '../../models/notifikasi.dart';
import '../../utils/custom_icon.dart';

class NotificationDetails extends StatefulWidget {
  final Notifikasi data;

  const NotificationDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  late int notiType;
  late String receivedTime;

  getTime() {
    DateTime dateToday = DateTime.now();
    DateTime convertDate = DateTime.parse(widget.data.dateReceived);
    var getTimeDiff = dateToday.difference(convertDate);
    String convDateToday = DateFormat('dd MMMM').format(DateTime.now());
    String convertTheDate =
        DateFormat('dd MMMM').format(DateTime.parse(widget.data.dateReceived));

    String theTime = "";

    //check if the day today
    if (convDateToday == convertTheDate) {
      if (getTimeDiff.inHours >= 1) {
        theTime = "${getTimeDiff.inHours} jam lalu";
      } else if (getTimeDiff.inHours < 1) {
        theTime = "${getTimeDiff.inMinutes} minit lalu";
      }
    } else {
      theTime = DateFormat("hh:mm a").format(convertDate);
    }

    setState(() {
      receivedTime = theTime;
    });
  }

  @override
  void initState() {
    super.initState();
    notiType = widget.data.notiTypeId;
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notiType == 2
                      ? greenStatusBox
                      : notiType == 3
                          ? orangeStatusBox
                          : notiType == 4
                              ? redStatusBox
                              : greyStatusBox,
                ),
                child: Icon(
                  notiType == 2
                      ? CustomIcon.marker
                      : notiType == 3
                          ? CustomIcon.eCutiOutline
                          : notiType == 4
                              ? CustomIcon.formOutline
                              : CustomIcon.notificationOutline,
                  size: 15,
                  color: notiType == 2
                      ? greenStatusText
                      : notiType == 3
                          ? orangeStatusText
                          : notiType == 4
                              ? redStatusText
                              : greyStatusText,
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
                  widget.data.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: blackCustom,
                    fontWeight: widget.data.readIdStatus == 1
                        ? FontWeight.w700
                        : FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  receivedTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.data.readIdStatus == 1
                        ? blackCustom
                        : greyCustom,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
