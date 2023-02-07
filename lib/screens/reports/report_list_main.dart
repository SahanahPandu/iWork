/// LIST OF REPORTS FOR TAB/MOBILE APP DISPLAY FROM APP DRAWER
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../models/report/obstacle_types.dart';
import '../../models/report/report_status.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';
import '../../widgets/gridview/compactor_panel/report/compactor_report_list_main.dart';
import '../../widgets/listview/card_list_view.dart';
import 'report_filter_drawer.dart';

class ReportListMain extends StatefulWidget {
  const ReportListMain({Key? key}) : super(key: key);

  @override
  State<ReportListMain> createState() => _ReportListMainState();
}

class _ReportListMainState extends State<ReportListMain> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<ReportFilterDrawerState> reportDrawerKey = GlobalKey();

  Map<String, dynamic>? passData;

  String? selectedDate;
  String? selMainRoute;
  String? selSubRoute;
  String? selNamaTaman;
  String? selNamaJalan;
  int? selParkId = 0;
  int? selRoadId = 0;
  List<ReportStatus> selectedStatus = [];
  List<ObstacleTypes> selectedObstacles = [];
  bool displayFilterSection = false;

  updateFilterData(Map<String, dynamic> passingData) {
    if (passingData.isNotEmpty) {
      setState(() {
        passData = passingData;
        displayFilterSection = true;
        if (passingData['date'] != null) selectedDate = passingData['date'];
        if (passingData['mainRoute'] != null) {
          selMainRoute = passingData['mainRoute'];
        }
        if (passingData['subRoute'] != null) {
          selSubRoute = passingData['subRoute'];
        }
        if (passingData['park'] != null) {
          Map<String, dynamic> dataTaman = passingData['park'];
          selParkId = dataTaman['id'];
          selNamaTaman = dataTaman['name'];
        }

        if (passingData['road'] != null) {
          Map<String, dynamic> dataJalan = passingData['road'];
          selRoadId = dataJalan['id'];
          selNamaJalan = dataJalan['name'];
        }

        if (passingData['obstacle'] != null) {
          selectedObstacles = passingData['obstacle'];
        }
        if (passingData['status'] != null) {
          selectedStatus = passingData['status'];
        }
      });
    }

    //this is for hide filterSection when all the selection id deleted
    if ((passData?['date'] == null || passData?['date'] == "") &&
        (passData?['mainRoute'] == null || passData?['mainRoute'] == "") &&
        (passData?['subRoute'] == null || passData?['subRoute'] == "") &&
        passData?['park']?['id'] == 0 &&
        passData?['road']?['id'] == 0 &&
        (passData?['obstacle'].isEmpty || passData?['obstacle'] == []) &&
        (passData?['status'].isEmpty || passData?['status'] == [])) {
      setState(() {
        displayFilterSection = false;
      });
    }
  }

  updatePassData(item, dynamic id) {
    if (item == "tarikh") {
      setState(() {
        selectedDate = null;
        passData?['date'] = null;
      });
    } else if (item == "laluan") {
      setState(() {
        selMainRoute = null;
        passData?['mainRoute'] = null;
      });
    } else if (item == "subLaluan") {
      setState(() {
        selSubRoute = null;
        passData?['subRoute'] = null;
      });
    } else if (item == "taman") {
      setState(() {
        selParkId = 0;
        selNamaTaman = null;
        passData?['park']?['id'] = 0;
        passData?['park']?['name'] = "";
      });
    } else if (item == "jalan") {
      setState(() {
        selRoadId = 0;
        selNamaJalan = null;
        passData?['road']?['id'] = 0;
        passData?['road']?['name'] = "";
      });
    } else if (item == "jenisHalangan") {
      setState(() {
        selectedObstacles.remove(id);
        passData?['obstacle'].remove((item) => item.id == id);
      });
    } else if (item == "status") {
      setState(() {
        selectedStatus.remove(id);
        passData?['status'].remove((item) => item.id == id);
      });
    }

    if ((passData?['date'] == null || passData?['date'] == "") &&
        (passData?['mainRoute'] == null || passData?['mainRoute'] == "") &&
        (passData?['subRoute'] == null || passData?['subRoute'] == "") &&
        passData?['park']?['id'] == 0 &&
        passData?['road']?['id'] == 0 &&
        (passData?['obstacle'].isEmpty || passData?['obstacle'] == []) &&
        (passData?['status'].isEmpty || passData?['status'] == [])) {
      setState(() {
        displayFilterSection = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
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
                "Laporan",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
      endDrawer: userRole == 100
          ? Drawer(
              child: ReportFilterDrawer(
                  passData: passData, updateState: updateFilterData),
            )
          : const SizedBox(),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: userRole != 100
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: Text(
                          "Senarai Laporan :",
                          style: TextStyle(
                              color: blackCustom,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: ReportFilterDrawer(
                                passData: passData,
                                updateState: updateFilterData,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          CustomIcon.filter,
                          color: blackCustom,
                          size: 13,
                        ),
                      ),
                    ],
                  ),
                  //filtered selection list
                  if (displayFilterSection) filteredSection(),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: CardListView(
                          type: "Laporan",
                          screens: "drawer",
                          passData: {
                            "date": selectedDate,
                            "mainRoute": selMainRoute,
                            "subRoute": selSubRoute,
                            "parkId": selParkId,
                            "streetId": selRoadId,
                            "obstacle": selectedObstacles,
                            "statusCode": selectedStatus,
                          },
                          topCardStatus: null),
                    ),
                  )
                ],
              )
            : Stack(
                children: [
                  //filtered selection list
                  if (displayFilterSection) filteredSection(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: displayFilterSection ? 85 : 45),
                    child: displayFilterSection
                        ? CompactorReportListMain(passData: {
                            "date": selectedDate,
                            "mainRoute": selMainRoute,
                            "subRoute": selSubRoute,
                            "parkId": selParkId,
                            "streetId": selRoadId,
                            "obstacle": selectedObstacles,
                            "statusCode": selectedStatus,
                          })
                        : const CompactorReportListMain(),
                  ),
                  Container(
                    color: white,
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Senarai Laporan :",
                          style: TextStyle(
                              color: blackCustom,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        IconButton(
                          tooltip: "Pilih untuk buat tapisan laporan",
                          splashColor: transparent,
                          highlightColor: transparent,
                          onPressed: () {
                            _key.currentState!.openEndDrawer();
                          },
                          icon: Icon(
                            CustomIcon.filter,
                            color: blackCustom,
                            size: 13,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget filteredSection() {
    return Container(
      padding: userRole == 100
          ? const EdgeInsets.only(left: 16, top: 28, right: 16, bottom: 10)
          : const EdgeInsets.only(left: 14, top: 0, right: 14, bottom: 5),
      child: Column(
        children: [
          SizedBox(
            height: userRole == 100 ? 20 : 0,
          ),
          SizedBox(
            height: 35,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = null;
                      selMainRoute = null;
                      selSubRoute = null;
                      selParkId = 0;
                      selNamaJalan = null;
                      selRoadId = 0;
                      selNamaTaman = null;
                      selectedObstacles.clear();
                      selectedStatus.clear();
                      passData?.clear();
                      displayFilterSection = false;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffD9D9D9),
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: blackCustom,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                //Tarikh
                if (selectedDate != "" && selectedDate != null)
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedDate!,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                updatePassData('tarikh', null);

                                false;
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                //Nama Laluan
                if (selMainRoute != null && selMainRoute != "")
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selMainRoute!,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                updatePassData('laluan', null);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                //Nama Sub-Laluan
                if (selSubRoute != null && selSubRoute != "")
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selSubRoute!,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                updatePassData('subLaluan', null);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                //Nama Taman
                if (selParkId != null && selParkId != 0)
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selNamaTaman!,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                updatePassData('taman', null);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                //Nama Jalan
                if (selRoadId != null && selRoadId != 0)
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selNamaJalan!,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                updatePassData('jalan', null);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                //Senarai Jenis Halangan
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: selectedObstacles.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedObstacles[index].name,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                updatePassData(
                                    "jenisHalangan", selectedObstacles[index]);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                //Senarai Status
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: selectedStatus.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedStatus[index].name,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                updatePassData("status", selectedStatus[index]);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
