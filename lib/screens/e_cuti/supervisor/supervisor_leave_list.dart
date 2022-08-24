import 'package:flutter/material.dart';

//import files
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
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: barShadowColor,
                offset: const Offset(0, 3),
                blurRadius: 8,
              )
            ]),
            child: AppBar(
              backgroundColor: white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
              ),
              title: Center(
                child: Text(
                  "E-Cuti",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CustomIcon.filter,
                    color: blackCustom,
                    size: 13,
                  ),
                ),
              ],
            ),
          ),
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
                    color: blackCustom,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CardListView(type: "Cuti"),
            ),
          ]),
        ));
  }
}
