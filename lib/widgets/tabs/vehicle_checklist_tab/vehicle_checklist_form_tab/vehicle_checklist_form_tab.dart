import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/palette.dart';
import '../../../../config/string.dart';
import '../../../../models/task/compactor/compactor_task.dart';
import '../../../../models/vc/list/data/vc_data/vc_list_detail.dart';
import '../../../../utils/calendar/date.dart';
import '../../../../utils/device/orientations.dart';
import '../../../../utils/device/sizes.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../alert/alert_dialog.dart';
import '../../../alert/toast.dart';
import 'vehicle_checklist_form_tab_bar_view/vehicle_checklist_form_after_tab_bar_view.dart';
import 'vehicle_checklist_form_tab_bar_view/vehicle_checklist_form_before_tab_bar_view.dart';

class VehicleChecklistFormTab extends StatefulWidget {
  final CompactorTask? compactorData;
  final VCListDetail? vcListData;
  final int? idx;

  const VehicleChecklistFormTab({
    Key? key,
    this.compactorData,
    this.vcListData,
    this.idx,
  }) : super(key: key);

  @override
  State<VehicleChecklistFormTab> createState() =>
      _VehicleChecklistFormTabState();
}

class _VehicleChecklistFormTabState extends State<VehicleChecklistFormTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showAlertOnBack = false;

  @override
  void initState() {
    if (widget.idx == 1) {
      _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    } else {
      _tabController = TabController(length: 2, vsync: this);
    }
    showAlertOnBack = (selectedNewDate == '') &&
        (widget.vcListData == null ||
            (widget.vcListData!.createdAt.toString().split(' ')[0] ==
                Date.getTheDate(DateTime.now(), '', "yyyy-MM-dd", 'ms'))) &&
        (vcStatus == 0 || vcStatus == 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// Show alert when user

        if (showAlertOnBack) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showAlertDialog(
                    context,
                    reminder,
                    "Adakah anda pasti untuk kembali ke halaman utama? Data yang diisi akan hilang.",
                    cancel,
                    yes);
              }).then((actionText) {
            if (actionText == yes) {
              Navigator.pop(context);
            }
          });
        }
        return true;
      },
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
                    if (showAlertOnBack) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return showAlertDialog(
                                context,
                                reminder,
                                "Adakah anda pasti untuk kembali ke halaman utama? Data yang diisi akan hilang.",
                                cancel,
                                yes);
                          }).then((actionText) {
                        if (actionText == yes) {
                          Navigator.pop(context);
                        }
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon:
                      Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
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
                      onTap: (index) {
                        /// Tab "Selepas" (index = 1) is clicked
                        if (index == 1) {
                          /// if past/future date with no vc after data
                          if (selectedNewDate != '' && otherDate) {
                            if ((vcStatus == 1 ||
                                    vcStatus == 2 ||
                                    vcStatus == 3) &&
                                widget.compactorData!.data.vehicleChecklistId!
                                        .statusCode!.code ==
                                    "VC1") {
                              _tabController.index = 0;
                              showInfoToast(context,
                                  "Tiada rekod Semakan Kenderaan (Selepas Balik) pada hari ${Date.getTheDate(selectedNewDate, "yyyy-MM-dd", "dd/MM/yyyy", "ms")}");
                            }
                          } else {
                            if (widget.vcListData != null) {
                              if (widget.vcListData!.statusCode!.code ==
                                  "VC1") {
                                _tabController.index = 0;

                                /// if today's date with no vc after data and
                                /// after vc is still need to be disabled (vcStatus != 3) from app drawer listing
                                if (widget.vcListData!.createdAt
                                            .toString()
                                            .split(' ')[0] ==
                                        Date.getTheDate(DateTime.now(), '',
                                            "yyyy-MM-dd", 'ms') &&
                                    vcStatus != 3) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return showAlertDialog(context, "Notis",
                                            afterVcInactive, "", "Kembali");
                                      }).then((actionText) {
                                    if (actionText == "Kembali") {
                                      //Navigator.pop(context);
                                    }
                                  });
                                }

                                /// if today's date with no vc after data and
                                /// after vc need to be enabled to be filled (vcStatus == 3) from app drawer listing
                                /// enable to switch Selepas tab
                                else if (widget.vcListData!.createdAt
                                            .toString()
                                            .split(' ')[0] ==
                                        Date.getTheDate(DateTime.now(), '',
                                            "yyyy-MM-dd", 'ms') &&
                                    vcStatus == 3) {
                                  _tabController.index = 1;
                                }

                                /// if past date with no vc after data from app drawer listing
                                else {
                                  showInfoToast(context,
                                      "Tiada rekod Semakan Kenderaan (Selepas Balik) pada hari ${Date.getTheDate(widget.vcListData!.createdAt, "yyyy-MM-dd", "dd/MM/yyyy", "ms")}");
                                }
                              }
                            } else {
                              /// if today's date with no vc after data from main page
                              if (vcStatus == 0 ||
                                  vcStatus == 1 ||
                                  vcStatus == 2) {
                                _tabController.index = 0;
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return showAlertDialog(context, "Notis",
                                          afterVcInactive, "", "Kembali");
                                    }).then((actionText) {
                                  if (actionText == "Kembali") {
                                    //Navigator.pop(context);
                                  }
                                });
                              }
                            }
                          }
                        }
                      },
                    ),
                  ),
                ),
                ScrollConfiguration(
                  behavior: const MaterialScrollBehavior()
                      .copyWith(overscroll: false),
                  child: Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        widget.vcListData != null
                            ? VehicleChecklistFormBeforeTabbarView(
                                vcListData: widget.vcListData)
                            : VehicleChecklistFormBeforeTabbarView(
                                compactorData: widget.compactorData),
                        widget.vcListData != null
                            ? VehicleChecklistFormAfterTabbarView(
                                vcListData: widget.vcListData)
                            : VehicleChecklistFormAfterTabbarView(
                                compactorData: widget.compactorData),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
