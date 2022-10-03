import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';
import '../../utils/device/sizes.dart';

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
      context: context,
      builder: (builder) {
        return SizedBox(
          height: Sizes().screenHeight(context) * height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 3,
              ),
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
                padding: EdgeInsets.only(left: 26, right: 26, top: 8),
                child: Divider(height: 0.5),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          selectedIndex = index;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    statusList[index],
                                    style: TextStyle(
                                      color: blackCustom,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                      textController?.text != "" &&
                                              selectedIndex == index
                                          ? CustomIcon.checkedBox
                                          : null,
                                      color: greenCustom,
                                      size: 18)
                                ],
                              ),
                            )
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
