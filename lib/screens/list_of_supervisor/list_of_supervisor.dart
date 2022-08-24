import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../providers/penyelia_api.dart';

void showListOfSupervisor(passContext, updateSvNameList) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: passContext,
      builder: (BuildContext context) {
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
              padding: const EdgeInsets.all(15),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                children: [
                  const Text(
                    "Senarai Penyelia",
                    style: TextStyle(
                      color: Color(0xff969696),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                                  physics: const NeverScrollableScrollPhysics(),
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
                                            : const EdgeInsets.symmetric(
                                                vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide.none,
                                            bottom: BorderSide(
                                              color: grey400,
                                              width:
                                                  userRole == 100 ? 0.3 : 0.9,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          dataFuture[index].name,
                                          style: const TextStyle(
                                            color: Color(0xff2b2b2b),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
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
      });
}
