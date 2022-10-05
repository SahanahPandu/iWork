import 'package:flutter/material.dart';

//import files
import '../../models/penyelia_checkbox.dart';
import '../../providers/penyelia_api.dart';
import '../../widgets/buttons/select_button.dart';

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
            //minChildSize: 0.1,
            //maxChildSize: 1.0,
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
                    child: const SelectButton(),
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

Widget svCheckBoxList(PenyeliaCheckBox dataPenyelia) => StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(dataPenyelia.namaPenyelia),
          value: dataPenyelia.valueCheckbox,
          activeColor: const Color(0xff34A853),
          onChanged: (newValue) =>
              setState(() => dataPenyelia.valueCheckbox = newValue!),
        );
      },
    );
