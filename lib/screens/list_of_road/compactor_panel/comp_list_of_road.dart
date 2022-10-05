import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../providers/jalan_api.dart';
import '../../../utils/device/orientations.dart';
import '../list_of_road_details.dart';

class CompListOfRoad extends StatefulWidget {
  final int idTaman;
  final String nameTaman;

  const CompListOfRoad(
      {Key? key, required this.idTaman, required this.nameTaman})
      : super(key: key);

  @override
  State<CompListOfRoad> createState() => _CompListOfRoadState();
}

class _CompListOfRoadState extends State<CompListOfRoad> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadowColor: white54,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(
              top: 20,
              left: 25,
              bottom: 20,
            ),
            child: Text(
              "Senarai Jalan di ${widget.nameTaman}",
              style: TextStyle(
                fontSize: 16,
                color: black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            constraints: Orientations().isLandscape(context)
                ? const BoxConstraints(maxHeight: 360)
                : const BoxConstraints(maxHeight: 420),
            child: FutureBuilder<List>(
                future: JalanApi.getJalanData(context),
                builder: (context, snapshot) {
                  final dataFuture = snapshot.data;
                  List<dynamic> newList = [];

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
                        for (int i = 0; i < dataFuture!.length; i++) {
                          if (dataFuture[i].idTaman == widget.idTaman) {
                            newList.add(dataFuture[i]);
                          }
                        }
                        if (newList.isEmpty) {
                          return SizedBox(
                            height: 50,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                              alignment: Alignment.topLeft,
                              color: const Color(0xFFFFFFFF),
                              child: Text(
                                "Tiada senarai jalan dijumpa!",
                                style: TextStyle(color: grey400),
                              ),
                            ),
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newList.length,
                            itemBuilder: (context, index) {
                              if (index % 2 == 0) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    height: 70,
                                    child: Container(
                                      color: const Color(0xF3F3F9FF),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: ListOfRoadDetails(
                                              data: newList[index],
                                              index: index)),
                                    ),
                                  ),
                                );
                              }
                              return GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  height: 70,
                                  child: Container(
                                    color: const Color(0xF3FFFFFF),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ListOfRoadDetails(
                                            data: newList[index],
                                            index: index)),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
