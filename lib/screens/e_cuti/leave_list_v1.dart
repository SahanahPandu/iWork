import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/listview/card_list_view.dart';

class LeaveList extends StatefulWidget {
  const LeaveList({Key? key}) : super(key: key);

  @override
  State<LeaveList> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Rekod permohonan cuti: ",
              style: TextStyle(
                color: Color(0xff8A92A6),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const CardListView(type: "Cuti", topCardStatus: null)),
        ],
      ),
    );
  }
}
