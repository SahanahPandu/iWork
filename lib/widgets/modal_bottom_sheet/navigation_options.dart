import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../utils/device.dart';

final Devices _device = Devices();

Widget? showNavigationOptions(BuildContext context) {
  showModalBottomSheet(
      constraints: userRole == 100
          ? (_device.isLandscape(context)
              ? const BoxConstraints(maxWidth: 500, maxHeight: 150)
              : const BoxConstraints(maxWidth: 500, maxHeight: 120))
          : null,
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
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                width: userRole == 100 ? 150 : 120,
                height: userRole == 100 ? 100 : 100,
                child: Image.asset(
                  'assets/image/waze_logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: userRole == 100 ? 150 : 120,
                height: userRole == 100 ? 100 : 100,
                child: Image.asset(
                  'assets/image/google_map_logo.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        );
      });
  return null;
}
