import 'package:flutter/material.dart';

//import files
import '../../utils/device/sizes.dart';
import '../../widgets/cards/today_task/today_task_card.dart';
import '../../widgets/listview/card_list_view.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Hi, Suhaimi!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: Sizes().screenHeight(context) * 0.29,
              child: const TodayTaskCard(),
            ),
          ]),
        ),
        Container(
          width: Sizes().screenWidth(context),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                child: const Center(
                  child: Text(
                    "Tugas Saya",
                    style: TextStyle(
                      color: Color(0xff2B2B2B),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CardListView(
                      type: "Laluan", topCardStatus: getTopCardStatus)),
            ],
          ),
        ),
      ],
    );
  }
}
