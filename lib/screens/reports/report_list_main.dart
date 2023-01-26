/// LIST OF REPORTS FOR TAB/MOBILE APP DISPLAY FROM APP DRAWER
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
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
  final GlobalKey<ReportFilterDrawerState> filterDrawerKey = GlobalKey();

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
          ? const Drawer(
              child: ReportFilterDrawer(),
            )
          : const SizedBox(),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: userRole != 100
            ? Column(
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
                              child: ReportFilterDrawer(key: filterDrawerKey),
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
                  // if (filterDrawerKey.currentState!.displayFilterSection)
                  // filteredSection(),

                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: CardListView(
                          type: "Laporan",
                          screens: "drawer",
                          passData: {
                            "date": "",
                            "mainRoute": "",
                            "parkId": "",
                            "streetId": "",
                            "statusCode": "",
                          },
                          topCardStatus: null),
                    ),
                  )
                ],
              )
            : Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 45),
                    child: CompactorReportListMain(),
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

  // Widget filteredSection() {
  //   return Container(
  //     padding: userRole == 100
  //         ? const EdgeInsets.symmetric(horizontal: 16, vertical: 26)
  //         : const EdgeInsets.all(14),
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: userRole == 100 ? 20 : 0,
  //         ),
  //         SizedBox(
  //           height: 35,
  //           child: ListView(
  //             shrinkWrap: true,
  //             physics: const BouncingScrollPhysics(),
  //             scrollDirection: Axis.horizontal,
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   setState(() {
  //                     // filterDrawerKey
  //                     //     .currentState!.filteredDateTextFormField.text = "";
  //                     // filterDrawerKey.currentState!.filteredDate =
  //                     //     DateTime.now();
  //                     // filterDrawerKey.currentState!.selectedStatus.clear();
  //                     // filterDrawerKey.currentState!.displayFilterSection =
  //                     //     false;
  //                   });
  //                 },
  //                 child: Container(
  //                   width: 60,
  //                   height: 30,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     border: Border.all(
  //                       color: const Color(0xffD9D9D9),
  //                     ),
  //                     borderRadius: BorderRadius.circular(26),
  //                   ),
  //                   padding: const EdgeInsets.all(8),
  //                   child: Center(
  //                     child: Text(
  //                       "Reset",
  //                       style: TextStyle(
  //                         color: blackCustom,
  //                         fontSize: 11,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               if (filterDrawerKey.currentState!.selectedDate != "")
  //                 Row(
  //                   children: [
  //                     const SizedBox(
  //                       width: 8,
  //                     ),
  //                     Container(
  //                       padding: const EdgeInsets.all(8),
  //                       decoration: BoxDecoration(
  //                         color: const Color(0xffE7F5FF),
  //                         border: Border.all(
  //                           color: const Color(0xffC0E4FF),
  //                         ),
  //                         borderRadius: BorderRadius.circular(26),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             filterDrawerKey.currentState!.selectedDate,
  //                             style: const TextStyle(
  //                               color: Color(0xff005B9E),
  //                               fontSize: 11,
  //                               fontWeight: FontWeight.w600,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           InkWell(
  //                             onTap: () {
  //                               setState(() {
  //                                 filterDrawerKey.currentState!
  //                                     .filteredDateTextFormField.text = "";
  //                                 filterDrawerKey.currentState!.selectedDate =
  //                                     "";
  //                                 filterDrawerKey.currentState!.filteredDate =
  //                                     DateTime.now();
  //                                 if (filterDrawerKey
  //                                     .currentState!.selectedStatus.isEmpty) {
  //                                   filterDrawerKey.currentState!
  //                                       .displayFilterSection = false;
  //                                 }
  //                               });
  //                             },
  //                             child: const Icon(
  //                               Icons.close,
  //                               color: Color(0xff005B9E),
  //                               size: 12,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               const SizedBox(
  //                 width: 8,
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.only(left: 8),
  //                 child: ListView.separated(
  //                   physics: const NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   scrollDirection: Axis.horizontal,
  //                   separatorBuilder: (context, index) {
  //                     return const SizedBox(
  //                       width: 8,
  //                     );
  //                   },
  //                   itemCount:
  //                       filterDrawerKey.currentState!.selectedStatus.length,
  //                   itemBuilder: (context, index) {
  //                     return Container(
  //                       padding: const EdgeInsets.all(8),
  //                       decoration: BoxDecoration(
  //                         color: const Color(0xffE7F5FF),
  //                         border: Border.all(
  //                           color: const Color(0xffC0E4FF),
  //                         ),
  //                         borderRadius: BorderRadius.circular(26),
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             filterDrawerKey
  //                                 .currentState!.selectedStatus[index].name,
  //                             style: const TextStyle(
  //                               color: Color(0xff005B9E),
  //                               fontSize: 11,
  //                               fontWeight: FontWeight.w600,
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           InkWell(
  //                             onTap: () {
  //                               setState(() {
  //                                 filterDrawerKey.currentState!.selectedStatus
  //                                     .remove(filterDrawerKey
  //                                         .currentState!.selectedStatus[index]);
  //                                 if (filterDrawerKey.currentState!
  //                                         .selectedStatus.isEmpty &&
  //                                     filterDrawerKey.currentState!
  //                                             .filteredDateTextFormField.text ==
  //                                         "") {
  //                                   filterDrawerKey.currentState!
  //                                       .displayFilterSection = false;
  //                                 }
  //                               });
  //                             },
  //                             child: const Icon(
  //                               Icons.close,
  //                               color: Color(0xff005B9E),
  //                               size: 12,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               const SizedBox(
  //                 width: 8,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
