import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../widgets/custom_scroll/custom_scroll.dart';
import '../../../widgets/listview/card_list_view.dart';

class SupervisorLeaveList extends StatefulWidget {
  final List<int>? status;

  const SupervisorLeaveList({Key? key, this.status}) : super(key: key);

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
        body: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                child: Text(
                  "Senarai permohonan E-Cuti:",
                  style: TextStyle(
                      color: blackCustom,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CardListView(type: "Cuti", cutiStatus: widget.status),
              ),
            ]),
          ),
        ));
  }
}
