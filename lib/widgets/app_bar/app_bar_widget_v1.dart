import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/custom_icon.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  final String? title;
  final List<Widget>?
      listOfWidget; //pass list of widgets if there are icons to display on the right side of the app bar

  const AppBarWidget({Key? key, this.title, this.listOfWidget})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarBgColor,
      elevation: 2,
      shadowColor: const Color(0xffF5F5F5),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          CustomIcon.arrowBack,
          color: blackCustom,
          size: 22,
        ),
      ),
      iconTheme: IconThemeData(color: black87),
      centerTitle: true,
      title: Text(
        widget.title ?? "",
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff2B2B2B),
          fontWeight: FontWeight.w400,
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
