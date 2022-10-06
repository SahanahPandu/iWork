import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../custom_scroll/custom_scroll.dart';

int selectedIndex = -1;

@override
Widget? showBottomSheetOptions(BuildContext context, List statusList,
    double height, TextEditingController? textController,
    {String? title = "Pilih Status"}) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      constraints: const BoxConstraints(maxHeight: 380),
      context: context,
      builder: (builder) {
        return Container(
            padding: const EdgeInsets.only(top: 5),
            child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: SingleChildScrollView(
                    child: Wrap(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            thickness: 0.5,
                            color: greyCustom,
                            indent: 160,
                            endIndent: 160,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 30,
                              bottom: 10,
                            ),
                            child: Text(
                              title!,
                              style: TextStyle(
                                color: greyCustom,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 26, right: 26, top: 8),
                            child: Divider(height: 0.5),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: statusList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          if (textController != null) {
                                            textController.text =
                                                statusList[index];
                                          }
                                          selectedIndex = index;
                                        },
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 16),
                                                  child: Row(children: [
                                                    Icon(
                                                        textController?.text !=
                                                                    "" &&
                                                                selectedIndex ==
                                                                    index
                                                            ? Icons.check
                                                            : null,
                                                        color: green,
                                                        size: 18),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      statusList[index],
                                                      style: TextStyle(
                                                        color: blackCustom,
                                                        fontSize: 15,
                                                        fontWeight: textController
                                                                        ?.text !=
                                                                    "" &&
                                                                selectedIndex ==
                                                                    index
                                                            ? FontWeight.w600
                                                            : FontWeight.w400,
                                                      ),
                                                    )
                                                  ]))
                                            ]));
                                  }))
                        ])
                  ],
                ))));
      });
  return null;
}
