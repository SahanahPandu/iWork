import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../utils/custom_icon.dart';
import 'ecuti_approval_tab_bar_view/ecuti_approval_all_tab_bar_view.dart';
import 'ecuti_approval_tab_bar_view/ecuti_approval_completed_tab_bar_view.dart';
import 'ecuti_approval_tab_bar_view/ecuti_approval_new_tab_bar_view.dart';
import 'ecuti_approval_tab_bar_view/ecuti_approval_rejected_tab_bar_view.dart';

class EcutiApprovalTab extends StatefulWidget {
  const EcutiApprovalTab({Key? key}) : super(key: key);

  @override
  State<EcutiApprovalTab> createState() => _EcutiApprovalTabState();
}

class _EcutiApprovalTabState extends State<EcutiApprovalTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
                    Icons.filter_alt_rounded,
                    color: blackCustom,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: tabBoxColor,
                  borderRadius: BorderRadius.circular(
                    46,
                  ),
                ),
                child: TabBar(
                  isScrollable: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                      fontWeight: FontWeight.w600, fontSize: 15),
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                  unselectedLabelColor: greyCustom,
                  tabs: const [
                    Tab(
                      text: 'Semua',
                    ),
                    Tab(
                      text: 'Baharu',
                    ),
                    Tab(
                      text: 'Diluluskan',
                    ),
                    Tab(
                      text: 'Ditolak',
                    ),
                  ],
                ),
              ),
              ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(overscroll: false),
                child: Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      EcutiApprovalAllTabBarView(),
                      EcutiApprovalNewTabBarView(),
                      EcutiApprovalCompletedTabBarView(),
                      EcutiApprovalRejectedTabBarView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}