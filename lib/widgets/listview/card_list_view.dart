import 'package:eswm/providers/jadual_api.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../providers/cuti_api.dart';
import '../../providers/jalan_api.dart';
import '../../providers/laluan_api.dart';
import '../../providers/reports_api.dart';
import '../../utils/icon/custom_icon.dart';
import '../cards/list_card.dart';

class CardListView extends StatefulWidget {
  final String type;
  final Function? topCardStatus;
  final String? screens;
  final dynamic cutiStatus;
  final dynamic passData;

  const CardListView({
    Key? key,
    required this.type,
    this.topCardStatus,
    this.screens,
    this.cutiStatus,
    this.passData,
  }) : super(key: key);

  @override
  State<CardListView> createState() => _CardListViewState();
}

class _CardListViewState extends State<CardListView> {
  getData(context) {
    Future<List<dynamic>>? list;

    if (widget.type == "Cuti") {
      list = CutiApi.getDataEcuti();
    } else if (widget.type == "Laluan" && widget.screens != 'drawer') {
      //this is for Senarai Tugas Saya in the main page
      list = LaluanApi.getDataLaluan();
    } else if (widget.type == "Laluan" && widget.screens == 'drawer') {
      //this is for Senarai Jadual Tugasan in the drawer
      list = JadualApi.getDataJadualDrawer("");
    } else if (widget.type == "Senarai Jalan") {
      list = JalanApi.getJalanData(context);
    } else if (widget.type == "Laporan") {
      list = ReportsApi.getDataLaporan(widget.passData.scMainId);
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
              if (dataFuture!.isEmpty) {
                return Center(
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
                );
              } else {
                //Filtering based on Cuti Status (if any)
                if (widget.type == "Cuti" && widget.cutiStatus != null) {
                  dataFuture.removeWhere(
                      (item) => !widget.cutiStatus.contains(item.status.code));
                }
                //Filtering based on issued laluan cards
                if (widget.type == "Laluan" && widget.screens == "isu") {
                  dataFuture.removeWhere((item) => "".contains(item.isu));
                }

                return ListView.builder(
                  physics: userRole == 200
                      ? ((widget.type == "Laluan" &&
                              (widget.screens == "drawer" ||
                                  widget.screens == "isu"))
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics())
                      : const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataFuture.length,
                  itemBuilder: (context, index) {
                    return ListCard(
                      data: dataFuture[index],
                      type: widget.type,
                      listIndex: index,
                      passData: widget.passData,
                    );
                  },
                );
              }
            }
        }
      },
    );
  }
}
