// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
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
