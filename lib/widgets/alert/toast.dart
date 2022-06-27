import 'package:fluttertoast/fluttertoast.dart';

import '../../config/palette.dart';

Future showToast (String message) async {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: green,
        textColor: white);
}