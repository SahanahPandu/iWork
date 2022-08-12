import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../utils/custom_icon.dart';
import 'akbk_tab_bar_view/akbk_form_tab_bar_view.dart';
import 'akbk_tab_bar_view/akbk_list_tab_bar_view.dart';

class AkbkMainTab extends StatefulWidget {
  const AkbkMainTab({Key? key}) : super(key: key);

  @override
  State<AkbkMainTab> createState() => _AkbkMainTabState();
}

class _AkbkMainTabState extends State<AkbkMainTab>
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
    return Scaffold(
        backgroundColor: white,
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
              "AKBK",
              style: TextStyle(
                fontSize: 15,
                color: grey800,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: const [
            SizedBox(
              width: 50,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(242, 246, 255, 1),
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  controller: _tabController,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey300,
                          blurRadius: 1,
                          offset: const Offset(0.0, 2.0),
                        ),
                      ]),
                  labelColor: black87,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 14),
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 13),
                  unselectedLabelColor: const Color(0xF5808691),
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
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AkbkFormTabbarView(),
                    AkbkListTabbarView(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
