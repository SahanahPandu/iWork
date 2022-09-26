import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/tabs/task_tab/task_tab.dart';

class SupervisorOld extends StatefulWidget {
  const SupervisorOld({Key? key}) : super(key: key);

  @override
  State<SupervisorOld> createState() => _SupervisorOldState();
}

class _SupervisorOldState extends State<SupervisorOld> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: transparent,
              expandedHeight: 260,
              flexibleSpace: FlexibleSpaceBar(
                background: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                        child: Text(
                          "Hi, Suhaimi!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: Sizes().screenHeight(context) * 0.26,
                          child: const TodayTaskCard(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          width: Sizes().screenWidth(context),
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 8,
              ),
              Expanded(child: TaskStackOverTab()),
            ],
          ),
        ),
      ),
    );
  }
}
