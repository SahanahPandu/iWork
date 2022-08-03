import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../config/string.dart';
import '../../data/data_drawer.dart';
import '../../screens/e_cuti/e_cuti.dart';
import '../../screens/reports/reports.dart';
import '../../screens/schedule_all/schedule_all_main.dart';
import '../../screens/schedule_issue/schedule_issue_main.dart';
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
      case 100: //compactor
        return compactorDrawerList;
      case 200: //pra
        return praDrawerList;
      case 300: //supervisor
        return svDrawerList;
      case 400: //eo
      case 500: //ba
        return eoBaDrawerList;
    }
    return praDrawerList;
  }

  void _getDrawerRoute(int index, BuildContext context) {
    int idx = index;
    switch (userRole) {
      case 100: //compactor
        switch (idx) {
          case 1:
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ScheduleAllMainScreen();
              }),
            );
            break;
          case 2: //Laporan
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportsPage(
                          screen: "6",
                          data: null,
                          dataLaluan: null,
                        )));
            break;

          case 5: //logout
            _userLogout(context);
            break;
          default:
            Navigator.pop(context);
        }
        break;
      case 200: //pra
        switch (idx) {
          case 1: //E-Cuti
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ECuti(
                          screen: "5",
                          data: null,
                        )));
            break;
          case 2:
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ScheduleAllMainScreen();
              }),
            );
            break;
          case 3: //Laporan
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportsPage(
                          screen: "6",
                          data: null,
                          dataLaluan: null,
                        )));
            break;

          case 6: //logout
            _userLogout(context);
            break;
          default:
            Navigator.pop(context);
        }
        break;

      case 300: //supervisor
      case 400: //eo
      case 500: //ba
        switch (idx) {
          case 2:
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ScheduleAllMainScreen();
              }),
            );
            break;
          case 4: //report
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const ScheduleIssueMainScreen(
                  fromHome: false,
                  issueType: 'laporan',
                );
              }),
            );
            break;
          case 9: //logout
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
