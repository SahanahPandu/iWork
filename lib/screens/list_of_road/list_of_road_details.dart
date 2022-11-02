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
          width: 30,
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              showNavigationOptions(context);
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                overlayColor:
                    MaterialStateProperty.all(const Color(0xff95e7ae)),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xe0e0fde8))),
            child: Icon(
              CustomIcon.navigation,
              color: Colors.green,
              size: userRole == 100 ? 28 : 25,
            ),
          ),
        ),
      ],
    );
  }
}
