import "package:flutter/material.dart";

//import files
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../widgets/container/status_container.dart';

class ListOfEmployeeDetails extends StatefulWidget {
  const ListOfEmployeeDetails({Key? key}) : super(key: key);

  @override
  State<ListOfEmployeeDetails> createState() => _ListOfEmployeeDetailsState();
}

class _ListOfEmployeeDetailsState extends State<ListOfEmployeeDetails> {
  Color statusTextColor = greyStatusText;
  Color statusBoxColor = greyStatusBox;

  filterData() {
    Color textColor = greyStatusText;
    Color boxColor = greyStatusBox;

    // if (widget.data.idStatus == 1) {
    //   //Dalam Proses
    //   textColor = blueStatusText;
    //   boxColor = blueStatusBox;
    // } else if (widget.data.idStatus == 2) {
    //   //Diluluskan Tanpa Lampiran
    //   textColor = orangeStatusText;
    //   boxColor = orangeStatusBox;
    // } else if (widget.data.idStatus == 3) {
    //   //Diluluskan
    //   textColor = greenStatusText;
    //   boxColor = greenStatusBox;
    // } else if (widget.data.idStatus == 4) {
    //   //Tidak Diluluskan
    //   textColor = redStatusText;
    //   boxColor = redStatusBox;
    // }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Avatar, nama and status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //Avatar
                const Material(
                  elevation: 3,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  child: SizedBox(
                    height: 45,
                    width: 45,
                    child: Icon(
                      Icons.account_box_rounded,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                //Nama
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Suhaimi Saad",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "PRA",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //Status
            StatusContainer(
              boxColor: statusBoxColor,
              status: "Tidak Hadir",
              textColor: statusTextColor,
              fontWeight: statusFontWeight,
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        //Kemahiran
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.psychology,
                  size: 20,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Kemahiran",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Text(
              "Kemahiran Asas",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        //Masuk Kerja / Keluar Kerja
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "Masuk Kerja / Keluar Kerja",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Text(
              "--,-- / --,--",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ],
    );
  }
}
