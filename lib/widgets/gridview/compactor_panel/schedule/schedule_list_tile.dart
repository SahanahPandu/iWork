// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../models/schedule/compactor/list/data/schedule_data/schedule_data.dart';
import '../../../../models/schedule/compactor/list/schedule_list.dart';
import '../../../../providers/schedule/compactor_panel/compactor_schedule_api.dart';
import '../../../../utils/icon/custom_icon.dart';
import 'schedule_list_tile_detail.dart';

enum ScheduleLoadMoreStatus { loading, stable }

class ScheduleListTile extends StatefulWidget {
  final ScheduleList schedules;
  final Map<String, Object>? passData;

  const ScheduleListTile({Key? key, required this.schedules, this.passData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ScheduleListTileState();
}

class ScheduleListTileState extends State<ScheduleListTile> {
  ScheduleLoadMoreStatus loadMoreStatus = ScheduleLoadMoreStatus.stable;
  final ScrollController scrollController = ScrollController();
  late List<CScheduleData?>? schedules;
  int currentPageNumber = -1;
  String nextPageUrl = "";
  int lastPageNumber = -1;
  CancelableOperation? scheduleOperation;

  bool completeLoading = false;

  @override
  void initState() {
    schedules = widget.schedules.data!.data;
    currentPageNumber = widget.schedules.data!.currentPage!;
    nextPageUrl = widget.schedules.data!.nextPageUrl!;
    lastPageNumber = widget.schedules.data!.lastPage!;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (scheduleOperation != null) {
      scheduleOperation!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,

      child: widget.schedules.data!.data!.isEmpty
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
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: axisSpacing(context),
                      mainAxisSpacing: axisSpacing(context),
                      childAspectRatio: gridRatioSchedule(context)),
                  physics: const ScrollPhysics(),
                  controller: scrollController,
                  itemCount: schedules!.length,
                  itemBuilder: (_, index) {
                    return ScheduleListTileDetail(schedule: schedules![index]!);
                  },
                ),
                loadMoreStatus == ScheduleLoadMoreStatus.loading
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
          if (loadMoreStatus == ScheduleLoadMoreStatus.stable) {
            loadMoreStatus = ScheduleLoadMoreStatus.loading;
            scheduleOperation = CancelableOperation.fromFuture(
                CompactorScheduleApi.fetchCompactScheduleList(
                        context, currentPageNumber + 1, widget.passData)
                    .then((schedulesObject) {
              currentPageNumber = schedulesObject.data!.currentPage!;

              setState(() {
                schedules!.addAll(schedulesObject.data!.data!);
                loadMoreStatus = ScheduleLoadMoreStatus.stable;
              });
            }));
          }
        }
      }
    }

    return true;
  }
}
