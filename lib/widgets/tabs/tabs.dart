import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../screens/e_cuti/leave_form.dart';
import '../../screens/e_cuti/leave_list.dart';
import '../../screens/reports/report_form.dart';
import '../../screens/reports/report_list.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/app_bar/app_bar_widget.dart';

class Tabs extends StatefulWidget {
  final String screen;
  final dynamic passData;
  final String title;

  const Tabs({
    Key? key,
    required this.screen,
    required this.passData,
    required this.title,
  }) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  getTabView() {
    if (widget.screen == "1" || widget.screen == "5" || widget.screen == "8") {
      // e_cuti
      //screen = "1" - ecuti button , screen ="2" -  from leave list , screen ="5" -  E-cuti menu from drawer , screen ="8" -  redirect after submit leave form

      return TabBarView(
        controller: _tabController,
        children: [
          LeaveForm(screen: widget.screen, data: widget.passData),
          const LeaveList(),
        ],
      );
    } else if (widget.screen == "3" ||
        widget.screen == "4" ||
        widget.screen == "6" ||
        widget.screen == "7") {
      //reports
      //screen = "3" - report button (work schedule), screen = "4" - from record list , screen ="6" -  Laporan menu from drawer, screen = "7" - redirect after submit report form

      return TabBarView(
        physics: userRole == 100 ? const NeverScrollableScrollPhysics() : null,
        controller: _tabController,
        children: [
          ReportForm(
            screen: widget.screen,
            passData: widget.passData,
          ),
          ReportList(
            passData: widget.passData,
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    if (widget.screen == "7" || widget.screen == "8") {
      _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    } else {
      _tabController = TabController(length: 2, vsync: this);
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.title,
      ),
      backgroundColor: Colors.white,
      body: userRole == 100
          ? Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: Orientations().isTabletPortrait(context)
                        ? const EdgeInsets.symmetric(horizontal: 20)
                        : const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      height: 65,
                      width: Orientations().isTabletPortrait(context)
                          ? Sizes().screenWidth(context)
                          : Sizes().screenWidth(context) * 0.75,
                      decoration: BoxDecoration(
                        color: tabBoxColor,
                        borderRadius: BorderRadius.circular(
                          46,
                        ),
                      ),
                      child: TabBar(
                          padding: Orientations().isTabletPortrait(context)
                              ? const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20)
                              : const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 70),
                          controller: _tabController,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                46,
                              ),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: tabShadowColor,
                                  blurRadius: 1,
                                  offset: const Offset(0.0, 2.0),
                                ),
                              ]),
                          labelColor: blackCustom,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                          unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                          unselectedLabelColor: greyCustom,
                          tabs: const [
                            Tab(
                              text: 'Borang',
                            ),
                            Tab(
                              text: 'Rekod',
                            ),
                          ]),
                    ),
                  ),
                  ScrollConfiguration(
                    behavior: const MaterialScrollBehavior()
                        .copyWith(overscroll: false),
                    child: Expanded(child: getTabView()),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F6FF),
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                  ),
                  child: TabBar(
                    padding: const EdgeInsets.all(10),
                    controller: _tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: grey400,
                            blurRadius: 2,
                            offset: const Offset(0.0, 2.0),
                          ),
                        ]),
                    labelColor: const Color(0xff2B2B2B),
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                    unselectedLabelColor: const Color(0xff969696),
                    tabs: const [
                      Tab(
                        text: 'Borang',
                      ),
                      Tab(
                        text: 'Rekod',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: getTabView(),
                ),
              ],
            ),
    );
  }
}
