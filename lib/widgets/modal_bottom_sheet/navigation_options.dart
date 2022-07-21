import 'package:flutter/material.dart';

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
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                width: 120,
                height: 100,
                child: Image.asset(
                  'assets/image/waze_logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                width: 120,
                height: 100,
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
