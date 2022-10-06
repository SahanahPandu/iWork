import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../models/penyelia_checkbox.dart';
import '../../providers/penyelia_api.dart';

List<dynamic> selectedName = [];

Widget? showListOfSupervisor(passContext, updateSvNameList) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: passContext,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            builder: (_, scrollController) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xff969696),
                    indent: 170,
                    endIndent: 170,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Pilih Penyelia",
                    style: TextStyle(
                      color: Color(0xff969696),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xffE5E5E5),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: FutureBuilder<List>(
                        future: PenyeliaApi.getPenyeliaData(passContext),
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
                                  child: Text("Some error occured!"),
                                );
                              } else {
                                List<PenyeliaCheckBox>? newListData = dataFuture
                                    ?.map((data) => PenyeliaCheckBox(
                                        idPenyelia: data.id,
                                        namaPenyelia: data.name))
                                    .toList();

                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: newListData!.length,
                                    itemBuilder: (context, index) {
                                      return svCheckBoxList(newListData[index]);
                                    });
                              }
                          }
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    child: selectButton(
                        passContext, updateSvNameList, selectedName),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
  return null;
}

Widget selectButton(
    BuildContext passContext, Function updateSvNameList, selectedName) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: const Color(0xff34A853),
        shadowColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusCircular),
        )),
    onPressed: () {
      Navigator.pop(passContext);
      updateSvNameList(selectedName);
    },
    child: const Text(
      "Pilih",
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget svCheckBoxList(PenyeliaCheckBox dataPenyelia) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(dataPenyelia.namaPenyelia),
            value: dataPenyelia.valueCheckbox,
            activeColor: const Color(0xff34A853),
            onChanged: (newValue) {
              //add selected/tick sv name into new list
              //removed name from new list if untick
              if (newValue == true) {
                selectedName.add(dataPenyelia);
              } else {
                selectedName.remove(dataPenyelia);
              }

              setState(() => dataPenyelia.valueCheckbox = newValue!);
            });
      },
    );
