import 'package:flutter/material.dart';

//import files
import '../../widgets/listview/card_list_view.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
          child: Text(
            "Rekod laporan: ",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CardListView(type: "Laporan", topCardStatus: null),
      ],
    );
  }
}