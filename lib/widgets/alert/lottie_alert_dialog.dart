import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../screens/dialog/custom_dialog.dart';
import '../../utils/icon/custom_icon.dart';

showLottieAlertDialog(BuildContext context, contents, Function? clearForm) {
  return AlertDialog(
    title: Align(
      alignment: Alignment.topRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          clearForm != null ? clearForm() : null;
          Navigator.pop(context);
        },
        child: Icon(
          CustomIcon.cross,
          size: 22,
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
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
  );
}
