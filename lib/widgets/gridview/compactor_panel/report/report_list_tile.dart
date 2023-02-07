// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/dimen.dart';
import '../../../../config/palette.dart';
import '../../../../models/report/report_details/report_details_info.dart';
import '../../../../models/report/report_list/report_paging.dart';
import '../../../../providers/report/reports_api.dart';
import '../../../../utils/icon/custom_icon.dart';
import 'report_list_tile_detail.dart';

enum ReportLoadMoreStatus { loading, stable }

class ReportListTile extends StatefulWidget {
  final ReportPaging reports;
  final Map<String, Object?>?passData;

  const ReportListTile({Key? key, required this.reports, this.passData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ReportListTileState();
}

class ReportListTileState extends State<ReportListTile> {
  ReportLoadMoreStatus loadMoreStatus = ReportLoadMoreStatus.stable;
  final ScrollController scrollController = ScrollController();
  late List<ReportDetailsInfo?>? reports;
  int currentPageNumber = -1;
  String nextPageUrl = "";
  int lastPageNumber = -1;
  CancelableOperation? reportOperation;

  bool completeLoading = false;

  @override
  void initState() {
    reports = widget.reports.data;
    currentPageNumber = widget.reports.currentPage!;
    nextPageUrl =
        widget.reports.nextPageUrl != null ? widget.reports.nextPageUrl! : "";
    lastPageNumber = widget.reports.lastPage!;
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

      child: widget.reports.data!.isEmpty
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
                  itemCount: reports!.length,
                  itemBuilder: (_, index) {
                    return ReportListTileDetail(report: reports![index]!);
                  },
                ),
                loadMoreStatus == ReportLoadMoreStatus.loading
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
          if (loadMoreStatus == ReportLoadMoreStatus.stable) {
            loadMoreStatus = ReportLoadMoreStatus.loading;
            reportOperation = CancelableOperation.fromFuture(
                ReportsApi.fetchReportList(
                        context, currentPageNumber + 1, widget.passData)
                    .then((reportsObject) {
              currentPageNumber = reportsObject.currentPage!;

              setState(() {
                reports!.addAll(reportsObject.data);
                loadMoreStatus = ReportLoadMoreStatus.stable;
              });
            }));
          }
        }
      }
    }

    return true;
  }
}
