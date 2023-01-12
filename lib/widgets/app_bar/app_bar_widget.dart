import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  final Color? bgColor;
  final IconData leadingIcon;
  final String? title;
  final List<Widget>?
      listOfWidget; //pass list of widgets if there are icons to display on the right side of the app bar

  const AppBarWidget({
    Key? key,
    this.bgColor,
    required this.leadingIcon,
    this.title,
    this.listOfWidget,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: barShadowColor,
            offset: const Offset(0, 3),
            blurRadius: 8,
          )
        ]),
        child: AppBar(
          backgroundColor: widget.bgColor ?? appBarBgColor,
          elevation: 0,
          shadowColor: const Color(0xffF5F5F5),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              widget.leadingIcon,
              color: blackCustom,
              size: 22,
            ),
          ),
          iconTheme: IconThemeData(color: black87),
          centerTitle: true,
          title: Text(
            widget.title ?? "",
            style: TextStyle(
              fontSize: 15,
              color: blackCustom,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: widget.listOfWidget ??
              [
                const SizedBox(
                  width: 50,
                )
              ],
        ),
      ),
    );
  }
}
