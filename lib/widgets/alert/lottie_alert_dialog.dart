import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../screens/dialog/custom_dialog.dart';
import '../../utils/custom_icon.dart';

showLottieAlertDialog(BuildContext context, contents, Function? clearForm) {
  return AlertDialog(
    title: InkWell(
      highlightColor: white,
      onTap: () {
        clearForm != null ? clearForm() : null;
        Navigator.pop(context);
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Icon(
          CustomIcon.cross,
          size: 20,
          color: blackCustom,
        ),
      ),
    ),
    insetPadding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    content: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: CustomDialog(text: contents),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  );
}
