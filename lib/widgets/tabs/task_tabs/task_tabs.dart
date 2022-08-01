import 'package:eswm/utils/device.dart';
import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../listview/card_list_view.dart';

class StackOverTabs extends StatefulWidget {
  const StackOverTabs({Key? key}) : super(key: key);

  @override
  StackOverTabsState createState() => StackOverTabsState();
}

class StackOverTabsState extends State<StackOverTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E2E3),
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              labelColor: black87,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
              unselectedLabelColor: const Color(0xF5808691),
              tabs: const [
                Tab(
                  text: 'Isu',
                ),
                Tab(
                  text: 'Pengesahan',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10),
                    CardListView(topCardStatus: null, type: 'Laluan'),
                  ],
                ),
                const Center(
                  child: Text(
                    'Pengesahan',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
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
