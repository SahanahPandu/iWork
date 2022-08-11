import 'package:flutter/material.dart';

import '../../config/palette.dart';

@override
Widget? showAcceptanceOptions(
  BuildContext context,
  List statusList,
  double height,
  TextEditingController? textController,
) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (builder) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 30,
                  bottom: 10,
                ),
                child: Text(
                  "Pilih Status",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: statusList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          if (textController != null) {
                            textController.text = statusList[index];
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 4),
                              child: Text(
                                statusList[index],
                                style: TextStyle(
                                  color: black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Divider(height: 0.5)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      });
  return null;
}
