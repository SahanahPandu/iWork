import 'package:eswm/models/laluan.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/palette.dart';

class ContactButton extends StatefulWidget {
  final Laluan? data;

  const ContactButton({Key? key, required this.data}) : super(key: key);

  @override
  State<ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: callColor,
      child: const Icon(
        Icons.wifi_calling_3_rounded,
        size: 24,
      ),
      onPressed: () {
        _callNumber(widget.data!.leaderContact);
      },
    );
  }

  _callNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
