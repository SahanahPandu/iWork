// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:eswm/models/ecuti/ecuti_details.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/config.dart';
import '../../../../config/dimen.dart';
import '../../../models/ecuti/ecuti_paging.dart';
import '../../../providers/cuti_api.dart';
import 'ecuti_list_tile_detail.dart';

enum ECutiLoadMoreStatus { loading, stable }

class ECutiListTile extends StatefulWidget {
  final EcutiPaging eCutis;
  final Map<String, Object?>? passData;

  const ECutiListTile({Key? key, required this.eCutis, this.passData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ECutiListTileState();
}

class ECutiListTileState extends State<ECutiListTile> {
  ECutiLoadMoreStatus loadMoreStatus = ECutiLoadMoreStatus.stable;
  final ScrollController scrollController = ScrollController();
  late List<EcutiDetails?>? ecutis;
  int currentPageNumber = -1;
  String nextPageUrl = "";
  int lastPageNumber = -1;
  CancelableOperation? eCutiOperation;

  bool completeLoading = false;

  @override
  void initState() {
    ecutis = widget.eCutis.data;
    currentPageNumber = widget.eCutis.currentPage!;
    nextPageUrl =
        widget.eCutis.nextPageUrl != null ? widget.eCutis.nextPageUrl! : "";
    lastPageNumber = widget.eCutis.lastPage!;
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    if (eCutiOperation != null) {
      eCutiOperation!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,

      child: /*widget.eCutis.data == null
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
          : */
          Stack(
        children: [
          userRole == 100
              ? GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: axisSpacing(context),
                      mainAxisSpacing: axisSpacing(context),
                      childAspectRatio: gridRatioSchedule(context)),
                  physics: const ScrollPhysics(),
                  controller: scrollController,
                  itemCount: ecutis!.length,
                  itemBuilder: (_, index) {
                    return ECutiListTileDetail(ecuti: ecutis![index]!);
                  },
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  controller: scrollController,
                  itemCount: ecutis!.length,
                  itemBuilder: (_, index) {
                    return ECutiListTileDetail(
                        ecuti: ecutis![index]!, index: index);
                  },
                ),
          loadMoreStatus == ECutiLoadMoreStatus.loading
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
          if (loadMoreStatus == ECutiLoadMoreStatus.stable) {
            loadMoreStatus = ECutiLoadMoreStatus.loading;
            eCutiOperation = CancelableOperation.fromFuture(
                CutiApi.fetchECutiList(
                        context, currentPageNumber + 1, widget.passData)
                    .then((reportsObject) {
              currentPageNumber = reportsObject.currentPage!;

              setState(() {
                ecutis!.addAll(reportsObject.data);
                loadMoreStatus = ECutiLoadMoreStatus.stable;
              });
            }));
          }
        }
      }
    }

    return true;
  }
}
