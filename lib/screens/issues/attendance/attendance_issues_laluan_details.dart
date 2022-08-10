import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';

class AttendanceIssuesLaluanDetails extends StatefulWidget {
  const AttendanceIssuesLaluanDetails({Key? key}) : super(key: key);

  @override
  State<AttendanceIssuesLaluanDetails> createState() =>
      _AttendanceIssuesLaluanDetailsState();
}

class _AttendanceIssuesLaluanDetailsState
    extends State<AttendanceIssuesLaluanDetails> {
  Color statusTextColor = greyStatusText;
  Color statusBoxColor = greyStatusBox;

  filterData() {
    Color textColor = greyStatusText;
    Color boxColor = greyStatusBox;

    // if (widget.data.idStatus == 2) {
    //   //Sedang Bertugas

    //   textColor = blueStatusText;
    //   boxColor = blueStatusBox;
    // } else if (widget.data.idStatus == 3) {
    //   //Tugasan Selesai

    //   textColor = greenStatusText;
    //   boxColor = greenStatusBox;
    // }

    setState(() {
      statusTextColor = textColor;
      statusBoxColor = boxColor;
    });
  }

  @override
  void initState() {
    super.initState();
    filterData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          //Nama Laluan & Status
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "JHBP01-C02",
              style: TextStyle(
                fontSize: 19,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w900,
              ),
            ),
            // StatusContainer(
            //   boxColor: statusBoxColor,
            //   status: "Belum Mula",
            //   textColor: statusTextColor,
            //   fontWeight: statusFontWeight,
            // ),
          ],
        ),

        //No. Kenderaan
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "No. Kenderaan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text(
                "BLW7096",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        //Sub Laluan
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Sub Laluan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text(
                "JHBP01-C02-1",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),

        //Jumlah Taman dan Jalan
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.house,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Jumlah Taman/Jalan",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Text(
                "13/123",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
