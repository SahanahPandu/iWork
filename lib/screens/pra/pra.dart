import 'package:eswm/widgets/listview/my_task/my_task_list.dart';
import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/cards/today_task/today_task_card.dart';

class Pra extends StatefulWidget {
  const Pra({Key? key}) : super(key: key);

  @override
  State<Pra> createState() => _PraState();
}

class _PraState extends State<Pra> {
  bool closeTopCard = false;

  void getTopCardStatus(status) {
    setState(() {
      closeTopCard = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.35;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: closeTopCard ? 0 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: size.width,
            alignment: Alignment.topCenter,
            height: closeTopCard ? 0 : categoryHeight,
            child: SizedBox(
              height: categoryHeight,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text(
                          "Hi, Suhaimi",
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const TodayTaskCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            "Tugasan Saya",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        MyTaskList(topCardStatus: getTopCardStatus),
      ],
    );
  }
}
