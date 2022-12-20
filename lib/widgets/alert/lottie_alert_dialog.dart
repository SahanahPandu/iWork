import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../screens/dialog/custom_dialog.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../tabs/tabs.dart';

showLottieAlertDialog(
    BuildContext context, contents, Function? clearForm, dynamic passData) {
  return AlertDialog(
    title: Align(
      alignment: Alignment.topRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (clearForm != null) {
            clearForm();
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: Tabs(
                      screen: "7",
                      passData: passData,
                      title: reports,
                    )));
          } else {
            Navigator.pop(context);
          }
        },
        child: Icon(
          CustomIcon.cross,
          size: 22,
          color: blackCustom,
        ),
      ),
    ),
    insetPadding: EdgeInsets.symmetric(
      horizontal: userRole == 100 ? 20 : 0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    content: SizedBox(
      width: userRole == 100
          ? !Orientations().isTabletPortrait(context)
              ? Sizes().screenWidth(context) * 0.5
              : Sizes().screenWidth(context) * 0.65
          : Sizes().screenWidth(context) * 0.8,
      height: userRole == 100 && Orientations().isTabletPortrait(context)
          ? Sizes().screenHeight(context) * 0.2
          : Sizes().screenHeight(context) * 0.3,
      child: CustomDialog(text: contents),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
  );
}
