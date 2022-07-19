import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../config/resource.dart';
import '../../data/data_drawer.dart';
import '../../screens/home/home.dart';
import '../../screens/vehicle_checklist/vehicle_checklist.dart';
import '../../utils/device.dart';

class DrawerBuild extends StatelessWidget {
  DrawerBuild({Key? key}) : super(key: key);

  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(physics: const BouncingScrollPhysics(), children: [
        DrawerHeader(
            decoration: BoxDecoration(
              color: transparent,
            ),
            child: Image.asset(headerImg)),
        SizedBox(
            height: _device.screenHeight(context),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: getList().length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(
                      getList()[index].iconName,
                      color: getList()[index].titleColor,
                    ),
                    title: Text(
                      getList()[index].title,
                      style: TextStyle(color: getList()[index].titleColor),
                    ),
                    onTap: () {
                      getRoute(index, context);
                    },
                  );
                }))
      ]),
    );
  }

  void getRoute(int index, BuildContext context) {
    int idx = index;
    if (_device.isPhone()) {
      switch (idx) {
        default:
          Navigator.pop(context);
      }
    } else {
      switch (idx) {
        case 3:
          Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleChecklist()));
          break;
        default:
          Navigator.pop(context);
      }
    }
  }

  List getList() {
    return _device.isPhone() ? praDrawerList : compactorDrawerList;
  }
}
