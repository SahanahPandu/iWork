// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../../../config/font.dart';
import '../../../../config/palette.dart';
import '../../../../models/laluan.dart';
import '../../../../utils/device.dart';
import '../../../container/status_container.dart';

class SupervisorMyTaskListDetails extends StatefulWidget {
  Laluan data;

  SupervisorMyTaskListDetails({Key? key, required this.data}) : super(key: key);

  @override
  State<SupervisorMyTaskListDetails> createState() =>
      _SupervisorMyTaskListDetailsState();
}

class _SupervisorMyTaskListDetailsState
    extends State<SupervisorMyTaskListDetails> {
  late Color statusTextColor;
  late Color statusBoxColor;

  filterData() {
    //default status belum dimulakan
    Color textColor = Colors.grey;
    Color boxColor = Colors.grey.shade100;

    if (widget.data.idStatus == 2) {
      //Sedang Bertugas

      textColor = Colors.blue.shade800;
      boxColor = Colors.blue.shade100;
    } else if (widget.data.idStatus == 3) {
      //Tugasan Selesai

      textColor = Colors.green;
      boxColor = const Color(0xffc9ffd7);
    }

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
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                //Nama Laluan & Status
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data.namaLaluan,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w900),
                  ),
                  StatusContainer(
                    boxColor: statusBoxColor,
                    status: widget.data.status,
                    textColor: statusTextColor,
                    fontWeight: statusFontWeight,
                  ),
                ],
              ),
            ),
            //No Kenderaan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_shipping,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "No. Kenderaan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.data.noKenderaan,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            //Sub Laluan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Sub Laluan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumSubLaluan}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),

            //Jumlah Taman/Jalan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.house,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Jumlah Taman/Jalan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.data.jumlahTaman}/${widget.data.jumlahJalan}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          width: Devices().screenWidth(context) * 0.7,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.grey[300]),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: red)),
                ),
                minimumSize: MaterialStateProperty.all(
                    Size(Devices().screenWidth(context), 45)),
                backgroundColor: MaterialStateProperty.all(white)),
            child: Text("Kehadiran (2/3)",
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: red)),
          ),
        ),
      ],
    );
  }
}
