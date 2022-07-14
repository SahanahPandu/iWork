// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/cards/e_cuti/pra/pra_e_cuti_list_details.dart';

class ListCard extends StatefulWidget {
  double cardHeight;
  dynamic data;
  String type;

  ListCard(
      {Key? key,
      required this.cardHeight,
      required this.data,
      required this.type})
      : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  Widget? getWidget() {
    if (widget.type == "Cuti") {
      return PraECutiListDetails(data: widget.data);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SizedBox(
        //height: widget.cardHeight,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.white,
          elevation: 14,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: getWidget(),
          ),
        ),
      ),
    );
  }
}
