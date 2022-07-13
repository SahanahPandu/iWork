import 'package:eswm/widgets/cards/e_cuti/pra/pra_e_cuti_list_details.dart';
import 'package:eswm/widgets/listview/card_list_view.dart';
import 'package:flutter/material.dart';

class LeaveList extends StatefulWidget {
  const LeaveList({Key? key}) : super(key: key);

  @override
  State<LeaveList> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  List items = ['Cuti1', 'Cuti2', 'Cuti3', 'Cuti4'];

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
        CardListView(
          itemList: items,
          pages: const PraECutiListDetails(),
          cardHeight: 130,
        ),
      ],
    );
  }
}
