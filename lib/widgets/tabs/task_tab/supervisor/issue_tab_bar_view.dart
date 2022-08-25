import 'package:flutter/material.dart';

//import files
import '../../../listview/card_list_view.dart';

class IssueTabbarView extends StatelessWidget {
  const IssueTabbarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 10),
        Expanded(
          child: CardListView(
            type: 'Laluan',
            screens: "isu",
          ),
        ),
      ],
    );
  }
}