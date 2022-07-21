// ignore_for_file: must_be_immutable

import 'package:eswm/providers/jalan_api.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/providers/cuti_api.dart';
import 'package:eswm/widgets/cards/list_card.dart';
import 'package:eswm/providers/laluan_api.dart';

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
  //ScrollController controller = ScrollController();

  getData(context) {
    Future<List<dynamic>>? list;

    if (widget.type == "Cuti") {
      list = CutiApi.getCutiData(context);
    } else if (widget.type == "Laluan") {
      list = LaluanApi.getLaluanData(context);
    } else if (widget.type == "Senarai Jalan") {
      list = JalanApi.getJalanData(context);
    } else {
      list = null;
    }

    return list;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.type == "Laluan") {
  //     controller.addListener(() {
  //       widget.topCardStatus(controller.offset > 50);
  //     });
  //   }
  // }

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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ListView.builder(
                    //controller: controller,
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
