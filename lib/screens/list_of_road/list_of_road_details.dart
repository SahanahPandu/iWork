import 'package:eswm/utils/custom_icon.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../models/jalan.dart';
import '../../widgets/modal_bottom_sheet/navigation_options.dart';

class ListOfRoadDetails extends StatefulWidget {
  final Jalan data;
  final int index;

  const ListOfRoadDetails({Key? key, required this.data, required this.index})
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
                size: 24,
              ),
            ),
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.namaJalan,
              style: TextStyle(
                  color: blackCustom,
                  fontSize: userRole == 200 ? 15 : 14,
                  fontWeight:
                      userRole == 200 ? FontWeight.w400 : FontWeight.w600),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "${widget.data.jumlahTong} tong",
              style: TextStyle(
                fontSize: userRole == 200 ? 13 : 14,
                color: const Color(0xff969696),
                fontWeight: userRole == 200 ? FontWeight.w400 : FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 28,
          height: 28,
          child: ElevatedButton(
            onPressed: () {
              showNavigationOptions(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: const Color(0xffc9ffd7),
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Icon(
              CustomIcon.navigation,
              color: Colors.green,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
