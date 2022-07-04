import 'package:flutter/material.dart';

//import files
import 'package:eswm/screens/e_cuti/leave_form.dart';
import '../../config/palette.dart';
import '../../config/string.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
          backgroundColor: appBackgroundColor,
          elevation: 4,
          shadowColor: Colors.white,
          centerTitle: true,
          title: Text(
            eCuti,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: grey900,
            ),
          ),
          bottom: TabBar(
            labelColor: grey900,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.green,
            indicatorWeight: 3,
            tabs: const [
              Tab(
                child: Text(
                  "Borang",
                  style: TextStyle(
                    //color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Rekod",
                  style: TextStyle(
                    //color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          LeaveForm(),
          Icon(
            Icons.directions_transit,
            size: 350,
          ),
        ]),
      ),
    );
  }
}
