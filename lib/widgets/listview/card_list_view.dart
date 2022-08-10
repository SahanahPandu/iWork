// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/cards/list_card.dart';
import 'package:eswm/providers/cuti_api.dart';
import 'package:eswm/providers/laluan_api.dart';
import 'package:eswm/providers/jalan_api.dart';
import 'package:eswm/providers/reports_api.dart';

import '../../config/config.dart';

class CardListView extends StatefulWidget {
  String type;
  final Function? topCardStatus;
  String? screens;

  CardListView({
    Key? key,
    required this.type,
    this.topCardStatus,
    this.screens,
  }) : super(key: key);

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  final ScrollController _controller = ScrollController();

  getData(context) {
    Future<List<dynamic>>? list;

    if (widget.type == "Cuti") {
      list = CutiApi.getCutiData(context);
    } else if (widget.type == "Laluan") {
      list = LaluanApi.getLaluanData(context);
    } else if (widget.type == "Senarai Jalan") {
      list = JalanApi.getJalanData(context);
    } else if (widget.type == "Laporan") {
      list = ReportsApi.getReportsData(context);
    } else {
      list = null;
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollNotification) {
        if (userRole == 200) {
          if (widget.type == "Laluan") {
            if (scrollNotification is ScrollStartNotification ||
                scrollNotification is ScrollUpdateNotification) {
              if (widget.topCardStatus != null) {
                widget.topCardStatus!(true);
              }
            }
            if (scrollNotification is OverscrollNotification) {
              if (widget.topCardStatus != null) {
                widget.topCardStatus!(false);
              }
            }
          }

          return true;
        }
        return false;
      },
      child: FutureBuilder<List>(
        future: getData(context),
        builder: (context, snapshot) {
          final dataFuture = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Some error occurred!"),
                );
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: userRole == 200 ? 15 : 0,
                  ),
                  child: ListView.builder(
                    physics: userRole == 200
                        ? ((widget.type == "Cuti" ||
                                (widget.type == "Laporan" &&
                                    widget.screens !=
                                        "isu")) //means not from isu list
                            ? const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              )
                            : (widget.type == "Laluan" &&
                                    (widget.screens == "drawer" ||
                                        widget.screens == "isu"))
                                ? const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  )
                                : widget.type ==
                                        "Laluan" // cannot add bouncing because , it makes the list cannot scroll down when blue card is hidden
                                    ? const AlwaysScrollableScrollPhysics()
                                    : const NeverScrollableScrollPhysics())
                        : const BouncingScrollPhysics(),
                    controller: userRole == 200 ? _controller : null,
                    shrinkWrap: true,
                    itemCount: dataFuture!.length,
                    itemBuilder: (context, index) {
                      return ListCard(
                        data: dataFuture[index],
                        type: widget.type,
                        listIndex: index,
                      );
                    },
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
