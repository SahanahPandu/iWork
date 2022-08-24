import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../config/string.dart';
import '../../data/data_drawer.dart';
import '../../screens/e_cuti/e_cuti.dart';
import '../../screens/e_cuti/supervisor/supervisor_leave_list.dart';
import '../../screens/reports/reports.dart';
import '../../screens/schedule_all/schedule_all_main.dart';
import '../../screens/schedule_issue/schedule_issue_main.dart';
import '../../screens/schedule_shift/schedule_shift_main.dart';
import '../../screens/vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_main.dart';
import '../../screens/workshop_vehicle/workshop_vehicle_main.dart';
import '../../utils/authentication/auth.dart';
import '../../utils/device.dart';
import '../alert/alert_dialog.dart';
import '../tabs/akbk_tab/akbk_tab.dart';

class DrawerBuild extends StatefulWidget {
  const DrawerBuild({Key? key}) : super(key: key);

  @override
  State<DrawerBuild> createState() => _DrawerBuildState();
}

class _DrawerBuildState extends State<DrawerBuild> {
  final Devices _device = Devices();
  String name = "";
  String role = "";
  final List<bool> _isHighlighted = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  _loadUserRole() {
    switch (userRole) {
      case 100:
        role = "Pemandu";
        break;
      case 200:
        role = "PRA";
        break;
      case 300:
        role = "Penyelia";
        break;
      case 400:
        role = "Executive Officer";
        break;
      case 500:
        role = "Branch Admin";
        break;
      case 600:
        role = "SAM";
        break;
      case 700:
        role = "ROM";
        break;
      case 800:
        role = "Mechanic";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(14), bottomRight: Radius.circular(14)),
        child: Drawer(
          backgroundColor: white,
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            Container(
              alignment: Alignment.centerLeft,
              height: _device.isLandscape(context) ? 80 : 110.0,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: transparent,
                  ),
                  child: Row(
                    children: [
                      Stack(
                          clipBehavior: Clip.hardEdge,
                          alignment: AlignmentDirectional.center,
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              height: _device.isLandscape(context) ? 52 : 62,
                              width: _device.isLandscape(context) ? 52 : 62,
                              decoration: BoxDecoration(
                                  color: transparent,
                                  border: Border.all(color: grey300),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                            ),
                            Padding(
                              padding: _device.isLandscape(context)
                                  ? const EdgeInsets.all(2)
                                  : const EdgeInsets.all(0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Image.asset(
                                      userImg,
                                      height: _device.isLandscape(context)
                                          ? 50
                                          : 58,
                                      width: _device.isLandscape(context)
                                          ? 50
                                          : 58,
                                    ),
                                  )),
                            )
                          ]),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '''Muhammad Amiruddin Bin \nAriffin''',
                            overflow: TextOverflow.visible,
                            maxLines: 2,
                            style: TextStyle(
                                color: blackCustom,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "SWK2210020  •",
                                style: TextStyle(
                                    color: greyCustom,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                role,
                                style: TextStyle(
                                    color: greyCustom,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
                height: _device.screenHeight(context) * 0.75,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _getList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListTile(
                          minLeadingWidth: 25,
                          tileColor:
                              _isHighlighted[index] ? activeBoxColor : null,
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  _isHighlighted[index]
                                      ? _getList()[index].iconFill
                                      : _getList()[index].iconOutline,
                                  color: _isHighlighted[index]
                                      ? activeColor
                                      : _getList()[index].titleColor,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                          title: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _getList()[index].title,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: _isHighlighted[index]
                                      ? activeColor
                                      : _getList()[index].titleColor,
                                  fontWeight: _isHighlighted[index]
                                      ? FontWeight.w500
                                      : FontWeight.w400),
                            ),
                          ),
                          onTap: () {
                            for (int i = 0; i < _isHighlighted.length; i++) {
                              setState(() {
                                if (index == i) {
                                  _isHighlighted[index] = true;
                                } else {
                                  _isHighlighted[i] = false;
                                }
                              });
                            }
                            _getDrawerRoute(index, context);
                          },
                        ),
                      );
                    })),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Aplikasi V0.2',
                  style: (TextStyle(
                      color: grey500,
                      fontWeight: FontWeight.w500,
                      fontSize: 12)),
                ),
              ),
              onTap: () {},
            ),
          ]),
        ),
      ),
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
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ScheduleAllMainScreen()));
            break;
          case 2: //Laporan
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ReportsPage(
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
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ECuti(
                      screen: "5",
                      data: null,
                    )));
            break;
          case 2: //Jadual Tugasan
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ScheduleAllMainScreen()));
            break;
          case 3: //Laporan
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ReportsPage(
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
          case 1: // ECuti
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const SupervisorLeaveList()));
            break;
          case 2: // Jadual tugasan
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ScheduleAllMainScreen()));
            break;
          case 3: // Anjakan Jadual
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ScheduleShiftMain()));
            break;
          case 4: // Report
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ScheduleIssueMainScreen(
                      fromHome: false,
                      issueType: 'laporan',
                    )));
            break;
          case 5: // AKBK form
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const AkbkMainTab()));
            break;
          case 6: // Vehicle Checklist Approval
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const VehicleChecklistApprovalMain()));
            break;
          case 7: // Workshop Vehicle
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const WorkshopVehicleMain()));
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
            context, '/splash', ModalRoute.withName('/splash'));
      }
    });
  }
}
