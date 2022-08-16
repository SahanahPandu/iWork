// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  String title;
  List<Widget>?
      listOfWidget; //pass list of widgets if there are icons to display on the right side of the app bar

  AppBarWidget({Key? key, required this.title, this.listOfWidget})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarBgColor,
      elevation: 1,
      shadowColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          CustomIcon.arrowBack,
          color: Colors.grey.shade900,
          size: 18,
        ),
      ),
      title: Center(
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      actions: widget.listOfWidget ??
          [
            const SizedBox(
              width: 50,
            )
          ],
    );
  }
}
