import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../providers/jalan_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import 'list_of_road_details.dart';

class ListOfRoad extends StatefulWidget {
  final int idTaman;

  const ListOfRoad({
    Key? key,
    required this.idTaman,
  }) : super(key: key);

  @override
  State<ListOfRoad> createState() => _ListOfRoadState();
}

class _ListOfRoadState extends State<ListOfRoad> {
  int totalJalan = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 16,
          ),
          color: const Color(0xffF7FBFF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Padding(
            padding: userRole == 100 && Orientations().isTabletPortrait(context)
                ? const EdgeInsets.only(left: 60)
                : const EdgeInsets.only(left: 32),
            child: Row(
              children: [
                Text(
                  "Senarai Jalan ",
                  style: TextStyle(
                    fontSize: 16,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
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

                  if (newList.isEmpty) {
                    return Container(
                      color: white,
                      height: userRole == 200
                          ? Sizes().screenHeight(context) * 0.24
                          : Sizes().screenHeight(context) * 0.18,
                      child: Container(
                        margin: userRole == 100 &&
                                Orientations().isTabletPortrait(context)
                            ? const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 40)
                            : const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            const Icon(CustomIcon.exclamation,
                                color: Colors.orange, size: 14),
                            const SizedBox(width: 10),
                            Text(
                              notFoundStreet,
                              style: TextStyle(color: grey400),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 0.5,
                        color: dividerColor,
                      );
                    },
                    itemCount: newList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: userRole == 100 &&
                                Orientations().isTabletPortrait(context)
                            ? const EdgeInsets.fromLTRB(60, 20, 60, 20)
                            : const EdgeInsets.fromLTRB(32, 24, 34, 20),
                        child: ListOfRoadDetails(
                          data: newList[index],
                          index: index,
                        ),
                      );
                    },
                  );
                }
            }
          },
        ),
      ],
    );
  }
}
