import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../config/string.dart';
import '../../data/data_drawer.dart';
import '../../screens/vehicle_checklist/vehicle_checklist.dart';
import '../../utils/authentication/auth.dart';
import '../../utils/device.dart';
import '../alert/alert_dialog.dart';

class DrawerBuild extends StatelessWidget {
  DrawerBuild({Key? key}) : super(key: key);

  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(physics: const BouncingScrollPhysics(), children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 80.0,
          child: DrawerHeader(
              decoration: BoxDecoration(
                color: transparent,
              ),
              child: Image.asset(headerImg)),
        ),
        SizedBox(
            height: _device.screenHeight(context),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _getList().length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(
                      _getList()[index].iconName,
                      color: _getList()[index].titleColor,
                    ),
                    title: Text(
                      _getList()[index].title,
                      style: TextStyle(color: _getList()[index].titleColor),
                    ),
                    onTap: () {
                      _getDrawerRoute(index, context);
                    },
                  );
                }))
      ]),
    );
  }

  List _getList() {
    switch (userRole) {
      case 100:
        return compactorDrawerList;
      case 200:
        return praDrawerList;
      case 300:
        return svDrawerList;
    }
    return praDrawerList;
  }

  void _getDrawerRoute(int index, BuildContext context) {
    int idx = index;
    switch (userRole) {
      case 100:
        switch (idx) {
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VehicleChecklist()));
            break;
          case 5:
            _userLogout(context);
            break;
          default:
            Navigator.pop(context);
        }
        break;
      case 200:
        switch (idx) {
          case 6:
            _userLogout(context);
            break;
          default:
            Navigator.pop(context);
        }
        break;

      case 300:
        switch (idx) {
          case 9:
            _userLogout(context);
            break;
          default:
            Navigator.pop(context);
        }
        break;
    }
  }

  void _userLogout(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return showAlertDialog(context, reminder, confirmLogout, yes, cancel);
        }).then((actionText) {
      if (actionText == yes) {
        Auth.handleLogout();
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
      }
    });
  }
}
