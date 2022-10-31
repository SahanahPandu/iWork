import 'package:flutter/material.dart';

//import files
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
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "${widget.data.jumlahTong} tong",
              style: TextStyle(
                fontSize: 16,
                color: greyCustom,
                fontWeight: FontWeight.w400,
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
