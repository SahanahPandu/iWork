// ignore_for_file: must_be_immutable

import 'package:eswm/widgets/cards/cards.dart';
import 'package:flutter/material.dart';

import '../../providers/pekerja_api.dart';

class ReassignEmployeeList extends StatefulWidget {
  String? namaLaluan;

  ReassignEmployeeList({Key? key, this.namaLaluan}) : super(key: key);

  @override
  State<ReassignEmployeeList> createState() => _ReassignEmployeeListState();
}

class _ReassignEmployeeListState extends State<ReassignEmployeeList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: PekerjaApi.getPekerjaData(context),
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
                //filtered list to show list of employee under this selected Laluan only
                if (widget.namaLaluan != null) {
                  dataFuture!.removeWhere((item) => !widget.namaLaluan!
                      .contains(
                          item.tiedLaluan)); // removed all non related staff
                  dataFuture.removeWhere((item) =>
                      item.idAttStatus == 1); // removed employee that "Hadir"
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataFuture!.length,
                      itemBuilder: (context, index) {
                        return Cards(
                          type: "Reassign Pekerja",
                          data: dataFuture[index],
                        );
                      }),
                );
              }
          }
        });
  }
}
