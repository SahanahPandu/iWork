import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../providers/penyelia_api.dart';

Widget? showListOfSupervisor(passContext, updateSvNameList) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: passContext,
      builder: (BuildContext context) {
        bool value = false;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.1,
                maxChildSize: 0.5,
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
                      FutureBuilder<List>(
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
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: dataFuture!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            updateSvNameList(dataFuture[index]);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: userRole == 100
                                                ? const EdgeInsets.symmetric(
                                                    vertical: 23, horizontal: 5)
                                                : const EdgeInsets.all(0),
                                            // margin:
                                            //     const EdgeInsets.only(bottom: 24),
                                            child: CheckboxListTile(
                                              value: value,
                                              title: Text(
                                                dataFuture[index].name,
                                                style: const TextStyle(
                                                  color: Color(0xff2b2b2b),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  value = newValue!;
                                                });
                                              },
                                            ),
                                            // Text(
                                            //   dataFuture[index].name,
                                            //   style: const TextStyle(
                                            //     color: Color(0xff2b2b2b),
                                            //     fontSize: 14,
                                            //     fontWeight: FontWeight.w400,
                                            //   ),
                                            // ),
                                          ),
                                        );
                                      });
                                }
                            }
                          }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
  return null;
}
