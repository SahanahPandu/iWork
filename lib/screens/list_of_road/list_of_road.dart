// ignore_for_file: must_be_immutable

import 'package:eswm/screens/list_of_road/list_of_road_details.dart';
import 'package:flutter/material.dart';

//import files
import '../../providers/jalan_api.dart';

class ListOfRoad extends StatefulWidget {
  int idTaman;
  ListOfRoad({Key? key, required this.idTaman}) : super(key: key);

  @override
  State<ListOfRoad> createState() => _ListOfRoadState();
}

class _ListOfRoadState extends State<ListOfRoad> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 15,
            left: 22,
            bottom: 8,
          ),
          child: Text(
            "Senarai Jalan",
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        FutureBuilder<List>(
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

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: 80,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                shadowColor: Colors.grey.shade50,
                                elevation: 5,
                                child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ListOfRoadDetails(
                                        data: newList[index], index: index)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
            }
          },
        ),
      ],
    );
  }
}
