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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Rekod permohonan cuti: ",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CardListView(type: "Cuti", topCardStatus: null),
      ],
    );
  }
}
