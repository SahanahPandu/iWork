import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/custom_scroll/custom_scroll.dart';
import 'vehicle_checklist_list.dart';

class VehicleChecklistListMain extends StatefulWidget {
  const VehicleChecklistListMain({Key? key}) : super(key: key);

  @override
  State<VehicleChecklistListMain> createState() =>
      _VehicleChecklistListMainState();
}

class _VehicleChecklistListMainState extends State<VehicleChecklistListMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
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
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
            ),
            title: Center(
              child: Text(
                "Semakan Kenderaan",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: const [SizedBox(width: 50)],
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Stack(children: [
          const Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 45),
            child: VehicleChecklistList(),
          ),
          Container(
            color: white,
            padding: const EdgeInsets.fromLTRB(40, 20, 30, 15),
            child: Text("Senarai Semakan Kenderaan :",
                style: TextStyle(
                    color: blackCustom,
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
        ]),
      ),
    );
  }
}
