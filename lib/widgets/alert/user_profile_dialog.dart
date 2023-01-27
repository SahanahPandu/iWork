import 'package:eswm/utils/font/font.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../models/task/compactor/data/workers/workers.dart';
import '../../utils/calendar/time.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';

showUserProfileDialog(BuildContext context, Worker? workerData, String photo) {
  return AlertDialog(
    title: Align(
      alignment: Alignment.topRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pop(context);
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
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Orientations().isTabletPortrait(context)
                  ? const Color(0xec3f67ea)
                  : const Color(0xec4357d0),
              radius: 35,
              child: CircleAvatar(
                  backgroundColor: transparent,
                  backgroundImage: NetworkImage(photo),
                  radius: 32)),
          const SizedBox(height: 15),
          Text(
              workerData != null
                  ? workerData.userId!.userDetail!.name!.toTitleCase()
                  : "Tiada data pekerja",
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          Text(
              workerData != null
                  ? workerData.userId!.userRoles![0].roleDesc!
                  : "",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: greyCustom,
                  fontSize: 14)),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    Text("Mula Kerja",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    Text("Tamat Kerja",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600))
                  ],
                ),
                TableRow(
                  children: [
                    Text(
                        workerData == null || workerData.clockInAt == "--:--"
                            ? "--:--"
                            : Time.convertToHM(workerData.clockInAt!),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: greyCustom)),
                    Text(
                        workerData == null || workerData.clockOutAt == "--:--"
                            ? "--:--"
                            : Time.convertToHM(workerData.clockOutAt!),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: greyCustom))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
  );
}
