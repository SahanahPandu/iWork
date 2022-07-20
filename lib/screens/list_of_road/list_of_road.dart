import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/listview/card_list_view.dart';

class ListOfRoad extends StatefulWidget {
  const ListOfRoad({Key? key}) : super(key: key);

  @override
  State<ListOfRoad> createState() => _ListOfRoadState();
}

class _ListOfRoadState extends State<ListOfRoad> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Senarai Jalan"),
        ),
        CardListView(type: "Senarai Jalan", topCardStatus: null)
      ],
    );
  }
}
