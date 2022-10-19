import 'package:flutter/material.dart';

//import files
import '../../widgets/custom_scroll/custom_scroll.dart';
import '../../widgets/listview/card_list_view.dart';

class LeaveList extends StatefulWidget {
  const LeaveList({Key? key}) : super(key: key);

  @override
  State<LeaveList> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  dynamic idStatus;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 14, bottom: 17),
                child: TabBar(
                  indicatorPadding: const EdgeInsets.symmetric(vertical: 6),
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: Color(0xff34A853),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  labelColor: const Color(0xff34A853),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelColor: const Color(0xffA4A4A4),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: "Semua",
                    ),
                    Tab(
                      text: "Dalam Proses",
                    ),
                    Tab(
                      text: "Diluluskan",
                    ),
                    Tab(
                      text: "Ditolak",
                    ),
                  ],
                  onTap: (index) {
                    dynamic status;

                    index == 1
                        ? status = [1, 2]
                        : index == 2
                            ? status = [3]
                            : index == 3
                                ? status = [4]
                                : status = null;

                    setState(() {
                      idStatus = status;
                    });
                  },
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: CardListView(
                    type: "Cuti",
                    cutiStatus: idStatus,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
