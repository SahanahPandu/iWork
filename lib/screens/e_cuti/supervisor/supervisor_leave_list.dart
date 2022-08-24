import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../widgets/listview/card_list_view.dart';

class SupervisorLeaveList extends StatefulWidget {
  const SupervisorLeaveList({Key? key}) : super(key: key);

  @override
  State<SupervisorLeaveList> createState() => _SupervisorLeaveList();
}

class _SupervisorLeaveList extends State<SupervisorLeaveList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Text(
                "Rekod permohonan cuti PRA :",
                style: TextStyle(
                    color: blackCustom,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CardListView(type: "Cuti"),
            ),
          ]),
        ));
  }
}
