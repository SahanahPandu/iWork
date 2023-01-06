import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../config/string.dart';
import '../../data/data_drawer.dart';
import '../../providers/authenticate/logout_api.dart';
import '../../screens/e_cuti/e_cuti.dart';
import '../../screens/reports/report_list_main.dart';
import '../../screens/schedule_all/schedule_all_main.dart';
import '../../screens/schedule_issue/report/report_approval_list_main.dart';
import '../../screens/schedule_shift/schedule_shift_main.dart';
import '../../screens/vehicle_checklist/vehicle_checklist_approval/vehicle_checklist_approval_main.dart';
import '../../screens/vehicle_checklist/vehicle_checklist_list/vehicle_checklist_list_main.dart';
import '../../screens/workshop_vehicle/workshop_vehicle_main.dart';
import '../../utils/device/devices.dart';
import '../../utils/device/sizes.dart';
import '../../utils/font/font.dart';
import '../../utils/storage/local_pref.dart';
import '../alert/alert_dialog.dart';
import '../alert/toast.dart';
import '../tabs/akbk_tab/akbk_tab.dart';
import '../tabs/ecuti_approval_tab/ecuti_approval_tab.dart';

class DrawerBuild extends StatefulWidget {
  const DrawerBuild({Key? key}) : super(key: key);

  @override
  State<DrawerBuild> createState() => _DrawerBuildState();
}

class _DrawerBuildState extends State<DrawerBuild> {
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
          child: Theme(
            data: Theme.of(context).copyWith(useMaterial3: true),
            child: ListView(children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 110,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: white,
                    ),
                    child: Devices().isPhone()
                        ? Row(
                            children: [
                              Stack(
                                  clipBehavior: Clip.hardEdge,
                                  alignment: AlignmentDirectional.center,
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    Container(
                                      height: 62,
                                      width: 62,
                                      decoration: BoxDecoration(
                                          color: transparent,
                                          border: Border.all(color: grey300),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.asset(
                                            userImg,
                                            height: 58,
                                            width: 58,
                                          ),
                                        ))
                                  ]),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Devices().isPhone()
                                          ? _textSize(userInfo[4]).width
                                          : _textSize(userInfo[2]).width,
                                      child: Text(
                                        Devices().isPhone()
                                            ? userInfo[4] != ''
                                                ? userInfo[4].toTitleCase()
                                                : "User"
                                            : userInfo[2].toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: blackCustom,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          userInfo[2] != ''
                                              ? userInfo[2].toUpperCase()
                                              : "User ID",
                                          style: TextStyle(
                                              color: greyCustom,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(width: 6),
                                        Icon(
                                          Icons.fiber_manual_record,
                                          size: 5,
                                          color: greyCustom,
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
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 100,
                            width: 160,
                            child: Center(child: Image.asset(splashImg)))),
              ),
              SizedBox(
                  height: Sizes().screenHeight(context) * 0.75,
                  child: Theme(
                    data: Theme.of(context).copyWith(useMaterial3: true),
                    child: ListView.builder(
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
                                for (int i = 0;
                                    i < _isHighlighted.length;
                                    i++) {
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
                        }),
                  )),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                title: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Aplikasi V0.3',
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
      ),
    );
  }

  final TextStyle textStyle =
      TextStyle(color: blackCustom, fontSize: 15, fontWeight: FontWeight.w600);

  Size _textSize(String data) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: data, style: textStyle),
        maxLines: 2,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: Sizes().screenWidth(context));
    return textPainter.size;
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
      case 600: //sam
      case 700: //rom
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
                    child: const ReportListMain()));
            break;

          case 3:
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const VehicleChecklistListMain()));
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
                    child: const ECuti(
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
                child: const ReportListMain(),
              ),
            );
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
      case 600: //sam
      case 700: //rom
        switch (idx) {
          case 1: // ECuti
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const EcutiApprovalTab()));
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
                    child: const ReportApprovalListMain()));
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
          return showAlertDialog(context, reminder, confirmLogout, cancel, yes);
        }).then((actionText) async {
      if (actionText == yes) {
        String result = await LogoutApi.logoutUser();
        if (result == 'ok') {
          LocalPrefs.removeLoginCredential();
          _clearSavedFlag();
          Navigator.pushNamedAndRemoveUntil(
              context, '/splash', ModalRoute.withName('/splash'));
        } else {
          showErrorToast(
              context, "Log keluar tidak berjaya. Sila cuba semula!");
        }
      }
    });
  }

  void _clearSavedFlag() {
    otherDate = false;
    selectedDate = "";
    vcStatus = 0;
    onGoingTask = false;
  }
}
