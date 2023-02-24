import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/custom_scroll/custom_scroll.dart';
import '../../../widgets/paging/ecuti/ecuti_list_main.dart';

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
    return SafeArea(
      child: Scaffold(
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
                  icon:
                      Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
                ),
                title: Center(
                  child: Text(
                    "E-Notis Pekerja",
                    style: TextStyle(
                      fontSize: 15,
                      color: blackCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                actions: const [SizedBox(width: 50)],
              ),
            ),
          ),
          body: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 45),
                    child: ECutiListMain(),
                    // child:
                    //     CardListView(type: "Cuti", cutiStatus: widget.status),
                  ),
                  Container(
                      color: white,
                      padding: const EdgeInsets.fromLTRB(16, 12, 4, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Senarai E-Notis:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          /*IconButton(
                            tooltip: "Pilih untuk buat tapisan jadual",
                            splashColor: transparent,
                            highlightColor: transparent,
                            onPressed: () {},
                            icon: Icon(
                              CustomIcon.filter,
                              color: blackCustom,
                              size: 13,
                            ),
                          )*/
                        ],
                      )),
                ],
              )
              /*SingleChildScrollView(
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
            ),*/
              )),
    );
  }
}
