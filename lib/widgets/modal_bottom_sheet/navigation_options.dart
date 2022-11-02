import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';

Widget? showNavigationOptions(BuildContext context) {
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
          height: Sizes().screenHeight(context) * 0.3,
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
              const Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  left: 24,
                  bottom: 16,
                ),
                child: Text(
                  "Navigasi ke lokasi",
                  style: TextStyle(
                    color: Color(0xff969696),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color(0xffE5E5E5),
                indent: 25,
                endIndent: 25,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 24,
                  top: 10,
                  right: 24,
                ),
                child: Text(
                  "Waze",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Text(
                  "Google Maps",
                  style: TextStyle(
                    fontSize: 15,
                    color: blackCustom,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      });
  return null;
}
