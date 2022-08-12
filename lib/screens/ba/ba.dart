import 'package:flutter/material.dart';

//import files

import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/tabs/task_tab/task_tab.dart';

class BA extends StatefulWidget {
  const BA({Key? key}) : super(key: key);

  @override
  State<BA> createState() => _BAState();
}

class _BAState extends State<BA> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            expandedHeight: 260,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                    child: Text(
                      "Hi, Ali Shabin!",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TodayTaskCard(),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 5),
          Expanded(child: TaskStackOverTab()),
        ],
      ),
    );
  }
}
