// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../config/palette.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../config/config.dart';
import '../../../models/vc/list/data/vc_data.dart';
import '../../../models/vc/list/data/vc_data/vc_list_detail.dart';
import '../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../widgets/tabs/vehicle_checklist_tab/vehicle_checklist_approval_tab/vehicle_checklist_approval_tab.dart';
import '../vehicle_checklist_approval/vehicle_checklist_approval_details.dart';
import 'vehicle_checklist_list_tile_detail.dart';

enum VehicleChecklistLoadMoreStatus { loading, stable }

class VehicleChecklistListTile extends StatefulWidget {
  final VCData vcList;
  final Map<String, Object>? passData;

  const VehicleChecklistListTile(
      {Key? key, required this.vcList, this.passData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => VehicleChecklistListTileState();
}

class VehicleChecklistListTileState extends State<VehicleChecklistListTile> {
  VehicleChecklistLoadMoreStatus loadMoreStatus =
      VehicleChecklistLoadMoreStatus.stable;
  final ScrollController scrollController = ScrollController();
  late List<VCListDetail?> vcList;
  int currentPageNumber = -1;
  String nextPageUrl = "";
  int lastPageNumber = -1;
  CancelableOperation? reportOperation;

  bool completeLoading = false;

  @override
  void initState() {
    vcList = widget.vcList.data!;
    currentPageNumber = widget.vcList.currentPage!;
    nextPageUrl =
        widget.vcList.nextPageUrl != null ? widget.vcList.nextPageUrl! : "";
    lastPageNumber = widget.vcList.lastPage!;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (reportOperation != null) {
      reportOperation!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,

      child: widget.vcList.data!.isEmpty
          ? Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CustomIcon.exclamation,
                        color: Colors.orange, size: 14),
                    const SizedBox(width: 10),
                    Text("Tiada rekod dijumpai",
                        style: TextStyle(color: grey500)),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: vcList.length,
                  itemBuilder: (context, index) {
                    return userRole == 100
                        ? VehicleChecklistListTileDetail(
                            vcDetail: vcList[index]!)
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: VehicleChecklistApprovalTab(
                                          vcData: vcList[index],
                                          isDrawer: true)));
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: cardShadowColor,
                                            offset: const Offset(0, 2),
                                            blurRadius: 10,
                                            spreadRadius: 0.5)
                                      ],
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: VehicleChecklistApprovalDetails(
                                          data: vcList[index]!,
                                          isDrawer: true,
                                        )))),
                          );
                  },
                ),
                loadMoreStatus == VehicleChecklistLoadMoreStatus.loading
                    ? const CircularProgressIndicator()
                    : Container()
              ],
            ), // GridView.builder
    );
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (nextPageUrl != "" || currentPageNumber != lastPageNumber) {
          if (loadMoreStatus == VehicleChecklistLoadMoreStatus.stable) {
            loadMoreStatus = VehicleChecklistLoadMoreStatus.loading;
            reportOperation = CancelableOperation.fromFuture(
                VehicleChecklistApi.fetchVehicleChecklistList(
                        context, currentPageNumber + 1, widget.passData)
                    .then((vcObject) {
              currentPageNumber = vcObject.currentPage!;

              setState(() {
                vcList.addAll(vcObject.data!);
                loadMoreStatus = VehicleChecklistLoadMoreStatus.stable;
              });
            }));
          }
        }
      }
    }

    return true;
  }
}
