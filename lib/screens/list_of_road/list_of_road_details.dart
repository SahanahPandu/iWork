import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../models/jalan.dart';
import '../../utils/icon/custom_icon.dart';
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
