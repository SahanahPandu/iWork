import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                thickness: 0.5,
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
                thickness: 0.5,
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
                child: GestureDetector(
                  onTap: () {
                    _launchWaze(3.1392412891357626, 101.62878692150117);
                  },
                  child: Text(
                    "Waze",
                    style: TextStyle(
                      fontSize: 15,
                      color: blackCustom,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  _launchMaps(3.1392412891357626, 101.62878692150117);
                },
                child: Container(
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
              ),
            ],
          ),
        );
      });
  return null;
}

void _launchMaps(double lat, double lng) async {
  dynamic url =
      'http://maps.google.com/maps?q=${lat.toString()},${lng.toString()}';
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchWaze(double lat, double lng) async {
  var url = 'waze://?ll=${lat.toString()},${lng.toString()}';
  var fallbackUrl =
      'https://waze.com/ul?ll=${lat.toString()},${lng.toString()}&navigate=yes';
  try {
    bool launched =
        // ignore: deprecated_member_use
        await launch(url, forceSafariVC: false, forceWebView: false);
    if (!launched) {
      // ignore: deprecated_member_use
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  } catch (e) {
    // ignore: deprecated_member_use
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}
