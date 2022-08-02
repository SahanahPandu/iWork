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
  final dynamic topCardStatus;

  CardListView({
    Key? key,
    required this.type,
    required this.topCardStatus,
  }) : super(key: key);

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  ScrollController controllerListview = ScrollController();

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
  void initState() {
    super.initState();
    //if (widget.type == "Laluan") {
    controllerListview.addListener(() {
      //   if (controllerListview.offset > 50) {
      //     widget.topCardStatus(true);
      //     // } else if (controllerListview.offset < 50) {

      //   }
      //   else if(controllerListview.offset < 50){
      //     widget.topCardStatus(false);
      //     print("false");
      //   }
      //widget.topCardStatus(controllerListview.offset > 50);
      // print("offset: ${controllerListview.offset.toString()}");
    });
    //}
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
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
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: userRole == 200 ? 15 : 0,
                  ),
                  child: ListView.builder(
                    physics: userRole == 200
                        ? const AlwaysScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),
                    // controller: widget.type == "Laluan" && userRole != 300
                    //     ? controllerListview
                    //     : null,
                    //reverse: true,
                    controller: controllerListview,
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
                ),
              );
            }
        }
      },
    );
  }
}
