// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import 'package:eswm/providers/cuti_api.dart';
import 'package:eswm/widgets/cards/list_card.dart';

class CardListView extends StatefulWidget {
  String type;
  double cardHeight;

  CardListView({
    Key? key,
    required this.type,
    required this.cardHeight,
  }) : super(key: key);

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  getData(context) {
    Future<List<dynamic>>? list;

    if (widget.type == "Cuti") {
      list = CutiApi.getCutiData(context);
    } else {
      list = null;
    }

    return list;
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ListView.builder(
                    itemCount: dataFuture!.length,
                    itemBuilder: (context, index) {
                      return ListCard(
                        cardHeight: widget.cardHeight,
                        data: dataFuture[index],
                        type: widget.type,
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
