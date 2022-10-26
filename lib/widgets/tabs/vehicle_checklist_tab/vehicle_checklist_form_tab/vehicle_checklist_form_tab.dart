import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../models/vc/vc.dart';
import '../../../../utils/device/orientations.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../utils/icon/custom_icon.dart';
import 'vehicle_checklist_form_tab_bar_view/vehicle_checklist_form_after_tab_bar_view.dart';
import 'vehicle_checklist_form_tab_bar_view/vehicle_checklist_form_before_tab_bar_view.dart';

class VehicleChecklistFormTab extends StatefulWidget {
  final VehicleChecklist data;

  const VehicleChecklistFormTab({Key? key, required this.data})
      : super(key: key);

  @override
  State<VehicleChecklistFormTab> createState() =>
      _VehicleChecklistFormTabState();
}

class _VehicleChecklistFormTabState extends State<VehicleChecklistFormTab>
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
                  "Semakan Kenderaan",
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
        body: Padding(
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
                        text: 'Sebelum',
                      ),
                      Tab(
                        text: 'Selepas',
                      ),
                    ],
                    onTap: (t) {
                      print(_tabController.index);
                    },
                  ),
                ),
              ),
              ScrollConfiguration(
                behavior:
                    const MaterialScrollBehavior().copyWith(overscroll: false),
                child: Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      VehicleChecklistFormBeforeTabbarView(data: widget.data),
                      VehicleChecklistFormAfterTabbarView(data: widget.data),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
