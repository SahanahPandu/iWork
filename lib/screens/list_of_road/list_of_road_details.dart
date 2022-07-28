// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../models/jalan.dart';
import '../../widgets/modal_bottom_sheet/navigation_options.dart';

class ListOfRoadDetails extends StatefulWidget {
  Jalan data;
  int index;

  ListOfRoadDetails({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<ListOfRoadDetails> createState() => _ListOfRoadDetailsState();
}

class _ListOfRoadDetailsState extends State<ListOfRoadDetails> {
  @override
  Widget build(BuildContext context) {
    if (userRole == 100) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.data.namaJalan,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Jumlah Tong ${widget.data.jumlahTong}",
                  style: TextStyle(
                    fontSize: 14,
                    color: grey400,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 22,
            height: 22,
            child: ElevatedButton(
              onPressed: () {
                showNavigationOptions(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xffc9ffd7),
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Icon(
                Icons.near_me_rounded,
                color: Colors.green,
                size: 15,
              ),
            ),
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //left side
        Row(
          children: [
            Text(
              "${(widget.index + 1)}. ${widget.data.namaJalan}",
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 28,
              height: 28,
              child: ElevatedButton(
                onPressed: () {
                  showNavigationOptions(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffc9ffd7),
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Icon(
                  Icons.near_me_rounded,
                  color: Colors.green,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        //right side
        Row(
          children: [
            Text(
              "Jumlah Tong",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Container(
              width: 28,
              height: 25,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 204, 220, 255),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                child: Text(
                  "${widget.data.jumlahTong}",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
