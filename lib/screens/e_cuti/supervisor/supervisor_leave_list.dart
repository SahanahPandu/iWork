import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../utils/custom_icon.dart';
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
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 1,
          shadowColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CustomIcon.arrowBack,
                color: Colors.grey.shade900, size: 15),
          ),
          title: Center(
            child: Text(
              "E-Cuti",
              style: TextStyle(
                fontSize: 18,
                color: grey800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_alt_rounded,
                color: grey800,
                size: 18,
              ),
            ),
          ],
        ),
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
                    color: grey500, fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CardListView(type: "Cuti"),
            ),
          ]),
        ));
  }
}
